import 'dart:async';

import 'package:web/web.dart' as web;

class McuMgrWebLoader {
  static Future<void> loadJs() async {
    print('Attempting to load web scripts...');
    if (web.document.querySelector('script[src*="mcumgr_interop.js"]') !=
            null &&
        web.document.querySelector('script[src*="mcumgr.js"]') != null &&
        web.document.querySelector('script[src*="cbor.js"]') != null) {
      print('All mcumgr scripts already loaded');
      return;
    }

    final completer = Completer<void>();

    // Helper to load a script
    Future<void> loadScript(String src, {String? type}) {
      final scriptCompleter = Completer<void>();
      final web.HTMLScriptElement script =
          web.document.createElement('script') as web.HTMLScriptElement;
      script.src = src;
      if (type != null) script.type = type;

      script.onLoad.listen((_) {
        print('Loaded script: $src');
        scriptCompleter.complete();
      });
      script.onError.listen((e) {
        print('Failed to load script: $src');
        scriptCompleter.completeError('Failed to load $src');
      });

      web.document.head!.appendChild(script);
      return scriptCompleter.future;
    }

    try {
      await loadScript(
        'assets/packages/mcumgr_flutter/lib/src/mcumgr_web/cbor.js',
      );
      await loadScript(
        'assets/packages/mcumgr_flutter/lib/src/mcumgr_web/mcumgr.js',
      );
      await loadScript(
        'assets/packages/mcumgr_flutter/lib/src/mcumgr_web/mcumgr_interop.js',
        type: 'module',
      );

      completer.complete();
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }
}
