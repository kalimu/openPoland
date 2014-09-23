#'  
#' 
#' \code{openPolandSearch}  
#' 

    
openPolandQuery = function (url, 
                            token = NULL, 
                            meta = FALSE, 
                            query = NULL, 
                            nts = NULL,
                            year = NULL) {
        
# url = "https://openPoland.net/api/asset/2054/meta"
    
#     throttled = TRUE
    
#     while  (throttled) {
        
    if (is.null(nts) & is.null(year)) {
        
        response <- GET(url, 
                        #progress(),
                        add_headers(Authorization = paste0("Token ", token))
                        )        
        
                content = rjson::fromJSON(content(response, as = 'text', 
                                          encoding = "UTF-8")
                                  )
        
        
        
    } else {
        
            
        body = list(query = 
                        list(time = year, 
                             nts = nts
                             )
                    )
        
        if (is.null(year)) {
            
            warning('You need to specify a year argument')
            return()
            
        }
        if (is.null(nts)) {
            
            warning('You need to specify a NTS argument')
            return()
            
        }
        
    
        response <- POST(url, #progress(),
                        add_headers(Authorization = paste0("Token ", token),
                                    'Content-Type' = "application/json"),
                        body = body,
                        encode = "json"
                        # , verbose()
                        )
        
        content = list()
        content$results = rjson::fromJSON(content(response, as = 'text', 
                                          encoding = "UTF-8")
                                  )
         
        content$has_next = FALSE
        content$page = 0
    }
    
    
    
        # nprint(response)
        # warn_for_status(response)
        
#         if (status_code(response) != 429 ) { 
#             
#             throttled = FALSE
#         
#         } else {
#         
#             
#             seconds = as.numeric(stringr::str_extract(content(response)$detail,
#                                                       pattern = "[0-9]{1,}")
#                                  )
#             cat("\n\n")
#             cat(content(response)$detail)
#             cat("\nWaiting",round(seconds/60,2),"minutes...")
#             cat("\n\n")
#             
#             
#             # Sys.sleep(1)
#             
#             waiting_time = seq(1,seconds+1)
#             progress_bar   <- txtProgressBar(1, seconds+1, style=3)
#             for(i in waiting_time){
#                 Sys.sleep(1)
#             setTxtProgressBar(progress_bar, i)
#              }
#             
#             throttled = TRUE
#             
#             #warn_for_status(response)
#             # return()
#             
# #         }
# 
#         
#         
#         
#     }    
#         
        
        
        # cat('\n')
        

        # cat("\n") 
         # Sys.getlocale()
        # cat("\n")
        # cat("\nMore pages?", content$has_next)
 
        if (meta) {
        

            
            dims = list()

            for (i in seq_along(content$dims)) {

                dims = c(dims, list(
                                list(name=content$dims[[i]]$name,
                                    dims=as.data.frame(
                                        data.table::rbindlist(
                                            content$dims[[i]]$values)
                                        )
                                    )
                                )
                         )
            
            }
            
            return(list(subKey = content$subKey,
                        title = content$title,
                        years = content$years,
                        dims=dims
                        ))
                     
            
        } else {

            cat('\r',"Downloaded pages:", as.numeric(content$page)+1)
            flush.console()
            # cat("\n\n")

            
            if (NROW(content$results) != 0 ) {
            
                if (is.null(query)) {
                    
                    dims_length = length(content$results[[1]]) - (2+4)
                    names(content$results[[1]]) = 
                        c("nts", "name", 
                          paste0("dim", 1:dims_length),
                          "year", "unit", "value", "type"
                          )
                    
                    
                        # seq_along(content$results[[1]])        

                }
                
                dt = data.table::rbindlist(content$results)
                
                list(content$has_next, content$page, dt)

            } else {
                
                list(FALSE, content$page, NULL)
                
            }
            
            
        }
        
 

    }


 
