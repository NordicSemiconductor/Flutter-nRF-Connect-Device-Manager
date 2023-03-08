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

ANDR_OUT_DIR=lite:android/src/main/kotlin/no/nordicsemi/android/mcumgr_flutter/gen

protoc --swift_out=ios/Classes/ \
    --kotlin_out=$ANDR_OUT_DIR \
    --dart_out=./ \
    lib/proto/flutter_mcu.proto # --experimental_allow_proto3_optional