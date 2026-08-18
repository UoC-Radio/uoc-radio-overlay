# Copyright 2019-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Studio User"
ACCT_USER_ID=1001
ACCT_USER_HOME=/home/studiouser
ACCT_USER_HOME_OWNER=studiouser:users
ACCT_USER_HOME_PERMS=0755
ACCT_USER_SHELL=/bin/bash
ACCT_USER_GROUPS=( users audio video cdrom wheel pipewire realtime )

KEYWORDS="amd64"

acct-user_add_deps
