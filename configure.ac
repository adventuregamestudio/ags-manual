AC_PREREQ([2.71])
AC_INIT([ags-manual], [0.6.6])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([-Werror -Wall foreign subdir-objects])
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

AM_CONDITIONAL([BUILD_CHM_WITH_CHMCMD], [test "x${with_chmcmd}" != xno && test "x${CHMCMD}" != x])
AM_CONDITIONAL([BUILD_CHM_WITH_HHC], [test "x${with_chmcmd}" = xno && test "x${HHC}" != x])
AM_CONDITIONAL([BUILD_CHM], [(test "x${with_chmcmd}" != xno && test "x${CHMCMD}" != x ) || (test "x${with_chmcmd}" = xno && test "x${HHC}" != x)])

AC_CONFIG_LINKS([source/index.md:source/Home.md])
AC_CONFIG_SRCDIR([source/Home.md])
AC_CONFIG_FILES([Makefile])

m4_define([PLIST], m4_flatten(m4_quote(m4_include([plist]))))
m4_define([IMAGEFILES_LIST])
m4_define([TOPFILES_LIST])

m4_foreach_w([var], PLIST,
    [m4_cond([m4_index(var, [/])], [-1],
                 [m4_append([TOPFILES_LIST], var, [ ])],
             [m4_index(var, [images/])], [0],
                 [m4_append([IMAGEFILES_LIST], var, [ ])])])

AM_COND_IF([BUILD_CHM],
    [m4_foreach_w([var], IMAGEFILES_LIST,
        [AC_CONFIG_LINKS(source/var:source/var)])
     AC_CONFIG_LINKS([source/ags-help.stp:htmlhelp/ags-help.stp])])

m4_define([BASENAME_LIST], [m4_bpatsubst(TOPFILES_LIST, [\.[^.]+\( \|$\)], [\1])])
m4_define([BASENAME_NO_INDEX_LIST], [m4_bpatsubst(BASENAME_LIST, [ index\|index ], [])])

AC_SUBST([HTM_FILES], ["m4_map_args_w(BASENAME_LIST, [[ source/]], [[.htm]])"])
AC_SUBST([HTML_FILES], ["m4_map_args_w(BASENAME_LIST, [[ source/]], [[.html]])"])
AC_SUBST([IMAGE_FILES], ["m4_map_args_w(IMAGEFILES_LIST, [[ source/]])"])
AC_SUBST([METADATA_FILES], ["m4_map_args_w(BASENAME_NO_INDEX_LIST, [[ source/]], [[.lua]])"])
AC_SUBST([SOURCE_FILES], ["m4_map_args_w(PLIST, [[ source/]])"])
AC_SUBST([HHP_FILES_LIST], ["m4_map_args_w(BASENAME_LIST, [[ ]], [[.htm]])IMAGEFILES_LIST"])
AC_SUBST([HHP_INDEX], ["index.htm"])
AC_SUBST([DATETIME], ["m4_chomp(m4_esyscmd([git rev-parse HEAD]))"])
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
