

#library

library(lubridate)
library(scales)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)
library(glue)
library(viridis)
library(leaflet)
library(DT)
library(shiny)
library(shinydashboard)


#import data set

wh <-
  read.csv("wh.csv")

whc <- wh %>%
  mutate(
    category = as.factor(category),
    country = as.factor(states_name_en),
    region = as.factor(region_en),
    date_recorded = year(as.Date(as.character(date_inscribed), format = "%Y")),
    name = name_en,
    danger = as.factor(danger)
  ) %>%
  select(category,
         country,
         region,
         name,
         date_recorded,
         danger,
         longitude,
         latitude) %>%
  filter(
    region == "Europe and North America" |
      region == "Asia and the Pacific" |
      region == "Latin America and the Caribbean" |
      region == "Africa" |
      region == "Arab States"
  )
