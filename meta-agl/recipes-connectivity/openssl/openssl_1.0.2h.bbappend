# As fixed in debian package perl (5.22.2-3) [SECURITY] CVE-2016-1238
# We have to tell perl to include cwd in @INC using PERL_USE_UNSAFE_INC
# Fixed in morty release. See commit : http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?id=ffdc23ab5311b651e27c9bda16da5ddd482249fa

do_configure_prepend() {
${@'export PERL_USE_UNSAFE_INC=1' if (d.getVar("DISTRO_CODENAME", True) == "chinook") else ''}
}
