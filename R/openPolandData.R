#' Loads a full or filtered data from a selected dataset via openPoland API.
#' 
#' \code{openPolandData} returns a data frame with data from a dataset with given ID. The data could be filtered by year or NTS id.
#' 
# The query from \code{openPolandSearch} function is not case-sensitive.
# The token authorization is non-obligatory for database searching. 
# Polish diacritics should also worked within a query.
# The query parameter is send to API, but the subQuery parameter is search locally after downloading the dataset lists from API.
# 
#' @param id A character string.
#' @param token A characters string. 
#' @param nts A character string. 
#' @param year A character string.
#' @param remove_duplicated A logical value. If TRUE (default) removes all duplicated records from the datasets.
#' 
#' @return A data table object. The first column is a NTS id of territorial unit. The second column is a common name of territorial unit. Then there are from 1 to 5 columns with dimensions labels. All dimensions in a given dataset can be previewed by the \code{\link{openPolandMeta}} function. Last four columns of the data table are: year, measure unit, value and data attribute.
#' 
#' @seealso \code{\link{openPolandMeta}} for getting meta information about datasets, and \code{\link{openPolandSearch}} for searching database with a given query.
# 
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
#' # a fltered dataset with data for 1999 year in Central Region (NTS = 1000000000)
#' openPolandData(id = 1836, token = token,nts = '1000000000', year='1999') 
#' 
#' # a whole, unfiltered dataset 
#' openPolandData(id = 1836, token = token) 
#' }



openPolandData = function (id = NULL, 
                           token = NULL, 
                           nts = NULL,
                           year = NULL,
                           remove_duplicated = TRUE) {
    
    if (is.null(id)) {
      
        stop('\nWhat dataset "id" are you looking for?',
             '\nUse openPolandSearch() function to search for a dataset.')
        
    } 
    
    if (is.null(token)) {
        
        stop('\nYou need to have a token for authorization!',
             '\nRegister at https://openpoland.net/signup/ to get a token.')
        
    }
    
    if (is.null(nts) & is.null(year)) {
        
        url = paste0("https://openPoland.net/api/asset/",id,"/data/")
        
        data = openPolandAPI(url, token)
        
    }  else {
        
        url = paste0("https://openPoland.net/api/asset/",id,"/data_filter/")
        
        data = openPolandAPI(url = url, 
                              token = token, 
                              nts = nts,
                              year = year)
        
    }
    
    if (remove_duplicated) {
        
        data = data[!duplicated(data),]
        
    } else {
        
        data
        
    }
        

}

