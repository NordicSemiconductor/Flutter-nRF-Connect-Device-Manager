#import "McumgrFlutterPlugin.h"
#if __has_include(<mcumgr_flutter/mcumgr_flutter-Swift.h>)
#import <mcumgr_flutter/mcumgr_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mcumgr_flutter-Swift.h"
#endif

@implementation McumgrFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMcumgrFlutterPlugin registerWithRegistrar:registrar];
}
@end
