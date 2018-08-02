## install.packages("rvest")
library(readr)
library(rvest)
library(xml2)
library("tidyverse")
hthd <- read_html("http://uscode.house.gov/table3/111_273.htm")
html_nodes(hthd,"table")
table1 <- html_node(hthd,"table")
rows <- html_nodes(table1,"tr")
bill_data <- data.frame()
## loop for cleaning ##
for(i in 1:length(rows)){
  .rows <- rows[i]
  if(html_attr(.rows,'class',default = "0")[1] %in% c("table3row_even","table3row_odd")){
    .cells <- html_nodes(.rows,"td")
    print(.cells)
  .atag <- html_nodes(.cells,"a")
  print(html_attr(.atag,"href")[1])
  .actsection <- html_text(.cells[1])
  .statutesatlargepage <- html_text(.cells[2])
  .unitedstatescodetitle <- html_text((.cells[3]))
  .unitedstatescodesection <- html_text(.cells[4])
  .unitedstatescodestatus <- html_text(.cells[5])
  .legislation_url <- html_attr(.atag,"href")[1]
  .unitedstatescodesection_url <- html_attr(.atag,"href")[2]
  .output <- setNames(c(.actsection, .statutesatlargepage, .legislation_url, .unitedstatescodetitle, .unitedstatescodesection, .unitedstatescodesection_url, .unitedstatescodestatus), c("actsection", "statutesatlargepage", "legislation_url","unitedstatescodetitle","unitedstatescodesection","unitedstatescodesection_url","unitedstatescodestatus"))
  bill_data <- bind_rows(bill_data,.output)
  }
}
bill_data <- unique(bill_data)
bill_data <- arrange(bill_data,desc(actsection))
## Arthur ##
