
# welcome message
# detach("package:openPoland", unload=TRUE)
# devtools::show_news()
  
    .onAttach <- function(libname, pkgname) {
      packageStartupMessage("Welcome to the world of open data in Poland!\nIf you find this package useful cite it please. Thank you!\nSee: citation('openPoland')")
    }
