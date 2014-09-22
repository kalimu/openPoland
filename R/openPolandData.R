#' Search openPoland.net database for a specific dataset.
#' 
#' \code{openPolandSearch} returns a data frame with information of available datasets that were found with a given quary.
#' 



    openPolandData = function (id, token, 
                               nts = NULL,
                               year = NULL
                               ) {
        
        if (is.null(id)) {
          
            stop('What dataset "id" are you looking for?')
            
        } 
        
        if (is.null(token)) {
            
            stop('You need to send token for authorization!')
            
        }
        
        id = as.numeric(id)

        if (is.null(nts) & is.null(year)) {
            
            url = paste0("https://openPoland.net/api/asset/",id,"/data/")
            
            openPolandAPI(url, token)
            
        }  else {
            
            url = paste0("https://openPoland.net/api/asset/",id,"/data_filter/")
            
            openPolandAPI(url = url, 
                          token = token, 
                          nts = nts,
                          year = year)
                   
        }


        
 
    }

