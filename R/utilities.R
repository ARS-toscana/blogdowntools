# `%:::%` = function(pkg, fun) get(fun, envir = asNamespace(pkg),
#                                  inherits = FALSE)
# 'stats' %:::% 'Pillai'

read_utf8 <- function(file) {

  if (inherits(file, "connection")) {
    con <- file
  } else {
    con <- base::file(file, encoding = "UTF-8")
    on.exit(close(con), add = TRUE)
  }
  enc2utf8(readLines(con, warn = FALSE))

}

Rprofile_path <- function(file) {

  filepath <- file.path(getwd(), ".Rprofile")
  if (!file.exists(filepath)) {
    stop("The file '", filepath, "' does not exist")
  }
  return(filepath)

}

exist_check_modify_option <- function(account, repository, branch = gert::git_branch(), headers) {

  res <- gh::gh("GET /repos/{owner}/{repo}/pages",
                owner = account, repo = repository,
                .send_headers = headers)

  flag_branch <- ifelse(res$source$branch != branch, 1, 0)
  flag_path <- ifelse(res$source$path != "/docs", 1, 0)

  if (flag_branch | flag_path) {
    gh::gh("PUT /repos/{owner}/{repo}/pages",
           owner = account, repo = repository,
           source = list(
             branch = jsonlite::unbox(branch),
             path = jsonlite::unbox("/docs")
           ),
           .send_headers = headers)
  }

  if (flag_branch) {
    sprintf("Modified Pages branch from %s to %s", res[["source"]][["branch"]], branch)
  }

  if (flag_path) {
    sprintf("Modified Pages folder from %s to %s", sub('.', '', res[["source"]][["path"]]), "docs")
  }

}
