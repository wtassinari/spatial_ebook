# Caso não o pacote pacman não esteja instalado
if(!require(pacman)) install.packages("pacman")

# Lendo as bibliotecas 
pacman::p_load(odbc, RMySQL, DBI, readr,gstat, sp, 
               sf, rgdal, raster, dplyr, hydroGOF, 
               leaflet, lattice, automap)

####################################################################
######################## krigagem ##################################
####################################################################
#####################################
pluvio <- read.csv("pluviosidade.csv", sep=";")


# Análise Gráfica Descritiva

quantil <- quantile(pluvio$acumulado_24h, seq(0,1,0.2))
quantil


# Transformar em um arquivo espacial
# x - Longitude
# y - Latitude
sp::coordinates(pluvio) = ~x + y
# sp::proj4string(pluvio) = CRS(proj4string(contorno.rio))

# Dado original

bubble(pluvio, "acumulado_24h", key.entries = quantil, pch=19, col="blue")

spplot(pluvio['acumulado_24h'], scales=list(draw=T), key.space="right", colorkey=T)

############ Análise e Interpolacao ####################
# Modelar o variograma experimental (ou empírico)
# width - Distância média entre amostras ou distância dos lags
# cutoff - Máxima distância
max(dist(pluvio@data))

variogram.emp = variogram(acumulado_24h ~x+y, pluvio, width=1000, cutoff=20000)
variogram.emp

# Variogram plot
plot(variogram.emp, main = "Empirical variogram", pch = 19, col = "#0080FF")

# Ajustando o semivariograma teórico
# https://vsp.pnnl.gov/help/Vsample/Kriging_Variogram_Model.htm
# psill - Semivariância estrutural ou contribuição (ponto máximo que chega ao plato no eixo de y)
# range - Alcance (ponto máximo em x)
# nugget - Efeito pepita, quando (y, 0)

## 1) Modelo Linear
lin.fit  = fit.variogram(variogram.emp, 
                          model = vgm(psill = 240, model = "Lin",
                                      range = 5000, nugget = 10))

## 2) Modelo exponencial
exp.fit  = fit.variogram(variogram.emp, 
                          model = vgm(psill = 240, model = "Exp",
                                      range = 5000, nugget = 10))

## 3) Modelo gaussiano
gau.fit  = fit.variogram(variogram.emp, 
                          model = vgm(psill = 240, model = "Gau",
                                      range = 5000, nugget = 10))

## 3) Modelo wave
wav.fit  = fit.variogram(variogram.emp, 
                         model = vgm(psill = 240, model = "Wav",
                                     range = 5000, nugget = 10))


par(mfrow=c(2,2))
plot(variogram.emp, lin.fit)
plot(variogram.emp, exp.fit)
plot(variogram.emp, gau.fit)
plot(variogram.emp, wav.fit)

##### Validação cruzada ####

# RMSE (root mean squared error): é a medida que calcula "a 
# raiz quadrática média" dos erros entre valores observados (reais) 
# e predições (hipóteses).

## 1) Modelo Linear
cv.lin <- krige.cv(acumulado_24h ~x+y, locations = pluvio, model = lin.fit)
summary(cv.lin)
plot(cv.lin$var1.pred ~ cv.lin$observed, cex = 1.2, lwd = 2)
abline(0, 1, col = "lightgrey", lwd = 2)
lm_lin <- lm(cv.lin$var1.pred ~ cv.lin$observed)
abline(lm_lin, col = "red", lwd = 2)
r2_lin = summary(lm_lin)$r.squared
rmse_lin = hydroGOF::rmse(cv.lin$var1.pred, cv.lin$observed)

## 2) Modelo exponencial
cv.exp <- krige.cv(acumulado_24h ~x+y, locations = pluvio, model = exp.fit)
summary(cv.exp)
plot(cv.exp$var1.pred ~ cv.exp$observed, cex = 1.2, lwd = 2)
abline(0, 1, col = "lightgrey", lwd = 2)
lm_exp <- lm(cv.exp$var1.pred ~ cv.exp$observed)
abline(lm_exp, col = "red", lwd = 2)
r2_exp = summary(lm_exp)$r.squared
rmse_exp = hydroGOF::rmse(cv.exp$var1.pred, cv.exp$observed)

## 3) Modelo Gaussiano
cv.gau <- krige.cv(acumulado_24h ~x+y, locations = pluvio, model = gau.fit)
summary(cv.gau)
plot(cv.gau$var1.pred ~ cv.gau$observed, cex = 1.2, lwd = 2)
abline(0, 1, col = "lightgrey", lwd = 2)
lm_gau <- lm(cv.gau$var1.pred ~ cv.gau$observed)
abline(lm_gau, col = "red", lwd = 2)
r2_gau = summary(lm_gau)$r.squared
rmse_gau = hydroGOF::rmse(cv.gau$var1.pred, cv.gau$observed)


## 3) Modelo Wave
cv.wav <- krige.cv(acumulado_24h ~x+y, locations = pluvio, model = wav.fit)
summary(cv.wav)
plot(cv.wav$var1.pred ~ cv.wav$observed, cex = 1.2, lwd = 2)
abline(0, 1, col = "lightgrey", lwd = 2)
lm_wav <- lm(cv.wav$var1.pred ~ cv.wav$observed)
abline(lm_wav, col = "red", lwd = 2)
r2_wav = summary(lm_wav)$r.squared
rmse_wav = hydroGOF::rmse(cv.wav$var1.pred, cv.wav$observed)

# Criar uma tabela das estatística de R2 e RMSE
df.r2 <- data.frame(r2_lin, r2_exp, r2_gau, r2_wav)
df.rmse <- data.frame(rmse_lin, rmse_exp, rmse_gau, rmse_wav)
temp <- data.frame(cbind(t(df.r2), t(df.rmse)))
colnames(temp) <- c('R2', 'RMSE')
rnames <- gsub('r2_','', rownames(temp)) # remove o prefixo r2 dos nomes das linhas
rownames(temp) <- rnames # substitui o nome das linhas simplificadas na tab original
View((temp))

################### Criando o grid para intermpolação #############
# Pegar o contorno do Rio
contorno.rio <- shapefile('malha/MUNIC_2K_2022_IPP_SIRGAS.shp')

# plot(rio.cont1)

# Criando grade para interpolacao
# Resolucao de 50 pixels
r <- raster(contorno.rio, res = 50)

# cria um objeto formato raster
rp <- rasterize(contorno.rio, r, 0) 

# Trasnsforma os pontos onde serao realizadas
grid <- as(rp, "SpatialPixelsDataFrame") 

sp::plot(grid)

#################### Krigagem  ####################

# Colocando os dados de chuva e o grid na mesma projecao
sp::proj4string(pluvio) = CRS(proj4string(contorno.rio))

mapa_chuva_lin <- krige(acumulado_24h ~1, pluvio, grid, model =lin.fit)
mapa_chuva_exp <- krige(acumulado_24h ~1, pluvio, grid, model =exp.fit)
mapa_chuva_gau <- krige(acumulado_24h ~1, pluvio, grid, model =gau.fit)
mapa_chuva_wav <- krige(acumulado_24h ~1, pluvio, grid, model =wav.fit)

par(mfrow=c(2,2))
plot(mapa_chuva_lin)
plot(mapa_chuva_exp)
plot(mapa_chuva_gau)
plot(mapa_chuva_wav)

##################################################################################
########### Auto Krige #########################################
# http://rstudio-pubs-static.s3.amazonaws.com/80464_9156596afb2e4dcda53e3650a68df82a.html

# Ordinary kriging
auto.krige = autoKrige(acumulado_24h~x+y, pluvio, grid, model = 'Exp')
summary(auto.krige)
# plot(auto.krige1)
# plot(auto.krige1$krige_output)

auto.krige.cv <- autoKrige.cv(acumulado_24h~x+y, pluvio, model = 'Exp')
summary(auto.krige.cv)


############ Convertendo para o formato raster - auto krige ############
raster_chuva <- raster(auto.krige$krige_output)
plot(raster_chuva)
# proj4string(raster_chuva_1w) = CRS(proj4string(rio.cont1)) # Nao colocar nessa projecao do contorno, senao nao dá para colcoar a projecao do leaflet

writeRaster(raster_chuva,
            filename = 'chuva_auto.tiff',
            format = 'GTiff',
            overwrite = T)


raster_chuva <- raster("chuva_auto.tiff")


########################## Mapa #############################
library(sf)

################ Estacoes ################################
estacoes.sf <- read_sf('malha/Estac_C3_B5es_Alerta_Rio.shp')
# Convertendo UTM para Lat Long das estacoes ####
estacoes.longlat <- st_transform(estacoes.sf, "+proj=longlat +ellps=WGS84 +datum=WGS84")
estacoes.longlat$coords <- st_coordinates(estacoes.longlat)
estacoes.longlat$X <- estacoes.longlat$coords[,1]
estacoes.longlat$Y <- estacoes.longlat$coords[,2]

################# CAPs ################################
bairros.sf <- read_sf('malha/BAIRROS_2K_2022_IPP_SIRGAS.shp')
# Convertendo UTM para Lat Long a malha das APs ####
bairros.longlat <- st_transform(bairros.sf, "+proj=longlat +ellps=WGS84 +datum=WGS84")

#################Convertendo o raster para lat long #################################
raster_chuva_longlat <- projectRaster(raster_chuva, crs = CRS("+proj=longlat +datum=WGS84"))
################ Paleta de cores ################################
paleta <- colorNumeric(c("#000066", "#00c8f8", "#F0E68C","#FFFF00", "#FF8C00"), values(raster_chuva_longlat),
                     na.color = "transparent", reverse = T)
#######################################################################
centro <- c(-43.45224, -22.92348)
caixa <- st_bbox(bairros.longlat)
###########################################################################

leaflet(data = estacoes.longlat, options = leafletOptions(
  attributionControl=FALSE)) |> 
  # addTiles() |>
  addProviderTiles("CartoDB.Positron", group = "Ruas") |>
  addProviderTiles("Esri.WorldImagery", options = providerTileOptions(opacity = 0.7), group = "Satélite") |> 
  addProviderTiles(providers$CartoDB.Voyager, group = "Voyager") |>
  addProviderTiles(providers$Stamen.Toner, group = "Toner") |>
  setView(lng = -43.42, lat = -22.90, zoom = 10.4) |>
  # addProviderTiles(providers$CartoDB.Voyager) |>
  addMarkers(~X, ~Y, popup = ~as.character(est), label = ~as.character(est),
             group = "Estações") |>
  ############## Polígonos dos Bairros ################
addPolygons(data=bairros.longlat,
            weight = 3,
            color = "darkblue",
            smoothFactor = 1,
            fill = FALSE,
            labelOptions = labelOptions(
              style = list("font-weight" = "normal", padding = "3px 8px"),
              textsize = "13px",
              direction = "auto"), 
            group = "Bairros") |>
########## Adicionando o raster  #########################
addRasterImage(raster_chuva_longlat, colors = pal, opacity = 0.8,
               group = "Chuva: 1 semana") %>%
  addLegend(pal = paleta, values = values(raster_chuva_longlat),
            title = "Chuva Acumulada - 1 semana", group = "Chuva: 1 semana") |>
############## Colocando o botão de refazer #####################
setMaxBounds(lng1 = -44.00,
             lat1 = -23.20,
             lng2 = -43.00,
             lat2 = -22.6 ) |> 
  setView(lng = -43.45224, lat = -22.92348, zoom = 11) |>  
  addEasyButton(easyButton(
    icon = 'fa-home',
    title = 'Reset view',
    onClick =  JS("function(btn, map) { 
       var groupLayer = map.layerManager.getLayerGroup('AP');
       map.fitBounds(groupLayer.getBounds());}" )   
  ) ) |>
############## Controle das layers (botoes) ################
addLayersControl(
  baseGroups = c("Voyager", "Ruas", "Satélite", "Toner"),
  overlayGroups = c("Estações", "Bairros",  "Chuva: 1 semana"),
  options = layersControlOptions(collapsed = FALSE),
  position = "bottomleft") |>
########## Desabilitando os grupos ################
hideGroup(group = c("Bairros"))


