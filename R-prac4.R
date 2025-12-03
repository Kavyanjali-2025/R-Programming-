install.packages(c("dplyr", "readr", "lubridate"))
library(dplyr)
library(readr)
library(lubridate)

btc <- read_csv("bitcoin_price_1week_Test - Test.csv", col_types = cols(.default = "c"))

btc <- btc %>%
  mutate(
    Date = mdy(Date),
    Open = parse_number(Open),
    High = parse_number(High),
    Low = parse_number(Low),
    Close = parse_number(Close),
    Volume = parse_number(Volume),
    Market_Cap = parse_number(`Market Cap`)
  )

high_close_subset <- subset(btc, Close > 3000)
cat("Number of days with Close > 3000:", nrow(high_close_subset), "\n")
print(high_close_subset)

high_close_high_vol_subset <- subset(btc, Close > 3000 & Volume > 1e9)
cat("Number of days with Close > 3000 AND Volume > 1e9:", nrow(high_close_high_vol_subset), "\n")
print(high_close_high_vol_subset)

special_days_subset <- subset(btc, Close > 3000 | Market_Cap > 5e10)
cat("Number of special days:", nrow(special_days_subset), "\n")
print(special_days_subset)

large_range_days <- btc %>%
  filter((High - Low) > 200)
cat("Days with daily range > 200:", nrow(large_range_days), "\n")
print(large_range_days)

close_high_cap_low <- btc %>%
  filter(Close > 3000, Market_Cap < 5.5e10)
cat("Days with Close > 3000 AND Market Cap < 55B:", nrow(close_high_cap_low), "\n")
print(close_high_cap_low)

dates_of_interest <- as.Date(c("2017-08-07", "2017-08-04"))
selected_dates <- btc %>%
  filter(Date %in% dates_of_interest)
cat("Rows for selected dates:", nrow(selected_dates), "\n")
print(selected_dates)

cat("Max Close:", max(btc$Close, na.rm = TRUE), "\n")
cat("Min Close:", min(btc$Close, na.rm = TRUE), "\n")
cat("Average Volume:", mean(btc$Volume, na.rm = TRUE), "\n")

write_csv(btc, "bitcoin_price_1week_cleaned.csv")
