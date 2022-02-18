#' set_github_pages: activate Github Pages functionality from R
#'
#' Activate the option 'Pages' on Github.
#' Account, repository and branch are necessary.
#' The published folder will be set to 'docs'.
#'
#' @param account Name of the account
#' @param repository Name of the repo
#' @param branch Name of the branch
#' @export set_github_pages

set_github_pages <- function(account, repository, branch = gert::git_branch()) {

  headers <- c(Accept = "application/vnd.github.v3+json")

  tryCatch(exist_check_modify_option(account, repository, branch = gert::git_branch(), headers),
           error = function() gh::gh("POST /repos/{owner}/{repo}/pages",
                                      owner = account, repo = repository,
                                      source = list(
                                        branch = jsonlite::unbox(branch),
                                        path = jsonlite::unbox("/docs")
                                      ),
                                      .send_headers = headers)
  )

}
