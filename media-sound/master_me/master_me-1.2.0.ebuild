# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Automatic audio mastering plugin for live-streaming and broadcasting"
HOMEPAGE="https://github.com/trummerschlunk/master_me"
LICENSE="GPL-3"
KEYWORDS="amd64"
IUSE="+lv2 ladspa +jack"
SLOT="0"
SRC_URI="https://github.com/trummerschlunk/master_me/releases/download/${PV}/master_me-${PV}.tar.xz"

DEPEND=">=media-libs/libglvnd-1.6.0[X]
	>=x11-libs/libX11-1.8.6
	>=x11-libs/libXcursor-1.2.1
	>=x11-libs/libXext-1.3.5
	>=x11-libs/libXrandr-1.5.3"
RDEPEND="${DEPEND}
	jack? ( virtual/jack )
	virtual/opengl"

src_install() {
	if use jack; then
		dobin bin/master_me
	fi

	if use lv2; then
		insinto /lib/lv2
		doins -r bin/master_me.lv2
	fi

	if use ladspa; then
		insinto /lib/ladspa
		doins bin/master_me-ladspa.*
	fi
}
