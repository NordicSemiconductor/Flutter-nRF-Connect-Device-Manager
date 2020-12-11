#!/bin/sh

export PATH="$PATH":"/usr/local/Caskroom/flutter/1.22.3/flutter/.pub-cache/bin"

protoc --dart_out=./../../lib/gen/ ./flutter_mcu.proto
protoc --swift_out=./../../ios/Classes/gen/ ./flutter_mcu.proto
#protoc --java_out=./../ios/gen ./flutterdfu.protoex