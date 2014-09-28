#' Filter a dataset from openPoland API.
#' 
#' \code{openPolandFilter} filter a dataset with given criterias and returns a data frame.
#' 
#' @param data A data table that is a result of \code{\link{openPolandData}} function.
#' @param nts A character string. 
#' @param unit A character string of predefined values: "region", "voivodship", "subregion", "powiat", "gmina".
#' @param year A character string.
#' @param name A character string.
#' 
#' @return A data table object. The first column is a NTS id of territorial unit. The second column is a common name of territorial unit. Then there are from 1 to 5 columns with dimensions labels. All dimensions in a given dataset can be previewed by the \code{\link{openPolandMeta}} function. Last four columns of the data table are: year, measure unit, value and data attribute.
#' 
#' @seealso \code{\link{openPolandData}} for downloading a selected dataset via openPoland API, \code{\link{openPolandMeta}} for getting meta information about datasets, and \code{\link{openPolandSearch}} for searching database with a given query.
# 
#' @examples 
#' \dontrun{
#' 
#' # token for API authorization     
#' token = "[alpha-numeric-string-you-get-after-registration-on-https://openpoland.net]"
#' 
#' openPolandMeta(id =  1944, token = token)
#'
#' # a whole, unfiltered dataset 
#' data = openPolandData(id = 1944, token = token) 
#' 
#' unique(openPolandFilter(data = data, unit="region")$name)
#' unique(openPolandFilter(data = data, unit="voivodship")$name)
#' unique(openPolandFilter(data = data, unit="subregion")$name)
#' unique(openPolandFilter(data = data, unit="powiat")$name)
#' unique(openPolandFilter(data = data, unit="gmina")$name)
#' 
#' unique(openPolandFilter(data = data, nts=5)$name)
#' 
#' openPolandFilter(data = data, name="Warszawa")
#' 
#' }



openPolandFilter = function (data = NULL, 
                           nts = NULL,
                           unit = NULL,
                           year = NULL,
                           name = NULL) {
    
    if (is.null(data)) {
      
        stop('\nData is missing.',
             '\nUse openPolandData() function to download a dataset.')
        
    } 
    
    data = as.data.frame(data)
    
    logical_filter = rep(TRUE,NROW(data))
    
        nts_pattern_1 = "^[0-9][0]{9,9}$"
        nts_pattern_2 = "^[0-9]{3,3}[0]{7,7}$"
        nts_pattern_3 = "^[0-9]{5,5}[0]{5,5}$"
        nts_pattern_4 = "^[0-9]{7,7}[0]{3,3}$"
        # nts_pattern_5 = "^[0-9]{9,9}[0]{1,1}$"   
        
        # the third digit is the symbol of unit type and stands for the following:
        # 1 – urban gmina,
        # 2 – rural gmina,
        # 3 – urban-rural gmina,
        # 4 – town in an urban-rural gmina (a rural locality, which assigned the status of town),
        # 5 – rural area in an urban-rural gmina (the remaining area of a gmina, excluding the area of a town),
        # 8 – quarter of the capital city of Warszawa,
        # 9 – representation in other urban gmina. 
        
        nts_pattern_5_1 = "^[0-9]{9,9}[1]{1,1}$"
        nts_pattern_5_2 = "^[0-9]{9,9}[2]{1,1}$"
        nts_pattern_5_3 = "^[0-9]{9,9}[3]{1,1}$"
        nts_pattern_5_4 = "^[0-9]{9,9}[4]{1,1}$"
        nts_pattern_5_5 = "^[0-9]{9,9}[5]{1,1}$"
        nts_pattern_5_6 = "^[0-9]{9,9}[6]{1,1}$"
        nts_pattern_5_7 = "^[0-9]{9,9}[7]{1,1}$"
        nts_pattern_5_8 = "^[0-9]{9,9}[8]{1,1}$"
        nts_pattern_5_9 = "^[0-9]{9,9}[9]{1,1}$"
    
    if (!is.null(unit)) {

        if (unit == "region") {nts = 1}
        if (unit == "voivodship") {nts = 2}
        if (unit == "subregion") {nts = 3}
        if (unit == "powiat") {nts = 4}
        if (unit == "gmina") {
    
            logical_filter = 
                    !stringr::str_detect(string = data$nts, 
                                         pattern = nts_pattern_1) & 
                    !stringr::str_detect(string = data$nts, 
                                        pattern = nts_pattern_2) &
                    !stringr::str_detect(string = data$nts, 
                                        pattern = nts_pattern_3) &
                    !stringr::str_detect(string = data$nts, 
                                        pattern = nts_pattern_4) &
                    (
                        stringr::str_detect(string = data$nts, 
                                            pattern = nts_pattern_5_1) |
                        stringr::str_detect(string = data$nts, 
                                            pattern = nts_pattern_5_2) |
                        stringr::str_detect(string = data$nts, 
                                            pattern = nts_pattern_5_3)
                    )
            
        }
        
    }
    
    

    if (!is.null(nts) && nchar(as.character(nts)) == 1) {
        

        if (as.character(nts) == '1') {
            
            logical_filter = 
                stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_1)
            
        }
        
        if (as.character(nts) == '2') {
            
            logical_filter = 
                !stringr::str_detect(string = data$nts, 
                                     pattern = nts_pattern_1) & 
                stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_2)
        
        }
        
        if (as.character(nts) == '3') {
            
            logical_filter = 
                !stringr::str_detect(string = data$nts, 
                                     pattern = nts_pattern_1) & 
                !stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_2) &
                stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_3)
        
        }
        
        if (as.character(nts) == '4') {
            
            logical_filter = 
                !stringr::str_detect(string = data$nts, 
                                     pattern = nts_pattern_1) & 
                !stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_2) &
                !stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_3) &
                stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_4)
        
        }
        
        
        if (as.character(nts) == '5') {
            
            logical_filter = 
                !stringr::str_detect(string = data$nts, 
                                     pattern = nts_pattern_1) & 
                !stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_2) &
                !stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_3) &
                !stringr::str_detect(string = data$nts, 
                                    pattern = nts_pattern_4) 
        
        }
        
    } 
    
    if (!is.null(nts) && nchar(as.character(nts)) == 10) {
        
        nts_pattern = as.character(nts)

        logical_filter = stringr::str_detect(string = data$nts, 
                                             pattern = nts_pattern)
        
    }
    
    
    if (!is.null(year)) {
        
        logical_filter = logical_filter & 
            stringr::str_detect(string = data$year, 
                                             pattern = as.character(year))
        
    }
    
    if (!is.null(name)) {
        
        logical_filter = logical_filter & 
            stringr::str_detect(string = data$name, 
                                             pattern = as.character(name))
        
    }
    

    df = 
        data %>%
        dplyr::filter(logical_filter) 
    
            
        #     %>%
        #         dplyr::group_by('name', 'year', 'dim1') %>%
        #         dplyr::summarize(sum=sum(value))
            
        

    # data.table::as.data.table(df)    
    df
        
}

