# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit git-r3
inherit autotools

DESCRIPTION="A simple live audio streamer, intended as a replacement for DarkIce"
HOMEPAGE="https://github.com/UoC-Radio/icestreamer"
SRC_URI=""
EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/UoC-Radio/icestreamer.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa jack pulseaudio ogg opus vorbis lame"

DEPEND=">=media-plugins/gst-plugins-meta-1.10.0[alsa?,jack?,pulseaudio?,ogg?,opus?,vorbis?,lame?]
	>=media-plugins/gst-plugins-shout2-1.10.0"
RDEPEND=${DEPEND}

src_prepare() {
   eautoreconf
}

src_compile() {
   emake
}

src_install() {
   emake DESTDIR="${D}" install
}

