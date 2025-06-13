library(quadkeyr)

files <- read_fb_mobility_files(
  path_to_csvs = "../Desktop/Facebook data/AMBA_facebookpop/",
  colnames = c(
    "lat",
    "lon",
    "quadkey",
    "country",
    "date_time",
    "n_crisis",
    "percent_change"
  ),
  coltypes = list(
    lat = 'd',
    lon = 'd',
    quadkey = 'c',
    country = 'f',
    date_time = 'T',
    n_crisis = 'c',
    percent_change = 'c'
  )
)

write.csv(files, 'amba_qk_grid_input.csv')