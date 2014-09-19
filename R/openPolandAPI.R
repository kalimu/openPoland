#'  
#' 
#' \code{openPolandSearch}  
#' 

     


openPolandAPI = function (url, token = NULL, query = NULL) {
        
 
        
        
        if (!is.null(query)) {
            
            url = paste0(url, "?q=", query, "&page=")
            
        } else {
            
            url = paste0(url, "?page=")
            
        }
    
        content = openPolandQuery(url = paste0(url, "0"), 
                                  token = token, 
                                  query = query)    
        
        
        if (is.null(content)) {
            return()
        }
        
        content_all = content[[3]]
        next_page = content[[1]]
        page = content[[2]] # 0

        
          
        # looking for more pages
        while (next_page) {
            
            page = as.numeric(page)+1
            
            content_next_page = openPolandQuery(url = paste0(url,
                                                             as.character(page)), 
                                                token = token, 
                                                query = query
                                                )    
            
            content_all = data.table::rbindlist(list(
                content_all,
                content_next_page[[3]]
                ))
            next_page = content_next_page[[1]]
            
        }
        cat("\n Done! ")

        content_all
            
      
        

    }

