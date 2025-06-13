
files <- read_fb_mobility_files(
  path_to_csvs = "../Desktop/Facebook data/BsAs_facebookpop/",
  colnames = c(
    "lat",
    "lon",
    "quadkey",
    "date_time",
    "n_crisis",
    "percent_change"
  ),
  coltypes = list(
    lat = 'd',
    lon = 'd',
    quadkey = 'c',
    date_time = 'T',
    n_crisis = 'c',
    percent_change = 'c'
  )
)


write.csv(files, 'baires_qk_grid_input.csv')