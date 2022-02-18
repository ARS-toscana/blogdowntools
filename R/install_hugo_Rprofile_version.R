#' install_hugo_Rprofile_version: install Hugo version found in .Rprofile of the project
#'
#' Search all versions of Hugo and compare them to recommended version set in the .Rprofile file found in the working directory of the project
#' If the correct Hugo version is already installed then do nothing
#'
#' @export install_hugo_Rprofile_version

install_hugo_Rprofile_version <- function() {

  base_path <- Rprofile_path()
  path <- xfun::file_string(base_path)

  hugo_Rprofile_version <- stringr::str_extract(path, '(blogdown\\.hugo\\.version)+[\\s\\S]*?(?=\\))')
  hugo_Rprofile_version <- stringr::str_match(hugo_Rprofile_version, '\\"([^\\"]+)\\"')[2]

  hugo_installed_vesions <- stringr::str_match(blogdown::find_hugo("all"), 'Hugo/([^\\"]+)/hugo')[,2]

  if (any(hugo_installed_vesions == hugo_Rprofile_version)) {
    message(paste("Version", hugo_Rprofile_version, "is already present"))
  } else {
    blogdown::install_hugo(hugo_Rprofile_version)
    message(paste("Version", hugo_Rprofile_version, "has been installed"))
  }

}
