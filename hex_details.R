library(tidyverse)

tibble(
  `Author` = character(),
  `filename` = character()
  ) %>%
  add_row(
    Author = "Diego",
    filename = "PyPharma.png"
  ) %>%
  add_row(
    Author = "James",
    filename = "RinPharma.png"
  ) %>%
  write_csv(
    "data/metadata.csv"
  )
