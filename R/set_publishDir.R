#' set_publishDir: set the blogdown publishing directory to 'docs'
#'
#' Set the parameter publishDir in the project .Rprofile to 'docs'.
#' If the parameter doesn't already exist it will be create otherwise the old one will be ostringwritten
#'
#' @export set_publishDir

set_publishDir <- function() {

  base_path <- Rprofile_path()
  string = 'blogdown.publishDir = "docs"'
  path <- file_string(base_path)

  if (!any(grepl('blogdown\\.publishDir', path))) {
    cat(paste0('\noptions(', string, ')\n'), file = base_path, append = TRUE)
  } else {
    path <- sub('(blogdown\\.publishDir)+[\\s\\S]*?(?=\\))', string, path, perl = TRUE)
    cat(path, file = base_path)
  }

  message("Changed publishing directory to 'docs'")
}
