FROM fedora

ENV PATCH_DIR "/src/netdev"
ENV BINUTILS_DIR $PATCH_DIR/binutils
ENV BINUTILS_REPO "git://sourceware.org/git/binutils-gdb.git"
ENV PATCH_FILE "4.patch"

WORKDIR $BINUTILS_DIR
RUN dnf install -y git gcc texinfo bison flex gcc-c++ && \
      git clone --depth=1 $BINUTILS_REPO $BINUTILS_DIR

ADD $PATCH_FILE $BINUTILS_DIR
RUN git apply $PATCH_FILE

RUN ./configure --target=bpf-elf && \
    make -j`grep -Pc '^processor\t' /proc/cpuinfo`
WORKDIR $BINUTILS_DIR/gas/testsuite/gas/bpf
