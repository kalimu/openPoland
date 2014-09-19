#' Search openPoland.net database for a specific dataset.
#' 
#' \code{openPolandSearch} returns a data frame with information of available datasets that were found with a given quary.
#' 



    openPolandData = function (id, token) {
        
        if (is.null(id)) {
          
            stop('What dataset "id" are you looking for?')
            
        } else {
            
            id = as.numeric(id)
            
            url = paste0("https://openPoland.net/api/asset/",id,"/data/")
            
        }  

         openPolandAPI(url, token)

        
 
    }
