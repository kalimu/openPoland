openPoland
==========

An R package for communication with `OpenPoland.net API` - a gate to open data in Poland

## Description

With this package you can easily access more than 130 000 000 records in more than 1300 datasets generated in institutions like Central Statistical Office of Poland.
The access to open data is available via [openData.net](http://openData.net) API.

## Installing the package

### Stable version from CRAN

Not yet, but this is the goal. 
Please see below for code that let you install the package from GitHub.


### Developer version from GitHub

Remember to install `devtools` package first!

```
# install.packages('devtools')
auth_token = 'bfce48a2c16ed7eb4505f9143efaa1e238160443'
devtools::install_github("kalimu/openPoland", auth_token=auth_token)
```

Remember to set Polish locallization before working with dataset titles!

```
Sys.setlocale("LC_ALL", "Polish")

```
