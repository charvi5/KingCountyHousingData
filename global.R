
# Load the following packages.
for (package in c('shiny','dplyr','DT','dqata.table','shinydashbaord',
                  'devtools','lubridate')) {
  if (!require(package, character.only=T, quietly=T)) {
    install.packages(package,repos="http://cran.us.r-project.org")
    library(package, character.only=T)
  }
}

#devtools::install_github("rstudio/leaflet")
library('leaflet')
HouseData <- read.csv('kc_house_data.csv')
HouseData$date<-(substr(HouseData$date, 1, 8))
HouseData$date<- ymd(HouseData$date)

