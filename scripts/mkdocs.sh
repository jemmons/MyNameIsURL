#!/bin/bash
projectPath="$(find . -name "*.xcodeproj" -not -path "./Carthage/*" -print -quit)"
dir=$(dirname "${projectPath}")
marketingVersion=$(cd "${dir}";agvtool mvers -terse1)
jazzy --module-version "${marketingVersion}" --xcodebuild-arguments "-project","${projectPath}"