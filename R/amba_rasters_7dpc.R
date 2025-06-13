# 7 days
files_polygons_7 <- files_polygons |>
  apply_weekly_lag()

path = "../Desktop/Facebook data/rasters_amba/")
# Generate the raster files                       
polygon_to_raster(data = files_polygons_7,
                  nx = regular_grid$num_cols,
                  ny = regular_grid$num_rows,
                  template = files_polygons_7,
                  var = 'percent_change_7',
                  filename = 'AMBA7',
                  path = "../Desktop/Facebook data/rasters_amba/")