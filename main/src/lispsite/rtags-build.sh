LLVM_CONFIG=/usr/lib64/llvm

rm -rf rtags
git clone --recursive https://github.com/Andersbakken/rtags.git

#https://github.com/Andersbakken/rtags/wiki/Installing-RTags
cd ./rtags
mkdir build
cd build
cmake ..
make
make install


