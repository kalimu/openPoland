#' Search openPoland.net database for a specific dataset.
#' 
#' \code{openPolandSearch} returns a data frame with information of available datasets that were found with a given quary.
#' 



    openPolandSearch = function (title = NULL) {
        
        if (is.null(title)) {
          
            url = "https://openpoland.net/api/list"
            
        } else {
            
            title = stringr::str_replace_all(title, pattern = " ", "+")
            # title = unlist(str_split(title, pattern = " ", ))
            # title = str_replace_all(title, pattern = "-", "%2d")
            
            url = paste0("https://openpoland.net/api/list?q=", 
                         enc2utf8(title[1])
                         )
        }  

        
        
        dt = openPolandAPI(url)
    cat(NROW(dt)," datasets found from the query: '",title,"'.\n\n", sep = "")   
        
        
        
        #as.data.frame(
             dt
        #    )
        # [str_detect(tolower(dt$title), title[2]),]
        
        
    }
