#' Rebuild_and_serve
#'
#' Wrapper for functions stop_site(), build_site() and serve_site().
#' Needed in case you have permission access issues in building .Rmd when site is served.
#'
#' @param ... Arguments passed to blogdown::build_site() (arguments build_site, run_hugo, and ...).
#' @export rebuild_and_serve

rebuild_and_serve <- function(...) {
  blogdown::stop_server()
  blogdown::build_site(build_rmd = T, ...)
  blogdown::serve_site()
}

