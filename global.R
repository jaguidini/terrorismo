#install.packages(c("ggplot2", "ggcorrplot", "ggalt", 
#                   "ggExtra", "ggthemes", "ggplotify",
#                   "treemapify", "plyr", "dplyr", "scales",
#                   "zoo", "shiny", "shinydashboard", "shinythemes"), 
#                 dependencies = TRUE)

### Carregando pacotes
library(ggplot2)
library(ggcorrplot)
library(ggalt)
library(ggExtra)
library(ggthemes)
library(ggplotify)
library(treemapify)
library(plyr)
library(dplyr)
library(scales)
library(zoo)
library(reshape2)
library(shiny)
library(shinydashboard)
library(shinythemes)

### Defini��o do tema padrão para utiliza��o dos gr�ficos
seta <- grid::arrow(length = grid::unit(0.2, 'cm'), type = 'open')

line_theme <- function (base_size = 14, base_family = 'Ubuntu') {
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(axis.ticks = element_blank(),
          axis.line = element_line(arrow = seta, color = 'gray20'),
          legend.background = element_blank(),
          legend.key = element_blank(),
          panel.background = element_blank(),
          panel.border = element_blank(),
          strip.background = element_blank(),
          plot.background = element_blank(),
          plot.title = element_text(hjust = 1),
          complete = TRUE)
}

bar_theme <- function (base_size = 14, base_family = 'Ubuntu') {
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(axis.ticks = element_blank(),
          legend.background = element_blank(),
          legend.key = element_blank(),
          legend.position = 'none',
          panel.background = element_blank(),
          panel.border = element_blank(),
          strip.background = element_blank(),
          plot.background = element_blank(),
          plot.title = element_text(hjust = 1),
          complete = TRUE)
}


### Carregando base de dados...
dataset <- read.csv(file = 'data/terrorismo_csv.csv', header = TRUE, sep = ";", dec = ",")