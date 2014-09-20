#' Search openPoland.net database for a specific dataset.
#' 
#' \code{openPolandSearch} returns a data frame with information of available datasets that were found with a given quary.
#' 



    openPolandMeta = function (id, token, verbose = TRUE) {
        
        if (is.null(id)) {
          
            stop('What dataset "id" are you looking for?')
            
        } else {
            
            id = as.numeric(id)
            
            url = paste0("https://openPoland.net/api/asset/",id,"/meta")
            
        }  

         meta = openPolandQuery(url, token, meta = TRUE)

        if (verbose & !is.null(meta)) {
            
            
            cat("\nDataset id:", meta$subKey)
            cat("\nDataset title:", meta$title)
            cat("\nYears:", meta$years)
            cat("\n\n")
            
           for (i in seq_along(meta$dims)) {
                cat(meta$dims[[i]]$name)
                cat("\n")
                print(meta$dims[[i]]$dims)
                cat("\n")          
           }
            
            
        }

                
        meta
        
 
    }
