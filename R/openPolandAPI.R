#' A tool function that handles communication with API over multiple pages 
#' 
#' \code{openPolandAPI} modifies url string and binds data from multiple pages.
#'
#' @keywords internal
     
openPolandAPI = function (url, 
                          token = NULL, 
                          query = NULL,
                          nts = NULL,
                          year = NULL) {
        
    if (!is.null(query)) {
        
        # url = paste0(url, "?q=", query, "&page=")
        query = enc2utf8(query)
        url = httr::modify_url(url, query = list(q = query))
        
    } else {
        
        # url = paste0(url, "?page=")
        # url = httr::modify_url(url)
        
    }

    content = openPolandQuery(url = httr::modify_url(url, 
                                                     query = list(page = 0)) ,
                                  #paste0(url, "0"), 
                              token = token, 
                              query = query,
                              nts = nts,
                              year = year)    
    
    
    if (is.null(content)) {
        return()
    }
    
    content_all = content[[3]]
    next_page = content[[1]]
    page = content[[2]] # 0

    # looking for more pages
    while (next_page) {
        
        page = as.numeric(page)+1
        
        content_next_page = openPolandQuery(url = httr::modify_url(url, 
                                                     query = list(page = page)), 
                                                #paste0(url, as.character(page)), 
                                            token = token, 
                                            query = query,
                                            nts = nts, 
                                            year = year
                                            )    
        
        content_all = data.table::rbindlist(list(
            content_all,
            content_next_page[[3]]
            ))
        next_page = content_next_page[[1]]
        
    }
    
    cat("\n Done! \n")

    content_all

}

