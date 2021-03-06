# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/v4l2loopback/v4l2loopback-0.8.0.ebuild,v 1.1 2014/03/04 21:42:45 naota Exp $

EAPI=4

inherit linux-mod vcs-snapshot

DESCRIPTION="v4l2 loopback device which output is it's own input"
HOMEPAGE="https://github.com/umlaeute/v4l2loopback"
SRC_URI="https://github.com/umlaeute/v4l2loopback/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

CONFIG_CHECK="VIDEO_DEV"
MODULE_NAMES="v4l2loopback(video:)"
BUILD_TARGETS="all"

DEPEND="|| ( >sys-kernel/gentoo-sources-3.18 >sys-kernel/vanilla-sources-3.18 )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s/strict_strtoul/kstrtoul/" v4l2loopback.c
}

src_compile() {
	linux-mod_src_compile
	if use examples; then
		cd "${S}"/examples
		emake
	fi
}

src_install() {
	linux-mod_src_install
	dosbin utils/v4l2loopback-ctl
	dodoc doc/kernel_debugging.txt
	dohtml doc/v4l2.html
	if use examples; then
		dosbin examples/yuv4mpeg_to_v4l2
		docinto examples
		dodoc examples/{*.sh,*.c,Makefile}
	fi
}
