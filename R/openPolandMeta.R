#' Shows meta information about a specific dataset.
#' 
#' \code{openPolandMeta} returns a list with meta information of a specific dataset and prints it on the console in a readable form.
#' 
#' 
#' @param id A character string.
#' @param token A characters string.
#' @param verbose If TRUE prints meta info on the console and returns nothing. If FALSE doesn't print meta but returns it as a list object. 
#' 
#' @return If verbose = FALSE returns a list object with meta information about a selected dataset.
#' 
#' @seealso \code{\link{openPolandSearch}} for  for searching database with a given query and \code{\link{openPolandData}} for downloading a selected dataset via openPoland API.
#' 
#' @examples 
#' \dontrun{
#' 
#' openPolandSearch("akad")
#' #     id                                     title
#' # 1 1836 Nauczyciele akademiccy (NTS-2, 1999-2012)
#'
#' # token for API authorization     
#' token = "[alpha-numeric-string-you-get-after-registration-on-https://openpoland.net]"
#' 
#' # print meta data on the console
#' openPolandMeta(id = 1836, token = token)
#' 
#' # don't print and return only list object
#' openPolandMeta(id = 1836, token = token, verbose = FALSE)
#' 
#' }


openPolandMeta = function (id, token, verbose = TRUE) {
        
    if (is.null(id)) {
      
        stop('\nWhat dataset "id" are you looking for?',
             '\nUse openPolandSearch() function to search for a dataset.')
        
    } 
    
    if (is.null(token)) {
        
        stop('\nYou need to have a token for authorization!',
             '\nRegister at https://openpoland.net/signup/ to get a token.')
        
    }
            
    url = paste0("https://openPoland.net/api/asset/",id,"/meta")
            
    meta = openPolandQuery(url, token, meta = TRUE)

    if (verbose & !is.null(meta)) {
        
        cat("\nDataset id:", meta$subKey)
        cat("\nDataset title:", meta$title)
        cat("\n\nYears:", meta$years)
        cat("\n\n")
        
       for (i in seq_along(meta$dims)) {
            cat(meta$dims[[i]]$name)
            cat("\n")
            print(meta$dims[[i]]$dims)
            cat("\n")          
       }
        
        
    } else {
        
        meta
        
    }

}
