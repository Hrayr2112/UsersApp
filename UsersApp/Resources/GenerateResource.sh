#!/bin/sh

RSROOT=$SRCROOT/UsersApp/Resources

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
xcassets -t swift3 "$RSROOT/Assets.xcassets" \
--output "$RSROOT/Assets.swift"

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
strings -t structured-swift4 "$RSROOT/Localizable.strings" \
--output "$RSROOT/L10n.swift"
