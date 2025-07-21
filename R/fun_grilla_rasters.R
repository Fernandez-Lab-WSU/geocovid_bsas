
# -------------------------------
# 1. Setup conexión
db <- config::get("database")
pool <- pool::dbPool(
  drv = RPostgres::Postgres(),
  dbname = db$dbname,
  user = db$user,
  password = db$password,
  port = db$port,
  host = db$host
)
on.exit(pool::poolClose(pool))

# -------------------------------
# 2. Función para procesar un raster y guardarlo como PNG
save_rasters <- function(
    pool,
    base_raster,
    locaciones = c("amba", "baires"),
    tipos = c("7dpc", "pc"),
    momento = "noche",
    carpeta_salida = "rasters/"
) {
  # Asegura que la carpeta exista
  if (!dir.exists(carpeta_salida)) dir.create(carpeta_salida, recursive = TRUE)
  
  # Loop por cada combinación de locacion y tipo_de_raster
  for (loc in locaciones) {
    for (tipo in tipos) {
      message("Procesando: ", tipo, " - ", loc)
      
      # Filtra SOLO esa combinación
      raster_data <- base_raster |>
        dplyr::filter(
          tipo_de_raster == tipo,
          momento == momento,
          locacion == loc
        )
      
      if (nrow(raster_data) == 0) {
        message("No hay datos para ", tipo, " - ", loc)
        next
      }
      
      for (i in seq_len(nrow(raster_data))) {
        ancho_px <- 700
        alto_px  <- 400
        
        archivo_salida <- paste0(
          carpeta_salida,
          deframe(raster_data[i, "file_info"]),
          ".png"
        )
        
        message("Guardando: ", archivo_salida)
        
        png(archivo_salida, width = ancho_px, height = alto_px, res = 150)
        
        # Carga raster
        r <- geocovidapp::rasterLoader(
          pool = pool,
          raster_data = raster_data[i, ],
          area = loc  # es un solo valor
        )
        
        # Clasificación de valores
        r_class <- terra::classify(r, rbind(
          c(40, Inf, 1),
          c(30, 40, 2),
          c(20, 30, 3),
          c(10, 20, 4),
          c(1, 10, 5),
          c(-1, 1, 6),
          c(-10, -1, 7),
          c(-20, -10, 8),
          c(-30, -20, 9),
          c(-40, -30, 10),
          c(-Inf, -40, 11)
        ))
        
        my_colors <- c(
          "#FF0000", "#FF3300", "#FF6600", "#FF9900", "#FFCC00",
          "#FFFFFF",
          "#00FFFF", "#00BFFF", "#0080FF", "#0040FF", "#0000FF"
        )
        
        levels(r_class) <- data.frame(
          ID = 1:11,
          category = c(
            "> 40", "30 a 40", "20 a 30", "10 a 20", "1 a 10",
            "-1 a 1",
            "-10 a -1", "-20 a -10", "-30 a -20", "-40 a -30", "< -40"
          )
        )
        
        plot(r_class, col = my_colors, legend = FALSE)
        
        dev.off()
      }
    }
  }
  
  message("✅ Todos los rasters se guardaron correctamente.")
}

# -------------------------------
# 3. Función para armar la tabla de imágenes
create_imgs_tbl <- function() {
  files <- list.files("rasters/", pattern = "\\.png$", full.names = TRUE)
  nombres_meses <- c(
    "enero", "febrero", "marzo", "abril", "mayo", "junio",
    "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"
  )
  extract_info <- function(path) {
    name <- basename(path)
    name <- str_remove(name, "\\.png$")
    parts <- str_split(name, "_", simplify = TRUE)
    tibble(
      file = path,
      prefix = parts[1],
      indicator = parts[2],
      date = as.Date(parts[3]),
      suffix = parts[4],
      month = nombres_meses[month(as.Date(parts[3]))],
      day = day(as.Date(parts[3])),
      weekday = weekdays(as.Date(parts[3]), abbreviate = TRUE),
      weekday_num = wday(as.Date(parts[3]), week_start = 1)
    )
  }
  map_dfr(files, extract_info)
}

# -------------------------------
# 4. Función para plotear tipo calendario
plot_calendar <- function(imgs_tbl) {
  plot_png <- function(row) {
    ggdraw(clip = "on") +
      draw_image(row$file) +
      draw_label(
        paste(row$weekday, row$day),
        x = 0.5, y = 1, vjust = 1.5, size = 9
      )
  }
  plot_blank <- function() ggdraw()
  
  imgs_tbl <- imgs_tbl |> arrange(date)
  months <- unique(imgs_tbl$month)
  
  for (m in months) {
    month_imgs <- imgs_tbl |> filter(month == m) |> arrange(date)
    if (nrow(month_imgs) == 0) next
    
    first_wday <- wday(min(month_imgs$date), week_start = 1)
    n_blanks <- first_wday - 1
    
    plots <- map(1:nrow(month_imgs), ~ plot_png(month_imgs[., ]))
    if (n_blanks > 0) {
      plots <- c(replicate(n_blanks, plot_blank(), simplify = FALSE), plots)
    }
    
    grid <- wrap_plots(plots, ncol = 7) +
      plot_annotation(title = m)
    print(grid)
  }
}
