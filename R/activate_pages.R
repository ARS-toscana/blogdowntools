#' Title
#'
#' @param account_name Name of the account
#' @param repo_name Name of the repo
#' @param branch Name of the branch
#' @return activate GitHub pages with correct parameters
#' @export activate_pages

activate_pages <- function(account_name, repo_name, branch = gert::git_branch()) {

  headers <- c(Accept = "application/vnd.github.v3+json")

  test_fun <- function() {

    test <- gh::gh("GET /repos/{owner}/{repo}/pages",
                   owner = "ARS-toscana", repo = "ECVM",
                   .send_headers = headers)

    flag_branch <- ifelse(test[["source"]][["branch"]] != branch, 1, 0)
    flag_path <- ifelse(test[["source"]][["path"]] != "/docs", 1, 0)

    if (flag_branch | flag_path) {
      gh::gh("PUT /repos/{owner}/{repo}/pages",
             owner = account_name, repo = repo_name,
             source = list(
               branch = jsonlite::unbox(branch),
               path = jsonlite::unbox("/docs")
             ),
             .send_headers = headers)
      if (flag_branch & flag_path) {
        sprintf("Modified Pages branch from %s to %s", test[["source"]][["branch"]], branch)
        sprintf("Modified Pages folder from %s to %s", sub('.', '', test[["source"]][["path"]]), "docs")
      }
    }



  }

  tryCatch(test_fun(),
           error = function(c) gh::gh("POST /repos/{owner}/{repo}/pages",
                                      owner = account_name, repo = repo_name,
                                      source = list(
                                        branch = jsonlite::unbox(branch),
                                        path = jsonlite::unbox("/docs")
                                      ),
                                      .send_headers = headers)
  )

}
