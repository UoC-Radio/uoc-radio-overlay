# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"
[[ "${PV}" = "2.9999" ]] && inherit git-r3
inherit eutils python-single-r1 waf-utils multilib-minimal

DESCRIPTION="Jackdmp jack implemention for multi-processor machine"
HOMEPAGE="http://jackaudio.org/"

RESTRICT="mirror"
if [[ "${PV}" = "2.9999" ]]; then
	EGIT_REPO_URI="git://github.com/jackaudio/jack2.git"
	KEYWORDS=""
else
	SRC_URI="https://dl.dropbox.com/u/28869550/jack-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~ppc ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa celt dbus doc ieee1394 libsamplerate opus pam readline sndfile"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CDEPEND="${PYTHON_DEPS}
	alsa? ( media-libs/alsa-lib[${MULTILIB_USEDEP}] )
	celt? ( media-libs/celt:0[${MULTILIB_USEDEP}] )
	dbus? (
		dev-libs/expat[${MULTILIB_USEDEP}]
		sys-apps/dbus[${MULTILIB_USEDEP}]
	)
	ieee1394? ( media-libs/libffado[${MULTILIB_USEDEP}] )
	libsamplerate? ( media-libs/libsamplerate[${MULTILIB_USEDEP}] )
	opus? ( media-libs/opus[custom-modes,${MULTILIB_USEDEP}] )
	readline? ( sys-libs/readline:0 )
	sndfile? ( media-libs/libsndfile )
	abi_x86_32? ( !app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"
RDEPEND="${CDEPEND}
	dbus? ( dev-python/dbus-python[${PYTHON_USEDEP}] )
	pam? ( sys-auth/realtime-base )"

[[ "${PV}" = "2.9999" ]] || S="${WORKDIR}/jack-${PV}"

DOCS=( ChangeLog README README_NETJACK2 TODO )

# USAGE: jack2_use <flag> [feature]
jack2_use() {
	echo "--${2:-${1}}=$(usex ${1})"
}

# USAGE: jack2_multilib_native_use <flag> [feature]
jack2_multilib_native_use() {
	if multilib_is_native_abi; then
		jack2_use "${@}"
	else
		echo "--${2:-${1}}=no"
	fi
}

src_unpack() {
	if [[ "${PV}" = "2.9999" ]]; then
		git-r3_src_unpack
	else
		default
	fi
}

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local mywafconfargs=(
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		--freebob=no
		--iio=no
		--portaudio=no
		--winmme=no
		$(jack2_use alsa)
		$(jack2_use celt)
		$(usex dbus --dbus --classic)
		$(jack2_multilib_native_use doc doxygen)
		$(jack2_use ieee1394 firewire)
		$(jack2_use libsamplerate samplerate)
		$(jack2_use opus)
		$(jack2_multilib_native_use readline)
		$(jack2_multilib_native_use sndfile)
	)

	WAF_BINARY="${BUILD_DIR}"/waf waf-utils_src_configure ${mywafconfargs[@]}
}

multilib_src_compile() {
	WAF_BINARY="${BUILD_DIR}"/waf waf-utils_src_compile
}

multilib_src_install() {
	WAF_BINARY="${BUILD_DIR}"/waf waf-utils_src_install
}

multilib_src_install_all() {
	python_fix_shebang "${ED}"
}
