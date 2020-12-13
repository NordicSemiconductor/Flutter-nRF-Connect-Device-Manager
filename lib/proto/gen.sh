#!/bin/sh

export PATH="$PATH":"/usr/local/Caskroom/flutter/1.22.3/flutter/.pub-cache/bin"

protoc --dart_out=./../../lib/gen/ ./flutter_mcu.proto # --experimental_allow_proto3_optional
protoc --swift_out=./../../ios/Classes/gen/ ./flutter_mcu.proto # --experimental_allow_proto3_optional
#protoc --java_out=./../ios/gen ./flutterdfu.protoex