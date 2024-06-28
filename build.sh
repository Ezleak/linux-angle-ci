git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$PWD/depot_tools
git clone https://chromium.googlesource.com/angle/angle
pushd angle
python scripts/bootstrap.py
gclient sync
./build/install-build-deps.sh
gn gen out/Release --args='target_os="android" angle_enable_hlsl=true angle_enable_gl=true target_cpu="arm64" is_debug=false angle_enable_glsl=true angle_enable_swiftshader=false angle_enable_gl_desktop_frontend=true angle_enable_vulkan=true'
autoninja -C out/Release libEGL libGLESv2
popd
mkdir ./artifacts
cp angle/out/Release/*.so ./artifacts/ > /dev/null || :
