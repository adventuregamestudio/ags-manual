AC_PREREQ([2.71])
AC_INIT([ags-manual], [0.10.3])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Werror -Wall foreign])
AM_SILENT_RULES([yes])

AGS_PROG_PANDOC([$srcdir/lua/write_feature_check.lua])

AC_ARG_VAR([CHMCMD], [path to chmcmd])
AC_ARG_VAR([HHC], [path to hhc])

AC_ARG_WITH([chmcmd],
    [AS_HELP_STRING([--with-chmcmd],
        [compile with Free Pascal CHM compiler @<:@default=no@:>@])],
    [],
    [: m4_divert_text([DEFAULTS], [with_chmcmd=no])])

AS_IF([test "x${with_chmcmd}" != xno],
    [AS_IF([test "x${CHMCMD}" = x],
         [AC_PATH_PROG([CHMCMD], [chmcmd])])],
    [AS_IF([test "x${HHC}" = x],
         [AC_PATH_PROG([HHC], [hhc])])])

AM_CONDITIONAL([BUILD_CHM_WITH_CHMCMD],
    [test "x${with_chmcmd}" != xno && test "x${CHMCMD}" != x])
AM_CONDITIONAL([BUILD_CHM_WITH_HHC],
    [test "x${with_chmcmd}" = xno && test "x${HHC}" != x])
AM_CONDITIONAL([BUILD_CHM],
    [(test "x${with_chmcmd}" != xno && test "x${CHMCMD}" != x ) || \
     (test "x${with_chmcmd}" = xno && test "x${HHC}" != x)])

AC_CONFIG_LINKS([source/index.md:source/index.md])
AC_CONFIG_SRCDIR([source/index.md])
AC_CONFIG_LINKS([source/_Sidebar.md:source/_Sidebar.md])
AC_CONFIG_SRCDIR([source/_Sidebar.md])
AC_CONFIG_FILES([Makefile])

m4_define([IMAGEFILES_LIST],
    [m4_flatten(m4_chomp(m4_quote(m4_esyscmd([git -C source ls-files 'images/*']))))])
m4_define([TOPFILES_LIST],
    [m4_flatten(m4_chomp(m4_quote(m4_esyscmd([git -C source ls-files ':(exclude)*/*' ':(exclude)_*' ':(exclude)index.md']))))])

AM_COND_IF([BUILD_CHM],
    [m4_foreach_w([var], IMAGEFILES_LIST,
        [AC_CONFIG_LINKS(source/var:source/var)])
     AC_CONFIG_LINKS([source/ags-help.stp:htmlhelp/ags-help.stp])])

m4_define([BASENAME_LIST_NO_INDEX], [m4_bpatsubst(TOPFILES_LIST, [\.[^.]+\( \|$\)], [\1])])
m4_define([BASENAME_LIST], [BASENAME_LIST_NO_INDEX index])

AC_SUBST([HTM_FILES], ["m4_map_args_w(BASENAME_LIST, [[ source/]], [[.htm]])"])
AC_SUBST([HTML_FILES], ["m4_map_args_w(BASENAME_LIST, [[ source/]], [[.html]])"])
AC_SUBST([IMAGE_FILES], ["m4_map_args_w(IMAGEFILES_LIST, [[ source/]])"])
AC_SUBST([METADATA_FILES], ["m4_map_args_w(BASENAME_LIST_NO_INDEX, [[ source/]], [[.lua]])"])
AC_SUBST([TOP_FILES], ["m4_map_args_w(TOPFILES_LIST, [[ source/]])"])
AC_SUBST([HHP_FILES], ["m4_map_args_w(BASENAME_LIST, [[ ]], [[.htm]]) IMAGEFILES_LIST"])
AC_SUBST([FOOTER], ["m4_chomp(m4_quote(m4_esyscmd([git rev-parse HEAD])))"])
AC_SUBST([BRANCH_NAME], ["m4_chomp(m4_quote(m4_esyscmd([git -C source branch --show-current])))"])
AC_OUTPUT

cat << EOF

$PACKAGE_NAME $PACKAGE_VERSION

Using Pandoc: $PANDOC
EOF

AM_COND_IF([BUILD_CHM],
    [AM_COND_IF([BUILD_CHM_WITH_CHMCMD],
         [echo "Using Free Pascal CHM compiler: $CHMCMD"])
     AM_COND_IF([BUILD_CHM_WITH_HHC],
         [echo "Using Microsoft CHM compiler: $HHC"])])
