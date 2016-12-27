# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Got this from https://linuxmusicians.com/viewtopic.php?p=66866
# and modified it

EAPI=5
inherit git-r3

DESCRIPTION="Collection of tools useful for audio production"
HOMEPAGE="http://kxstudio.linuxaudio.org/"
SRC_URI=""
EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/falkTX/Cadence.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+a2jmidid +capture pulseaudio +ladish"
#requires jack2, python3 for pyqt4 and dbus-python
#ladish etc are not compile-time or runtime dependencies,
#the apps will use them if they are present during runtime
DEPEND="virtual/jack
   dev-python/PyQt4[examples]
   dev-python/dbus-python
   pulseaudio? ( media-sound/pulseaudio[jack] )"
RDEPEND=${DEPEND}

src_compile() {
   emake
}

src_install() {
   emake DESTDIR="${D}" install
}

