# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit git-r3
inherit autotools

DESCRIPTION="An audio clip scheduler for use in radio broadcasting"
HOMEPAGE="https://github.com/UoC-Radio/audio-scheduler"
SRC_URI=""
EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/UoC-Radio/audio-scheduler.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
DEPEND=">=media-libs/gstreamer-1.0.0
	>=media-libs/gst-plugins-good-1.0.0
	>=media-libs/gst-plugins-bad-1.0.0
	>=dev-libs/libxml2-2.9.0"
RDEPEND=${DEPEND}

src_prepare() {
   eautoreconf
}

src_configure() {
	econf $(use_with debug)
}

src_compile() {
   emake
}

src_install() {
   emake DESTDIR="${D}" install
}

