# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit python-single-r1 xdg-utils

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/falkTX/Carla.git"
	EGIT_SUBMODULES=() # Prevent Carla-Plugins from installing
else
	SRC_URI="https://github.com/falkTX/Carla/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_PN="Carla"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="Fully-featured audio plugin host, supports many audio drivers and plugin formats"
HOMEPAGE="https://kx.studio/Applications:Carla"
LICENSE="GPL-2 LGPL-3"
SLOT="0"
IUSE="alsa gtk gtk2 opengl osc pulseaudio rdf sf2 sndfile X"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pyqt6[gui,opengl?,svg,widgets,${PYTHON_USEDEP}]')
	virtual/jack
	alsa? ( media-libs/alsa-lib )
	gtk? ( x11-libs/gtk+:3 )
	gtk2? ( x11-libs/gtk+:2 )
	osc? (
		media-libs/liblo
		media-libs/pyliblo
	)
	pulseaudio? ( media-libs/libpulse )
	rdf? ( dev-python/rdflib )
	sf2? ( media-sound/fluidsynth )
	sndfile? ( media-libs/libsndfile )
	X? ( x11-libs/libX11 )
"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "s|exec \$PYTHON|exec ${PYTHON}|" \
		data/carla \
		data/carla-control \
		data/carla-database \
		data/carla-jack-multi \
		data/carla-jack-single \
		data/carla-patchbay \
		data/carla-rack \
		data/carla-settings || die "sed failed"
	sed -i "s;/share/appdata;/share/metainfo;g" "${S}/Makefile" || die "sed failed"
	default
}

src_compile() {
	myemakeargs=(
		LIBDIR="/usr/$(get_libdir)"
	)

	# Print which options are enabled/disabled
	make features PREFIX="/usr" "${myemakeargs[@]}"

	emake PREFIX="/usr" "${myemakeargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" "${myemakeargs[@]}" install
	if ! use osc; then
		find "${D}/usr" -iname "carla-control*" | xargs rm
	fi
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
