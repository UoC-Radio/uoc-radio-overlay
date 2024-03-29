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
IUSE="debug jack pulseaudio alsa flac opus vorbis aac mp3 pipewire"
DEPEND=">=media-plugins/gst-plugins-meta-1.10.0[jack?,pulseaudio?,alsa?,flac?,opus?,vorbis?,aac?,mp3?]
	pipewire? ( >=media-video/pipewire-0.3.75 )
	>=media-libs/gst-plugins-bad-1.10.0
	>=dev-libs/libxml2-2.9.0"
RDEPEND=${DEPEND}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_with debug)
}
