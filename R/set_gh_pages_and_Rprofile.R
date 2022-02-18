#' set_gh_pages_and_Rprofile
#'
#' Wrapper for functions set_publishDir() and set_github_pages()
#' Needed in github_host_blogdown.
#' set_github_pages branch is set to the currently active one.
#'
#' @param account_name Name of the account associated to the repository
#' @param repo_name Name of the repository
#' @export set_gh_pages_and_Rprofile

set_gh_pages_and_Rprofile <- function(account_name, repo_name) {
  message("modified config file")
  set_publishDir()
  message("modified .Rprofile")
  set_github_pages(account_name, repo_name)
  message("modified Github preferences")
}
