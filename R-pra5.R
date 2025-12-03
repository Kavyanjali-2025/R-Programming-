library(dplyr)
library(readr)

meat <- read_csv("meat_consumption_worldwide.csv")

meat_sorted_value <- meat |>
  arrange(Value)

head(meat_sorted_value, 5)

meat_sorted_value_desc <- meat |>
  arrange(desc(Value))

head(meat_sorted_value_desc, 5)

meat_multi_sort <- meat |>
  arrange(LOCATION, desc(Value))

head(meat_multi_sort, 10)

high_beef_sorted <- meat |>
  filter(SUBJECT == "BEEF", Value > 20) |>
  arrange(TIME)

high_beef_sorted |> select(LOCATION, TIME, Value) |> head(5)
