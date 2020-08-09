FROM fedora:latest

RUN dnf -y update \ 
 && dnf -y install \
           autoconf \
           automake \
           bsdtar \
           bzip2-devel \
           curl \
           expat-devel \
           gcc \
           gcc-c++ \
           git \
           glibc-headers \
           libacl-devel \
           libarchive-devel \
           libbsd-devel \
           libtool \
           libxml2-devel \
           libzstd-devel \
           lz4-devel \
           m4 \
           make \
           musl-devel \
           openssl-devel \
           pkgconf \
	   svn \
           xz-devel \
           xz-lzma-compat \
           zlib-devel \
 && dnf clean all

RUN git clone -q https://github.com/freebsd/pkg
RUN cd pkg \
 && ./configure \
 && sed -i'' -e '/#include "pkg.h"/i#include <bsd/stdlib.h>' libpkg/pkg_jobs_conflicts.c \
 && sed -i'' -e '/#include "pkgcli.h"/i#include <grp.h>' src/utils.c \
 && make \
 && make install

RUN mkdir -p /freebsd/usr/local/etc /repo \
 && curl https://download.freebsd.org/ftp/releases/amd64/12.1-RELEASE/base.txz | \
		bsdtar -xf - -C /freebsd ./lib ./usr/lib ./usr/libdata ./usr/include ./usr/share/keys ./etc \
 && echo 'ABI = "FreeBSD:12:amd64"; REPOS_DIR = ["/freebsd/etc/pkg"]; REPO_AUTOUPDATE = NO; RUN_SCRIPTS = NO;' > \
    /freebsd/usr/local/etc/pkg.conf \
 && ln -s /freebsd/usr/share/keys /usr/share/keys \
 && pkg -r /freebsd update

ENTRYPOINT ["pkg", "-r", "/freebsd"]
