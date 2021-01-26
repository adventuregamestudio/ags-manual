define(`defjob',dnl
`define(`__OS', $1)'dnl
`define(`__SHELL', $2)'dnl
`define(`__PANDOC', $3)'dnl
`define(`__JOBNAME', build-__OS-__SHELL-`translit(__PANDOC, ., -)')'dnl
`divert(1)'dnl
      - __JOBNAME
`divert(0)')dnl
changecom(`##', `
')dnl
