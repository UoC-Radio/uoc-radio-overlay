# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3
inherit autotools

DESCRIPTION="FM MPX signal generator with RDS support on top of Jack Audio Connection Kit"
HOMEPAGE="https://github.com/UoC-Radio/JMPXRDS"
SRC_URI=""
EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/UoC-Radio/JMPXRDS.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="wave-table +rtp-server"
DEPEND="virtual/jack
	>=media-libs/soxr-0.1.1
	>=sci-libs/fftw-3.0.0
	rtp-server? ( >=media-libs/gst-plugins-good-1.0.0
		      media-plugins/gst-plugins-flac:* )"
RDEPEND=${DEPEND}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_with rtp-server) $(use_with wave-table)
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
