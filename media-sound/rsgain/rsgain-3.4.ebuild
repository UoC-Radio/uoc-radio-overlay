# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source: Written from scratch for sunset-repo overlay

EAPI=8

inherit cmake

DESCRIPTION="A simple, but powerful ReplayGain 2.0 tagging utility"
HOMEPAGE="https://github.com/complexlogic/rsgain"
SRC_URI="https://github.com/complexlogic/${PN}/releases/download/v${PV}/${P}-source.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	>=media-libs/libebur128-1.2.4
	>=media-libs/taglib-1.11.1
	>=media-video/ffmpeg-4.2.4
	dev-libs/libfmt
	dev-libs/inih
	sys-libs/zlib
"

RESTRICT="mirror"

RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"
