FROM fedora

ENV PATCH_DIR "/src/netdev/"
ENV BINUTILS_DIR $PATCH_DIR/binutils

RUN dnf install -y git
RUN git clone --depth=1 git://sourceware.org/git/binutils-gdb.git $BINUTILS_DIR
WORKDIR $BINUTILS_DIR
ADD x.patch $BINUTILS_DIR
RUN git apply x.patch
RUN dnf install -y gcc texinfo bison flex
RUN ./configure
RUN make
