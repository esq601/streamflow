library(jsonlite)
library(leaflet)
library(tidyverse)

df1 <- jsonlite::fromJSON("https://waterwatch.usgs.gov/webservices/realtime?format=json")

df2 <- df1$sites

df2a <- df2 %>%
  rename(lat = dec_lat_va, long = dec_long_va) %>%
  mutate(percent_mean = as.numeric(percent_mean)) %>%
  filter(percent_mean > 0 & percent_mean < 1000) %>%
  mutate(pct_mean = log(percent_mean))


#summary(as.numeric(df2a$percent_mean))
leaflet() %>%
  addProviderTiles("OpenStreetMap.Mapnik") %>%
  addCircleMarkers(data = df2a, radius = ~pct_mean)
