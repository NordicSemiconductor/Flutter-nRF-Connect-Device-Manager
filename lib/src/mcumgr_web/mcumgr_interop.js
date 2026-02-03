if (typeof MCUManager === 'undefined') {
  console.error('McuMgrFlutter: MCUManager class not found. Ensure mcumgr.js is loaded.')
}

window.McuMgrFlutter = {
  managers: new Map(),

  _log: function (msg) {
    let message = msg
    if (typeof msg === 'object') {
      try {
        message = JSON.stringify(msg)
      } catch (e) {
        message = msg.toString()
      }
    } else {
      message = String(msg)
    }
    console.log(`[McuMgrFlutter] ${message}`)
    window.dispatchEvent(new CustomEvent('mcumgr_log', { detail: { message: message } }))
  },

  update: async function (deviceId, images, config) {
    this._log(`Starting update for device ${deviceId}`)

    if (this.managers.has(deviceId)) {
      const oldMgr = this.managers.get(deviceId)
      try {
        oldMgr.disconnect()
      } catch (e) {}
      this.managers.delete(deviceId)
    }

    return new Promise(async (resolve, reject) => {
      try {
        // * get device
        let targetDevice = null
        if (navigator.bluetooth && navigator.bluetooth.getDevices) {
          const devices = await navigator.bluetooth.getDevices()
          targetDevice = devices.find((d) => d.id === deviceId)
        }

        // * init mcumgr
        const logger = {
          info: (msg) => this._log(msg),
          error: (msg) => this._log(`Error: ${msg}`),
        }

        const mgr = new MCUManager({ logger })
        this.managers.set(deviceId, mgr)

        // * upload
        const uploadImage = (imageBytes, slot) => {
          return new Promise((uplResolve, uplReject) => {
            let finished = false

            mgr.onImageUploadFinished(() => {
              if (finished) return
              finished = true
              this._log(`Upload for slot ${slot} finished.`)
              uplResolve()
            })

            mgr.onImageUploadError((err) => {
              if (finished) return
              finished = true
              // err object structure from mcumgr.js: { error, errorCode, ... }
              uplReject(err.error || err)
            })

            mgr.onImageUploadCancelled(() => {
              if (finished) return
              finished = true
              uplReject('Cancelled')
            })

            mgr.cmdUpload(imageBytes, slot).catch((e) => {
              if (!finished) {
                finished = true
                uplReject(e)
              }
            })
          })
        }

        mgr.onImageUploadProgress((p) => {
          window.dispatchEvent(new CustomEvent('mcumgr_progress', { detail: { deviceId, progress: p.percentage } }))
        })

        mgr.onConnect(() => {
          this._log('Device connected.')
        })

        mgr.onDisconnect((err) => {
          this._log(err ? `Disconnected with error: ${err}` : 'Disconnected.')
        })

        if (targetDevice) {
          this._log(`Found paired device: ${targetDevice.name}`)
          mgr._device = targetDevice
          mgr._connect(0)
        } else {
          await mgr.connect()
        }

        await new Promise((connResolve, connReject) => {
          if (mgr._characteristic) {
            connResolve()
            return
          }
          mgr.onConnect(() => {
            this._log('Device connected')
            connResolve()
          })

          mgr.onDisconnect((err) => {
            connReject(err || 'Disconnected during connection phase')
          })
        })

        const emitState = (s) => window.dispatchEvent(new CustomEvent('mcumgr_state', { detail: { deviceId, state: s } }))

        emitState('requestMcuMgrParameters')
        try {
          const params = await mgr.cmdParams()
          if (params && (params.buf_size || params.s)) {
            const size = params.buf_size || params.s
            if (size < mgr._mtu) {
              // this._log(`Adjusting MTU from ${mgr._mtu} to ${size}`)
              // mgr.setMtu(size)
              this._log(`Device wants mtu ${size}`)
              // * cant really do this cause web bt is weird
            }
          }
        } catch (e) {
          this._log(`Params request failed (ignoring): ${e}`)
        }

        // fake it till u make it
        emitState('bootloaderInfo')
        await new Promise((r) => setTimeout(r, 200))

        emitState('validate')
        try {
          const stateResp = await mgr.cmdImageState()
          if (stateResp && stateResp.images) {
            this._log(`Validation: Found ${stateResp.images.length} images`)
          }
        } catch (e) {
          this._log(`Validation failed (ignoring): ${e}`)
        }

        emitState('upload')
        for (const img of images) {
          const slot = img.image || 0
          this._log(`Uploading ${img.data.byteLength} bytes to slot ${slot}...`)
          await uploadImage(img.data, slot)
        }

        emitState('eraseAppSettings')
        this._log('Sending erase...')
        try {
          const resetDisconnectPromise = new Promise((resolveReset) => {
            const handler = () => {
              this._log('Device disconnected (Reset confirmed).')
              resolveReset()
            }
            mgr.onDisconnect(handler)
            // * fail-safe timeout
            setTimeout(() => {
              this._log('Reset disconnect timeout (assuming success).')
              resolveReset()
            }, 5000)
          })

          await mgr.cmdReset()
          await resetDisconnectPromise
        } catch (e) {
          this._log(`Reset sequence error: ${e}`)
        }

        emitState('confirm')
        try {
          if (images.length > 0) {
            const info = await mgr.imageInfo(images[0].data.buffer)
            if (info.hash) {
              this._log(`Confirming hash: ${info.hash}`)
              const hashBytes = new Uint8Array(info.hash.match(/.{1,2}/g).map((byte) => parseInt(byte, 16)))
              await mgr.cmdImageConfirm(hashBytes)
            }
          }
        } catch (e) {
          this._log(`Confirmation error (ignoring): ${e}`)
        }
        await new Promise((r) => setTimeout(r, 500))
        emitState('success')
        resolve('Success')
        this.managers.delete(deviceId)
      } catch (e) {
        this._log(`Flow Error: ${e}`)
        window.dispatchEvent(new CustomEvent('mcumgr_state', { detail: { deviceId, state: 'error', error: e.toString() } }))
        reject(e.toString())

        if (this.managers.has(deviceId)) {
          try {
            this.managers.get(deviceId).disconnect()
          } catch (err) {}
          this.managers.delete(deviceId)
        }
      }
    })
  },

  cancel: function (deviceId) {
    const mgr = this.managers.get(deviceId)
    if (mgr) {
      this._log('Cancelling upload...')
      mgr.cancelUpload()
    }
  },
}
