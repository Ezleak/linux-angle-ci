git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$PWD/depot_tools
git clone https://chromium.googlesource.com/angle/angle
pushd angle
python scripts/bootstrap.py
gclient sync
./build/install-build-deps.sh
gn gen out/Android-${{matrix.arch}} --args='target_cpu="arm64" is_debug=false angle_enable_swiftshader=true angle_enable_vulkan=true'
autoninja -C out/Android-${{matrix.arch}}
popd
mkdir ./artifacts
cp angle/out/Android-${{matrix.arch}}/*.so ./artifacts/ > /dev/null || :
