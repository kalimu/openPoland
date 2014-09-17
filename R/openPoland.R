#' Generate R documentation from inline comments.
#'
#' An R package for communication with OpenPoland.net API
#'
#'
# The only function you're likely to need from \pkg{roxygen2} is
# \code{\link{roxygenize}}. Otherwise refer to the vignettes to see
# how to format the documentation.
#'
#' @docType package
#' @name openPoland
#' @seealso 
#' \itemize{
#'   \item \url{https://github.com/kalimu/openPoland}
#'   \item \url{https://openpoland.net/welcome/} 
#' }
#' 
#'
 # @example  


# welcome message
# detach("package:openPoland", unload=TRUE)
# devtools::show_news()
  
    .onAttach <- function(libname, pkgname) {
      packageStartupMessage("Welcome to the world of open data in Poland!\nIf you find this package useful cite it please. Thank you!\nSee: citation('openPoland')")
    }
