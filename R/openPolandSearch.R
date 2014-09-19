#' Search openPoland.net database for a specific dataset.
#' 
#' \code{openPolandSearch} returns a data frame with information of available datasets that were found with a given quary.
#' 
#' The query from \code{openPolandSearch} function is not case-sensitive.
#' The token authorization is non-obligatory for database searching. 
#' Polish diacritics should also worked within a query.
#' The query parameter is send to API, but the subQuery parameter is search locally after downloading the dataset lists from API.
#' 
#' @param query A character string.
#' @param subQuery A characters string.
#' @param token A character string. 
#' @return A data table object with datasets ids and titles that have a query string inside them.
#' @seealso \code{\link{openPolandMeta}} for meta data about datasets, and \code{\link{openPolandData}} for downloading a selected dataset via openPoland API.
#' 
#' @examples 
#' \dontrun{
#' openPolandSearch() # returns API demo list of datasets
#' 
#' openPolandSearch(query = 'telef')
#' 
#' openPolandSearch(query = "nauczy", subQuery = "akad")
#' 
#' # Polish diacritics are also available 
#' openPolandSearch(query = enc2utf8('ludno\u015B\u0107'))
#' }

openPolandSearch = function (query = NULL, 
                             token = NULL,
                             subQuery = NULL) {
    
    url = "https://openpoland.net/api/list"
    
    if (!is.null(query)) {
      
        query = stringr::str_replace_all(query, pattern = " ", "+")
        # title = str_replace_all(title, pattern = "-", "%2d")

    }  

    dt = openPolandAPI(url, query = enc2utf8(query), token = token)
    
    cat(NROW(dt)," datasets found from the query: '",query,"'.\n\n", sep = "")   
    
    df = as.data.frame(dt)
    
    if (!is.null(subQuery)) {
        
        df = df[stringr::str_detect(tolower(df$title),
                                    tolower(subQuery[1])), ]
        
    }

    df
        
}
