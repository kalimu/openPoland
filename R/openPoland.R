
# welcome message
# detach("package:openPoland", unload=TRUE)
  
    .onAttach <- function(libname, pkgname) {
      packageStartupMessage("Welcome to open data in Poland!\nIf you find this package useful cite it please.\nSee more here: citation(package='openData')")
    }
