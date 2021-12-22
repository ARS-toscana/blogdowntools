#' Title
#'
#' @return modify R config file
#' @export github_Rprofile

github_Rprofile <- function() {
  base_path <- file.path("~/Git repositories/Work/ECVM_documentation", ".Rprofile")

  if (!file.exists(base_path)) {
    stop("The file '", base_path, "' does not exist")
  }

  ver = 'blogdown.publishDir = "docs"'
  if (!any(grepl('blogdown\\.publishDir', x1 <- xfun::file_string(base_path)))) {
    cat(paste0('\noptions(', ver, ')\n'), file = base_path, append = TRUE)
  } else {
    x1 <- sub('(blogdown\\.publishDir)+[\\s\\S]*?(?=\\))', ver, x1, perl = TRUE)
    cat(x1, file = base_path)
  }

  message("Changed publishing directory to 'docs'")
}


