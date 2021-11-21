#!/bin/sh

# which protoc
# if [ $? -eq 0 ]; then
#     echo 'Protobuf is ready...'
# else
#     echo 'Installing protobuf'
#     brew install protobuf
#     echo 'Installing swift-protobuf'
#     brew install swift-protobuf
#     echo 'building dart proto'
# fi

export PATH="$PATH":"$HOME/.pub-cache/bin"
# dart pub install 
# dart pub global activate protoc_plugin 

protoc --dart_out=./ lib/proto/flutter_mcu.proto # --experimental_allow_proto3_optional
protoc --swift_out=ios/Classes/ lib/proto/flutter_mcu.proto # --experimental_allow_proto3_optional
protoc --java_out=lite:android/src/main/kotlin/no/nordicsemi/android/mcumgr_flutter/gen/ lib/proto/flutter_mcu.proto # --experimental_allow_proto3_optional