#' Search openPoland.net database for a specific dataset.
#' 
#' \code{openPolandSearch} returns a data frame with information of available datasets that were found with a given quary.
#' 



    openPolandSearch = function (query = NULL, token = NULL) {
        
        if (is.null(query)) {
          
            url = "https://openpoland.net/api/list"
            
        } else {
            
            query = stringr::str_replace_all(query, pattern = " ", "+")
            # title = unlist(str_split(title, pattern = " ", ))
            # title = str_replace_all(title, pattern = "-", "%2d")
            
            url = paste0("https://openpoland.net/api/list/")
        }  

        
        
        dt = openPolandAPI(url, query = enc2utf8(query), token = token)
        
        cat(NROW(dt)," datasets found from the query: '",query,"'.\n\n", sep = "")   
        
        
        
        #as.data.frame(
             dt
        #    )
        # [str_detect(tolower(dt$title), title[2]),]
        
        
    }
