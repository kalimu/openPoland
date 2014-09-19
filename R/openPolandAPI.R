#'  
#' 
#' \code{openPolandSearch}  
#' 

    
openPolandQuery = function (url, token = NULL, meta = FALSE, query = NULL) {
        
# url = "https://openPoland.net/api/asset/2054/meta"
    
        response <- GET(url, 
                        # progress()
                        add_headers(Authorization = paste0("Token ", token))
                        )        
        print(response)
        warn_for_status(response)
        
        if (status_code(response) == 429 ) {
            
            cat(content(response)$detail)
            cat("\n\n")
            return()
            
        }
        
        
        # cat('\n')
        
        content = rjson::fromJSON(content(response, as = 'text', 
                                          encoding = "UTF-8")
                                  )
        
        # cat("\n") 
         # Sys.getlocale()
        # cat("\n")
        # cat("\nMore pages?", content$has_next)
 
        if (meta) {
        
            cat("\nDataset id:", content$subKey)
            cat("\nDataset title:", content$title)
            cat("\nYears:", content$years)
            cat("\n\n")

            for (i in seq_along(content$dims)) {

                cat(content$dims[[i]]$name)
                cat("\n")
                print(data.table::rbindlist(content$dims[[i]]$values))
                cat("\n")
            
            }
                     
            
        } else {

            cat('\r',"Loading page nr:", as.numeric(content$page)+1)
            flush.console()
            # cat("\n\n")

            
            if (NROW(content$results) != 0 ) {
            
                if (is.null(query)) {
                    
                    names(content$results[[1]]) = seq_along(content$results[[1]])        

                }
                
                dt = data.table::rbindlist(content$results)
                
                list(content$has_next, content$page, dt)

            } else {
                
                list(FALSE, content$page, NULL)
                
            }
            
            
        }
        
 

    }




openPolandAPI = function (url, token = NULL, query = NULL) {
        
 
        
        
        if (!is.null(query)) {
            
            url = paste0(url, "?q=", query, "&page=")
            
        } else {
            
            url = paste0(url, "?page=")
            
        }
    
        content = openPolandQuery(url = paste0(url, "0"), 
                                  token = token, 
                                  query = query)    
        
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

