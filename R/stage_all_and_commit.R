#' Stage_all_and_commit
#'
#' In some case staging many or big files from rstudio cause git to crash.
#' This function stage every possible files and open the Rstudio commit window.
#'
#' @param repo path where the git repository is located. Default to the working directory.
#' @export stage_all_and_commit

stage_all_and_commit <- function(repo = getwd()) {

  if (nrow(gert::git_add(".")) > 0 & Sys.info()["sysname"] == "Windows") KeyboardSimulator::keybd.press("Ctrl+Alt+m")

}

