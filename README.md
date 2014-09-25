openPoland
==========

An R package for communication with `OpenPoland.net API` - a gate to
open data in Poland

Kamil Wais  
[<http://www.wais.kamil.rzeszow.pl/openpoland>](http://www.wais.kamil.rzeszow.pl/openpoland)

Here is the Polish version of this tutorial:
[<http://www.wais.kamil.rzeszow.pl/pakiet-r-openpoland-tutorial/>](http://www.wais.kamil.rzeszow.pl/pakiet-r-openpoland-tutorial/)

Description
-----------

With `openPoland` package you can easily access milions records in more
thosands datasets of open data generated in institutions like Central
Statistical Office of Poland. The access to open data is available via
[openPoland.net](http://openPoland.net) API.

Installing the package
----------------------

### Stable version from CRAN

Not yet, but this is the goal. Please see below for code that let you
install the package from GitHub.

### Developer version from GitHub

Remember to install `devtools` package first!

    # install.packages('devtools')
    auth_token = 'bfce48a2c16ed7eb4505f9143efaa1e238160443'
    devtools::install_github("kalimu/openPoland", auth_token=auth_token)

Registering for a token
-----------------------

You need to have a token to get an authorized acces do openPoland
database via API. To get a token you need only to register at
[<https://openpoland.net/signup/>](https://openpoland.net/signup/).

    token = [your_token_here_as_a_character_string]

Example usage
-------------

Remember to set Polish locallization before working with dataset titles
(they have Polish diacritics)!

    Sys.setlocale("LC_ALL", "Polish")

    ## [1] "LC_COLLATE=Polish_Poland.1250;LC_CTYPE=Polish_Poland.1250;LC_MONETARY=Polish_Poland.1250;LC_NUMERIC=C;LC_TIME=Polish_Poland.1250"

Loading openPoland R package

    library(openPoland)

    ## Loading required package: httr
    ## 
    ## Welcome to the world of open data in Poland!
    ## 
    ## OpenPoland R Package version: 0.0.0.14
    ## See what's new: news(package = 'openPoland')
    ## See help: help(openPoland)
    ## 
    ## If you find this package useful cite it please. Thank you! 
    ## See: citation('openPoland')
    ## 
    ## Remember to set locallization to 'Polish'!
    ## Use: Sys.setlocale("LC_ALL", "Polish")

Let's say, we are interested in protected species ("zwierzęta
chronione") in Poland. So we are trying to search for appropriate
dataset for our analysis.  
Let's search

    openPolandSearch(query = "zwierz")

    ## 
     Downloaded pages: 1
    ##  Done! 
    ##  19 datasets found from the query: 'zwierz'.

    ##       id
    ##  1: 1879
    ##  2: 1914
    ##  3: 2097
    ##  4: 2100
    ##  5: 2118
    ##  6: 2071
    ##  7: 2088
    ##  8: 3033
    ##  9: 3028
    ## 10: 3035
    ## 11: 3037
    ## 12: 3029
    ## 13: 1981
    ## 14: 2307
    ## 15: 2600
    ## 16: 2308
    ## 17: 1442
    ## 18: 1449
    ## 19: 2805
    ##                                                                                  title
    ##  1:                                               Zwierzęta gospodarskie (NTS-5, 1996)
    ##  2:       Indywidualne gospodarstwa rolne prowadzące produkcję zwierzęcą (NTS-5, 1996)
    ##  3:                          Gospodarstwa wg rodzaju i pogłowia zwierząt (NTS-5, 2002)
    ##  4:                          Gospodarstwa wg rodzaju i pogłowia zwierząt (NTS-4, 2002)
    ##  5:            Gospodarstwo domowe z właścicielem zwierząt gospodarskich (NTS-5, 2002)
    ##  6:              Pogłowie zwierząt gospodarskich wg rodzaju gospodarstwa (NTS-5, 2002)
    ##  7:              Pogłowie zwierząt gospodarskich wg rodzaju gospodarstwa (NTS-4, 2002)
    ##  8:                                      Pogłowie zwierząt gospodarskich (NTS-4, 2010)
    ##  9: Pogłowie zwierząt gospodarskich (bydło, trzoda chlewna, konie, drób) (NTS-5, 2010)
    ## 10:                    Pogłowie zwierząt gospodarskich w sztukach dużych (NTS-5, 2010)
    ## 11:                    Pogłowie zwierząt gospodarskich w sztukach dużych (NTS-4, 2010)
    ## 12:                         Pogłowie zwierząt gospodarskich (owce, kozy) (NTS-4, 2010)
    ## 13:                                  Ważniejsze zwierzęta chronione (NTS-2, 2003-2012)
    ## 14:                     Pogłowie zwierząt na 100 ha użytków rolnych (NTS-2, 2002-2012)
    ## 15:        Zwierzęta gospodarskie w sztukach przeliczeniowych w LSU (NTS-2, 2004-2012)
    ## 16:                     Produkcja zwierzęca na 1 ha użytków rolnych (NTS-2, 2002-2012)
    ## 17:                     Pogłowie pozostałych zwierząt gospodarskich (NTS-2, 1999-2012)
    ## 18:                                        Niektóre zwierzęta łowne (NTS-2, 1999-2012)
    ## 19:                                           Skup zwierzyny łownej (NTS-2, 2009-2012)

    openPolandSearch(query = "zwierz", subQuery = "chro")

    ## 
     Downloaded pages: 1
    ##  Done! 
    ##  19 datasets found from the query: 'zwierz'.

    ##      id                                             title
    ## 1: 1981 Ważniejsze zwierzęta chronione (NTS-2, 2003-2012)

    id = 1981

That's it! There is one dataset that have title "Ważniejsze zwierzęta
chronione" which means "The most important protected species". The
dataset has an id 1981. Let's see what are meta information inside.

    openPolandMeta(id =  1981, token = token)

    ## 
    ## Dataset id: 1981
    ## Dataset title: Ważniejsze zwierzęta chronione (NTS-2, 2003-2012)
    ## 
    ## Years: 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012
    ## 
    ## Zwierzęta
    ##     id         name
    ## 1 4212        żubry
    ## 2 4213       kozice
    ## 3 4214 niedźwiedzie
    ## 4 4215        bobry
    ## 5 4216        rysie
    ## 6 4217        wilki

We can see that we have date for years since 2003 to 2012. NTS-2 means
that we have data for regions of Poland and for vivodships. We also have
6 species in our dataset. Let's suppose that we are interested in total
number of animals from proteted species in Poland changing over the
years.

First we need to load the whole date from the dataset.

    data = openPolandData(id =  1981, token = token)   

    ## 
     Downloaded pages: 1
     Downloaded pages: 2
     Downloaded pages: 3
    ##  Done!

Loading some additional packages for data manipulation and
visualization...

    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    library(ggplot2)
    library(stringr)
    library(pander)

Let's see how the number of beavers ("bobry") changes over the year...

    tab =     
            as.data.frame(data) %>%
            filter(str_detect(string = nts, pattern = "[0-9][0]{9,9}") ) %>%
            group_by('year', 'dim1')%.% summarize(sum=sum(value)) %>%
            filter(dim1 %in% c("bobry"))

    ggplot(tab,aes(x=factor(year),y=sum, fill = factor(dim1))) +  
    geom_bar(stat="identity",position="dodge")

![plot of chunk
unnamed-chunk-10](README_files/figure-markdown_strict/unnamed-chunk-10.png)

Than bears ("niedźwiedzie"), moutain goats ("kozice") and lynxes
("rysie")...

    tab =     
            as.data.frame(data) %>%
            filter(str_detect(string = nts, pattern = "[0-9][0]{9,9}") ) %>%
            group_by('year', 'dim1')%.% summarize(sum=sum(value)) %>%
            filter(dim1 %in% c("niedźwiedzie","kozice", "rysie"))

    ggplot(tab,aes(x=factor(year),y=sum, fill = factor(dim1))) +  
    geom_bar(stat="identity",position="dodge")

![plot of chunk
unnamed-chunk-11](README_files/figure-markdown_strict/unnamed-chunk-11.png)

And wolves ("wilki") and aurochs ("żubry")...

    tab =     
            as.data.frame(data) %>%
            filter(str_detect(string = nts, pattern = "[0-9][0]{9,9}") ) %>%
            group_by('year', 'dim1')%.% summarize(sum=sum(value)) %>%
            filter(dim1 %in% c("wilki", "żubry"))

    ggplot(tab,aes(x=factor(year),y=sum, fill = factor(dim1))) +  
    geom_bar(stat="identity",position="dodge")

![plot of chunk
unnamed-chunk-12](README_files/figure-markdown_strict/unnamed-chunk-12.png)

That's all. You can try yourself.
