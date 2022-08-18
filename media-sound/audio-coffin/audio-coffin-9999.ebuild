# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3
inherit autotools

DESCRIPTION="An audio recorder/logger for jack that takes your secrets to the grave"
HOMEPAGE="https://github.com/UoC-Radio/audio-coffin"
SRC_URI=""
EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/UoC-Radio/audio-coffin.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="virtual/jack
	>=media-libs/soxr-0.1.1
	>=media-libs/libsndfile-1.0.26"
RDEPEND=${DEPEND}

src_prepare() {
	default
	eautoreconf
}
