if (typeof MCUManager === 'undefined') {
  console.error('McuMgrFlutter: MCUManager class not found. Ensure mcumgr.js is loaded.')
}

window.McuMgrFlutter = {
  managers: new Map(),

  _log: function (msg) {
    console.log(`[McuMgrFlutter] ${msg}`)
    window.dispatchEvent(new CustomEvent('mcumgr_log', { detail: { message: msg } }))
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

          const onConn = () => {
            connResolve()
          }

          mgr.onConnect(() => {
            this._log('Device connected (callback).')
            connResolve()
          })

          mgr.onDisconnect((err) => {
            connReject(err || 'Disconnected during connection phase')
          })
        })

        for (const img of images) {
          const slot = img.image || 0
          this._log(`Uploading ${img.data.byteLength} bytes to slot ${slot}...`)
          await uploadImage(img.data, slot)
        }

        window.dispatchEvent(new CustomEvent('mcumgr_state', { detail: { deviceId, state: 'success' } }))
        resolve()

        mgr.disconnect()
        this.managers.delete(deviceId)
      } catch (e) {
        this._log(`Flow Error: ${e}`)
        window.dispatchEvent(new CustomEvent('mcumgr_state', { detail: { deviceId, state: 'error', error: e.toString() } }))
        reject(e)

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
