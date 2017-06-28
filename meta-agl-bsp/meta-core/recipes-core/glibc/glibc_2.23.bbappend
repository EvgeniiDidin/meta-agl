FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# include fix for CVE-2017-1000366
SRCREV = "d990d79610362f823292f9d869b84b4ec4491159"

# already in above revision
SRC_URI_remove = "file://CVE-2016-3706.patch"
SRC_URI_remove = "file://CVE-2016-4429.patch"
SRC_URI_remove = "file://CVE-2016-1234.patch"
SRC_URI_remove = "file://CVE-2016-3075.patch"
SRC_URI_remove = "file://CVE-2016-5417.patch"
