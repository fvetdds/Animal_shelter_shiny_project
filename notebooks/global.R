library(shiny) 
library(tidyverse)
library(DT)
library(wordcloud2)  
library(rsconnect)

animals <- read.csv("./data/animals.csv")
