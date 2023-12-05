# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="Studio User"
ACCT_USER_ID=1001
ACCT_USER_HOME=/home/studiouser
ACCT_USER_HOME_OWNER=1001:users
ACCT_USER_HOME_PERMS=0755
ACCT_USER_SHELL=/bin/bash
ACCT_USER_GROUPS=( users audio video cdrom wheel pipewire )
acct-user_add_deps
