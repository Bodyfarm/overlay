# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vmpk/vmpk-0.5.1.ebuild,v 1.2 2013/03/02 22:05:06 hwoarang Exp $

EAPI=4

inherit cmake-utils eutils

DESCRIPTION="Virtual MIDI Piano Keyboard"
HOMEPAGE="http://vmpk.sourceforge.net/"
SRC_URI="mirror://sourceforge/vmpk/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5
	dev-qt/linguist-tools:5
	>=media-sound/drumstick-1.0.0
	dev-qt/qtx11extras:5
	x11-libs/libxcb
	dbus? ( dev-qt/qtdbus:5 )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	dev-libs/libxslt
"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	local mycmakeargs=(
		"$(cmake-utils_use_enable dbus DBUS)"
	)
	cmake-utils_src_configure
}
