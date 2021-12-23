#' Title
#'
#' @param account_name Name of the account
#' @param repo_name Name of the repo
#' @return Wrapper function
#' @export github_Rprofile_and_activate_pages

github_Rprofile_and_activate_pages <- function(account_name, repo_name) {
  message("modified config file")
  github_Rprofile()
  message("modified .Rprofile")
  # activate_pages(account_name, repo_name)
  # message("updated Github preferences")
}
