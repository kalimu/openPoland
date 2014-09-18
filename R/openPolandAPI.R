#'  
#' 
#' \code{openPolandSearch}  
#' 

    
openPolandQuery = function (url) {
        
        response <- GET(url, 
                        # progress()
                        )        
        # response
        warn_for_status(response)
        stop_for_status(response)
        
        # cat('\n')
        
        content = rjson::fromJSON(content(response, as = 'text', 
                                          encoding = "UTF-8")
                                  )
        
        # cat("\n") 
         # Sys.getlocale()
        # cat("\n")
        # cat("\nMore pages?", content$has_next)
 
        cat('\r',"Loading page nr:", content$page+1)
        flush.console()
        # cat("\n\n")
    
        dt = data.table::rbindlist(content$results)
        
        list(content$has_next, content$page, dt)
        

    }




openPolandAPI = function (url) {
        
        content = openPolandQuery(url)
        content_all = content[[3]]
        next_page = content[[1]]
        page = content[[2]] # 0
        
        
        # looking for more pages
        while (next_page) {
            
            page = page+1
            url = paste0(url,
                         "&page=",
                         page                         
                         )
            content_next_page = openPolandQuery(url)    
            content_all = data.table::rbindlist(list(
                content_all,
                content_next_page[[3]]
                ))
            next_page = content_next_page[[1]]
            
        }
        cat("\n Done! ")

        content_all

    }

