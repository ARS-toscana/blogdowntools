#' github_host_blogdown
#'
#' Set blogdown parameters useful for hosting a webiste on GitHub Pages,
#'
#' @export github_host_blogdown

github_host_blogdown <- function() {

  shiny::shinyApp(
    # Define UI for application that draws a histogram
    ui <- shiny::fluidPage(

      # Application title
      shiny::titlePanel("Github repository parameters"),

      # Sidebar with a slider input for number of bins
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::textInput("account_name", label = "Account name (user or organization)"),
          shiny::textInput("repo_name", label = "Repository name"),
          shiny::checkboxInput("flag_site_name", "Do you want to set a name for your website?"),
          shiny::conditionalPanel(condition = "input.flag_site_name == true",
                                  shiny::textInput("site_name", label = "Website name")),
          shiny::actionButton("do", "Save config file")
        ),

        # Show a plot of the generated distribution
        shiny::mainPanel(
          shiny::textOutput("final_text")
        )
      )
    ),

    # Define server logic required to draw a histogram
    server <- function(input, output, session) {

      flag_toml <- F
      flag_yaml <- F

      base_path <- file.path(getwd(), "config")
      path_toml <- paste0(base_path, ".toml")
      path_yaml <- paste0(base_path, ".yaml")

      if (file.exists(path_toml)) {
        param <- blogdown::read_toml(path_toml)
        flag_toml <- T
      } else if (file.exists(path_yaml)) {
        param <- yaml::yaml.load(read_utf8(path_yaml), eval.expr = TRUE)
        flag_yaml <- T
      } else {
        stop("Config file not found")
      }

      param[["relativeurls"]] <- T
      param[["canonifyURLs"]] <- F

      param[["markup"]][["goldmark"]][["renderer"]][["unsafe"]] <- T

      shiny::observeEvent(input$do, {
        param[["baseURL"]] <- shiny::isolate(paste0("https://", input$account_name, ".github.io/", input$repo_name, "/"))
        if (input$flag_site_name) {
          param[["title"]] <- shiny::isolate(input$site_name)
        }
        if (flag_toml) {
          blogdown::write_toml(param, output = path_toml)
          shiny::stopApp()
        }
        if (flag_yaml) {
          yaml::write_yaml(param, path_yaml)
          shiny::stopApp()
        }
        session$onSessionEnded(function() gh_pages_and_Rprofile(shiny::isolate(input$account_name),
                                                                shiny::isolate(input$repo_name)))
      })
    }
  )
}
