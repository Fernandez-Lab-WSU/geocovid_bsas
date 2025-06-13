# Generate the raster files                       
polygon_to_raster(data = files_polygons,
                  nx = regular_grid$num_cols,
                  ny = regular_grid$num_rows,
                  template = files_polygons,
                  var = 'percent_change',
                  filename = 'AMBA',
                  path = "../Desktop/Facebook data/rasters_amba/")