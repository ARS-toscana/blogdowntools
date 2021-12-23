# `%:::%` = function(pkg, fun) get(fun, envir = asNamespace(pkg),
#                                  inherits = FALSE)
# 'stats' %:::% 'Pillai'

read_utf8 <- function(file) {
  if (inherits(file, "connection"))
    con <- file
  else {
    con <- base::file(file, encoding = "UTF-8")
    on.exit(close(con), add = TRUE)
  }
  enc2utf8(readLines(con, warn = FALSE))
}
