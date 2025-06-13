# remuevo los datos problematicos.
error_scinot <- subset(files, 
                       quadkey == "2.10321E+15     ")

# Aparece un error, de un numero que no pudo ser convertido a quadkey,
# lo separo y lo guardo

write.csv(error_scinot, 
          "remove_quadkeys_amba.csv")

# dejo solo los quadkeys reportados para argentina
# asi remuevo otros que aparecen para uruguay o en el mar
files = subset(files,
               country == 'AR')
# remuevo los datos problematicos.
files = subset(files, 
               quadkey != "2.10321E+15     ")

regular_grid <- get_regular_polygon_grid(data = files)

files_polygons <- files |> 
  dplyr::inner_join(regular_grid$data, 
                    by = c("quadkey")) 

write.csv(files_polygons, "amba_raters_input.csv")