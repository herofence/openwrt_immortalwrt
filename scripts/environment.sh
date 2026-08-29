sudo apt update -qq
sudo apt full-upgrade -qq -y
# 删除 ack，修改 libgmp3-dev 和 gnutls-dev
sudo apt install -y antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
bzip2 ccache clang cmake cpio curl device-tree-compiler ecj fastjar flex gawk gettext gcc-multilib g++-multilib \
git libgnutls28-dev gperf haveged help2man intltool lib32gcc-s1 libc6-dev-i386 libelf-dev libglib2.0-dev libgmp-dev \
libltdl-dev libmpc-dev libmpfr-dev libncurses-dev libpython3-dev libreadline-dev libssl-dev libtool libyaml-dev \
lld llvm lrzsz mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python3 \
python3-pip python3-ply python3-docutils python3-pyelftools qemu-utils re2c rsync scons \
squashfs-tools subversion swig texinfo uglifyjs upx unzip vim wget xmlto xxd zlib1g-dev zstd rename
