# GeoCovid Buenos Aires <img src="imagenes/geocovid_bsas_logo.png" align="right" height="150" />

  Este repositorio contiene cuatro reportes que recopilan el procesamiento de 
  los datos de COVID-19, movilidad ciudadana, mapas vectoriales e imágenes 
  raster para provincia de Buenos Aires en el marco de la creación de 
  la aplicación GeoCovid app Buenos Aires.

## Código
#### 1. Creación de los mapas vectoriales de Buenos Aires y sus centroides

- Los mapas de las comunas de Ciudad Autónoma de Buenos Aires
fueron descargados de [BA Data](https://data.buenosaires.gob.ar/dataset/comunas/resource/Juqdkmgo-612222-resource), 
mientras que los poligonos correspondientes a los
partidos de provincia de Buenos Aires se descargaron
del [Instituto Geográfico Nacional Argentino](https://www.ign.gob.ar/NuestrasActividades/InformacionGeoespacial/CapasSIG).

#### 2. Análisis de la base de datos de casos de COVID-19 

- Se analizaron unicamente datos para prov. de Buenos Aires.

- Se crean nuevas variables para su uso en [GeoCovid app](https://github.com/Fernandez-Lab-WSU/geocovid_app).

- Archivo historico de casos de COVID-19 registrados desde el 01/03/2020 hasta
el 04/06/2022 - [Dirección Nacional de Epidemiología y Análisis de Situación de Salud](https://datos.gob.ar/dataset/salud-covid-19-casos-registrados-republica-argentina/archivo/salud_fd657d02-a33a-498b-a91b-2ef1a68b8d16).  
Estos datos son públicos y fueron consultados en Julio de 2023 en [www.datos.salud.gob.ar](http://datos.salud.gob.ar/dataset/covid-19-casos-registrados-en-la-republica-argentina).

#### 3. Creación de imagenes raster

- Los datos de movilidad ciudadana fueron brindados por
[Data for Good - Meta](https://dataforgood.facebook.com/)

- El procesamiento de los datos y la generacion de los rasters fue realizado
usando el [paquete `quadkeyr`](https://github.com/Fernandez-Lab-WSU/quadkeyr). 

#### 4. Cálculo de la movilidad porcentual por departamento de prov. de Bs.As.

- Los datos de movilidad ciudadana fueron brindados por
[Data for Good - Meta](https://dataforgood.facebook.com/) y se promediaron para
 los mapas vectoriales de prov. de Buenos Aires mencionados en el punto 1.

## Proyectos relacionados
El paquete `quadkeyr`, GeoCovid Buenos Aires y GeoCovid App son parte del mismo
proyecto.

- [Paquete `quadkeyr`](https://github.com/Fernandez-Lab-WSU/quadkeyr)
Permite el analisis de datos de movilidad ciudadana de Meta y su conversión
a imagenes raster.

- [GeoCovid app](https://github.com/Fernandez-Lab-WSU/geocovid_app)
Dashboard que permite la visualización de datos de COVID-19 y 
movilidad ciudadana en conjunto.

## Licencias

- El código contenido en este repositorio se encuentra bajo una [licencia MIT](). 
- El informe contenido en este documento es compartido bajo una licencia [Atribución-NoComercial-CompartirIgual 4.0 Internacional](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.es). 
Consulte el archivo de licencia para obtener más información. 
Si reutiliza información de este reporte proporcione la atribución y el enlace
a esta página web empleando esta cita:

> TBD

## Código de Conducta

El proyecto GeoCovid Buenos Aires, GeoCovid app y el paquete `quadkeyr`
se encuentran bajo un [Código de Conducta](https://www.contributor-covenant.org/es/version/1/4/code-of-conduct/). 
