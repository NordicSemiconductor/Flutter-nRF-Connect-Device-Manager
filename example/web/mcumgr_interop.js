// This file acts as a bridge between Dart/Flutter and the mcumgr-web JS library.
// It assumes a global 'McuManager' class or similar stands available from a loaded script.

window.McuMgrFlutter = {
  _managers: {},

  // Start an update
  // images: Object containing {image: int, data: Uint8Array}
  update: async function (deviceId, images, config) {
    console.log(`[McuMgrFlutter] via JS: update called for ${deviceId}`)

    try {
      // 1. Retrieve the BluetoothDevice object
      let device

      // Feature detect getDevices
      if (navigator.bluetooth && typeof navigator.bluetooth.getDevices === 'function') {
        const devices = await navigator.bluetooth.getDevices()
        device = devices.find((d) => d.id === deviceId)
      }

      // If we couldn't find it via getDevices (or it's not supported),
      // we must ask the user to select it again to get a fresh handle.
      // This is often required on Web if the previous handle was from a different "session"
      // or if we just want to be sure we have permission.
      if (!device) {
        console.log(`[McuMgrFlutter] Device not found in getDevices(), requesting device...`)
        // We can try to filter by the device ID if we assume it's stable,
        // BUT usually on web users prefer to see the list.
        // We'll require the user to pick the device that matches.

        // Note: We'll accept ANY Nordic DFU / SMP service device for now,
        // hoping the user picks the right one.
        try {
          device = await navigator.bluetooth.requestDevice({
            filters: [{ services: ['8e400001-f315-4f60-9fb8-838830daea50'] }], // SMP Service UUID
            optionalServices: ['8e400001-f315-4f60-9fb8-838830daea50'],
          })
        } catch (err) {
          // Fallback to accept all devices if specific service not found in advertisement
          device = await navigator.bluetooth.requestDevice({
            acceptAllDevices: true,
            optionalServices: ['8e400001-f315-4f60-9fb8-838830daea50'],
          })
        }
      }

      if (!device) {
        throw new Error(`Device not selected or found.`)
      }

      // Verify it matches if we care about ID persistence (optional check)
      if (deviceId && deviceId !== device.id) {
        console.warn(
          `[McuMgrFlutter] Selected device ID ${device.id} differs from expected ${deviceId}. Proceeding with selected device.`,
        )
        // We might want to update our cached ID or just proceed.
      }

      if (!device.gatt.connected) {
        console.log(`[McuMgrFlutter] Connecting to GATT...`)
        await device.gatt.connect()
      }

      // 2. Construct the Image(s)
      // Assuming we are using a library compatible with 'mcumgr-web' or similar.
      // Since we don't have the library loaded yet, this is a placeholder implementation
      // that simulates the logic using standard Web Bluetooth if possible, OR wraps the library.

      // MOC IMPLEMENTATION FOR DEMO (until actual library is dropped in)
      // ---------------------------------------------------------------
      console.log(`[McuMgrFlutter] Simulating update for ${images.length} images...`)

      const updateChannel = config.updateChannel // Callback mechanism?
      // In a real implementation we would attach listeners to the McuManager instance.

      // Simulate progress
      for (let i = 0; i <= 100; i += 10) {
        await new Promise((r) => setTimeout(r, 200))
        // Call back to Dart with progress
        // This requires a dart-defined callback or using window events.
        // For simplicity, let Dart poll or we dispatch a CustomEvent.
        window.dispatchEvent(
          new CustomEvent('mcumgr_progress', {
            detail: { deviceId: deviceId, progress: i },
          }),
        )
      }

      window.dispatchEvent(
        new CustomEvent('mcumgr_state', {
          detail: { deviceId: deviceId, state: 'success' },
        }),
      )

      return 'Success'
    } catch (e) {
      console.error(e)
      window.dispatchEvent(
        new CustomEvent('mcumgr_state', {
          detail: { deviceId: deviceId, state: 'error', error: e.toString() },
        }),
      )
      throw e
    }
  },

  pause: function (deviceId) {
    console.log('Pause not implemented in mock')
  },

  resume: function (deviceId) {
    console.log('Resume not implemented in mock')
  },

  cancel: function (deviceId) {
    console.log('Cancel not implemented in mock')
  },
}
