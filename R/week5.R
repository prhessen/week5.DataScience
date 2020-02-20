# R Studio API Code 
library(rstudioapi)
setwd(dirname(getActiveDocumentContext()$path))

# Data Import
library(tidyverse)
Adata_tbl <- read_delim(file = "../data/Aparticipants.dat", delim = "-", col_names = c("casenum","parnum","stimver","datadate","qs"))
Anotes_tbl <- read_csv("../data/Anotes.csv")
Bdata_tbl <- read_tsv(file = "../data/Bparticipants.dat", col_names = c("casenum","parnum","stimver","datadate",paste0("q",1:10)))
Bnotes_tbl <- read_tsv("../data/Bnotes.txt")

# Data Cleaning
Adata_tbl <- Adata_tbl %>% 
    separate(qs, paste0("q",1:5), sep = " - ") %>% 
    mutate_at(vars("q1":"q5"), as.numeric) %>%
    mutate_at(vars("datadate"), lubridate::mdy_hms)

Aaggr_tbl <- select(Adata_tbl, parnum, q1:q5) %>%
    group_by(parnum) %>%
    summarize_at(vars("q1":"q5"), mean)
Baggr_tbl <- select(Bdata_tbl, parnum, q1:q9) %>%
    group_by(parnum) %>%
    summarize_at(vars("q1":"q9"), mean)
Aaggr_tbl <- left_join(Aaggr_tbl, Anotes_tbl, by = "parnum")
Baggr_tbl <- left_join(Baggr_tbl, Bnotes_tbl, by = "parnum")
bind_rows(Adata = Aaggr_tbl, Bdata = Baggr_tbl, .id = "source") %>%
    filter(is.na(notes)) %>%
    group_by(source) %>%
    summarize(n())
