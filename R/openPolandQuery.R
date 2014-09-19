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
        # nprint(response)
        # warn_for_status(response)
        
        if (status_code(response) == 429 ) {
            
            cat("\n\n")
            cat(content(response)$detail)
            cat("\n\n")
            warn_for_status(response)
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


 
