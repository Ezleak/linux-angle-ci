git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$PWD/depot_tools
git clone https://chromium.googlesource.com/angle/angle
pushd angle
python scripts/bootstrap.py
gclient sync
./build/install-build-deps.sh
gn gen out/Android-arm64 --args='target_os="android" angle_enable_hlsl=false angle_enable_gl=true target_cpu="arm64" is_debug=false angle_enable_glsl=true angle_enable_essl=true angle_enable_swiftshader=true angle_enable_vulkan=true'
autoninja -C out/Android-arm64
popd
mkdir ./artifacts
cp angle/out/Android-arm64/*.so ./artifacts/ > /dev/null || :
