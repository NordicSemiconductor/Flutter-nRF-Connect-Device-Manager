#!/bin/sh

which protoc
if [ $? -eq 0 ]; then
    echo 'Protobuf is ready...'
else
    echo 'Installing protobuf'
    brew install protobuf
    echo 'Installing swift-protobuf'
    brew install swift-protobuf
    echo 'building dart proto'
fi

dart pub install 
export PATH="$PATH":"$HOME/.pub-cache/bin"
dart pub global activate protoc_plugin 

protoc --dart_out=./ --experimental_allow_proto3_optional lib/proto/flutter_mcu.proto --plugin ~/.pub-cache/bin/protoc-gen-dart
protoc --swift_out=ios/Classes/ lib/proto/flutter_mcu.proto --experimental_allow_proto3_optional

# ANDR_OUT_DIR=lite:android/src/main/kotlin/no/nordicsemi/android/mcumgr_flutter/gen
# protoc --kotlin_out=$ANDR_OUT_DIR lib/proto/flutter_mcu.proto --experimental_allow_proto3_optional