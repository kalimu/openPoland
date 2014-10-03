
.onAttach <- function(libname, pkgname) {
    
    packageStartupMessage("\nWelcome to the world of open data in Poland!")
    

    packageStartupMessage(paste0('\nOpenPoland R Package version: ',
                                 utils::packageVersion("openPoland"))
                          )
    packageStartupMessage("See what's new: news(package = 'openPoland')")
    packageStartupMessage("See help: help(openPoland)")
    
    packageStartupMessage("\nIf you find this package useful cite it please. Thank you! ")
    packageStartupMessage("See: citation('openPoland')")
    
    packageStartupMessage("\nRemember to set locallization to 'Polish'!");
    packageStartupMessage("Use: Sys.setlocale(\"LC_ALL\", \"Polish\")\n")
    # Sys.setlocale("LC_ALL", "Polish")
    
}
#' An R package for working with open data from Poland
#'
#' With \code{openPoland} R package you can easy access milions of records from  thousands of open data datasets that are generated in Poland via openPoland.net API. 
#'
#'
#' @docType package
#' 
#' @name openPoland
#' 
#' @seealso 
#' \itemize{
#'   \item \url{https://github.com/kalimu/openPoland} [R package source code]
#'   \item \url{https://openpoland.net/welcome/} [API homepage]
#'   \item \url{http://www.wais.kamil.rzeszow.pl/openPoland} [R package homepage in Polish]
#' }
#' 
#' 
#@keywords internal
 
NULL
 
# detach("package:openPoland", unload=TRUE)
# devtools::show_news()
  
