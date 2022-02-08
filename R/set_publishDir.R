#' set_publishDir: set the blogdown publishing directory to 'docs'
#'
#' Set the parameter publishDir in the project .Rprofile to 'docs'.
#' If the parameter doesn't already exist it will be create otherwise the old one will be overwritten
#'
#' @export set_publishDir

set_publishDir <- function() {
  base_path <- Rprofile_path()

  ver = 'blogdown.publishDir = "docs"'
  if (!any(grepl('blogdown\\.publishDir', x1 <- xfun::file_string(base_path)))) {
    cat(paste0('\noptions(', ver, ')\n'), file = base_path, append = TRUE)
  } else {
    x1 <- sub('(blogdown\\.publishDir)+[\\s\\S]*?(?=\\))', ver, x1, perl = TRUE)
    cat(x1, file = base_path)
  }

  message("Changed publishing directory to 'docs'")
}
