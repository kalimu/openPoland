#' A tool function that sends a single query to the OpenPoland API. 
#' 
#' \code{openPolandQuery} handles a different type of content in API responses.
#'
#' @keywords internal
    
openPolandQuery = function (url, 
                            token = NULL, 
                            meta = FALSE, 
                            query = NULL, 
                            nts = NULL,
                            year = NULL) {
 
    if (is.null(nts) & is.null(year)) {
        
        response <- httr::GET(url, 
                        httr::add_headers(Authorization = paste0("Token ", token))
                        )        
        
        content = rjson::fromJSON(content(response, as = 'text', 
                                          encoding = "UTF-8")
                                  )
        
        body = NULL

    } else {
                    
        body = list(query = 
                        list(time = year, 
                             nts = nts
                             )
                    )
        
        if (is.null(year)) {
            
            warning('You need to specify a "year" argument')
            return()
            
        }
        
        if (is.null(nts)) {
            
            warning('You need to specify a "nts" argument')
            return()
            
        }
    
        response <- httr::POST(url, 
                         httr::add_headers(Authorization = paste0("Token ", token),
                                    'Content-Type' = "application/json"),
                         body = body,
                         encode = "json"
                         #, verbose()
                        )
        
        content = list()
        
        content$results = rjson::fromJSON(content(response, as = 'text', 
                                          encoding = "UTF-8")
                                          )
         
        content$has_next = FALSE
        
        content$page = 0
    }
    
    httr::warn_for_status(response)

    # status code: 429 - throttled
    if (httr::status_code(response) == 429 ) { 

        cat("You sent too much queries to OpenData API.",
            "\nYou need to wait now...\n")
        return()
        
    }
    
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
                    )
               )

    } 
    
    
    
    cat('\r',"Downloaded pages:", as.numeric(content$page)+1)
    flush.console()

    if (NROW(content$results) != 0 ) {
    
        if (is.null(query)) {
            
            dims_length = length(content$results[[1]]) - (2+4)

            names(content$results[[1]]) = 
                c("nts", "name", 
                  paste0("dim", 1:dims_length),
                  "year", "unit", "value", "type"
                  )

        }
        
        dt = data.table::rbindlist(content$results)
        
        list(content$has_next, content$page, dt)

    } else {
        
        list(FALSE, content$page, NULL)
        
    }
        
}


 
#   throttled = TRUE
#   while  (throttled) {
# 
#         if (status_code(response) != 429 ) { 
#             
#             throttled = FALSE
#         
#         } else {
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
#         }
#     }    
