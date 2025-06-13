
regular_grid <- get_regular_polygon_grid(data = files)
files_polygons <- files |> 
  dplyr::inner_join(regular_grid$data, 
                    by = c("quadkey")) 

write.csv(files_polygons, "baires_raters_input.csv")