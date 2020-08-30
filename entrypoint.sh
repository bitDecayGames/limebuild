#!/bin/sh -l

echo "ls -la /var/haxelib"
ls -la /var/haxelib
# not sure why it is having me do this agian, but it is
echo "haxelib setup /var/haxelib"
haxelib setup /var/haxelib
haxelib version
haxelib path lime
lime --version
