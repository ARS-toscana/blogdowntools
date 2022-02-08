#' set_github_pages: activate Github Pages functionality from R
#'
#' Activate the option 'Pages' of Github.
#' Account, repository and branch are necessary.
#' The published folder will be named 'docs'.
#'
#' @param account Name of the account
#' @param repository Name of the repo
#' @param branch Name of the branch
#' @export set_github_pages

set_github_pages <- function(account, repository, branch = gert::git_branch()) {

  headers <- c(Accept = "application/vnd.github.v3+json")

  exist_check_modify_option <- function() {

    res <- gh::gh("GET /repos/{owner}/{repo}/pages",
                   owner = "ARS-toscana", repo = "ECVM",
                   .send_headers = headers)

    flag_branch <- ifelse(res[["source"]][["branch"]] != branch, 1, 0)
    flag_path <- ifelse(res[["source"]][["path"]] != "/docs", 1, 0)

    if (flag_branch | flag_path) {
      gh::gh("PUT /repos/{owner}/{repo}/pages",
             owner = account, repo = repository,
             source = list(
               branch = jsonlite::unbox(branch),
               path = jsonlite::unbox("/docs")
             ),
             .send_headers = headers)
      if (flag_branch & flag_path) {
        sprintf("Modified Pages branch from %s to %s", res[["source"]][["branch"]], branch)
        sprintf("Modified Pages folder from %s to %s", sub('.', '', res[["source"]][["path"]]), "docs")
      }
    }



  }

  tryCatch(exist_check_modify_option(),
           error = function(c) gh::gh("POST /repos/{owner}/{repo}/pages",
                                      owner = account, repo = repository,
                                      source = list(
                                        branch = jsonlite::unbox(branch),
                                        path = jsonlite::unbox("/docs")
                                      ),
                                      .send_headers = headers)
  )

}
