AC_DEFUN([AGS_PROG_PANDOC], [
AC_ARG_VAR([PANDOC], [path to PANDOC])

AS_IF([test "x${PANDOC}" = x],
     [AC_CACHE_CHECK([for pandoc], [ac_cv_path_PANDOC],
         [AC_PATH_PROGS_FEATURE_CHECK([PANDOC], [pandoc],
             [[echo | "$ac_path_PANDOC" --to "$1" && \
                   ac_cv_path_PANDOC="$ac_path_PANDOC" ac_path_PANDOC_found=:]],
             [AC_MSG_ERROR([could not find pandoc with required features])])])

      AC_SUBST([PANDOC], ["$ac_cv_path_PANDOC"])])
])dnl
