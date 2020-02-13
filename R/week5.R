# R Studio API Code 
library(rstudioapi)
setwd(dirname(getActiveDocumentContext()$path))

# Data Import
library(tidyverse)
Adata_tbl <- read_delim(file = "../data/Aparticipants.dat", delim = "-", col_names = c("casenum","parnum","stimver","datadate","qs"))
Anotes_tbl <- read_csv("../data/Anotes.csv")
Bdata_tbl <- read_tsv(file = "../data/Bparticipants.dat", col_names = c("casenum","parnum","stimver","datadate",paste0("q",1:10)))
Bnotes_tbl <- read_tsv("../data/Bnotes.txt")
