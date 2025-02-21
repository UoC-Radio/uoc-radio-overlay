# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
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
IUSE="debug opus vorbis mp3"
DEPEND=">=media-video/ffmpeg-6.0.0[mp3?,opus?,vorbis?,libsoxr]
	>=media-video/pipewire-1.2.0
	>=dev-libs/libxml2-2.12.0"
RDEPEND=${DEPEND}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_with debug)
}
