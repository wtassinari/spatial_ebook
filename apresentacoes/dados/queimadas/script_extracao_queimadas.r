###########################################################
########### Base Rio de JAneiro #######################
#######################################################
# Carregar o pacote
library(geobr)
library(sf)  # O geobr carrega automaticamente, mas é bom garantir

# Baixar a malha de todos os municípios do estado do Rio de Janeiro para 2022
mapa_rj <- read_municipality(code_muni = "RJ", year = 2022)

# Visualizar um resumo dos dados baixados
print(mapa_rj)

# Exportar o objeto sf para o formato Shapefile
st_write(mapa_rj, dsn = "/home/wagner/Google Drive/UFRRJ/Estatistica_Espacial_EAD_2026/malhas/mapa_rj.shp", driver = "ESRI Shapefile")

#######################################################
########### Pacote queimadasR ######################
#################################################
# Instalar remotes (se necessário)
install.packages("remotes")

# Instalar o pacote 
remotes::install_github("wtassinari/queimadasR", force = TRUE)

library(queimadasR)

estados <- c("RIO DE JANEIRO")

dados <- download_focos_anual_periodo(
  data_inicio_str = "01/08/2025",
  data_fim_str    = "31/08/2025",
  estados_alvo    = "RIO DE JANEIRO",
  satelites_alvo  = NULL,   # Todos os satélites
  timeout         = 300,
  deduplicar_final = TRUE
)

head(dados_norte)
summary(dados_norte)
nrow(dados_norte)


library(dplyr)
dados_pontos <- dados |> select(latitude, longitude)
dados_geo <- dados |> select(latitude, longitude, frp)


# Exportar
library(writexl)
write_xlsx(dados_pontos, "queimadas_pontos.xlsx")
write_xlsx(dados_geo, "queimadas_geo.xlsx")


### Queimadas área
# Transformar -999 em NA

dados <- read_excel("dados/queimadas/queimadas_full.xlsx")

dados <- dados %>%
  mutate(
    numero_dias_sem_chuva = na_if(numero_dias_sem_chuva, -999),
    precipitacao = na_if(precipitacao, -999),
    risco_fogo = na_if(risco_fogo, -999),
    frp = na_if(frp, -999)
  )

# Agregar por município
dados <- dados %>%
  group_by(municipio) %>%
  summarise(
    n_queimadas = n(),                          # contagem de linhas
    media_frp = mean(frp, na.rm = TRUE),        # média FRP
    precipitacao_total = sum(precipitacao, na.rm = TRUE),
    precipitacao_media = mean(precipitacao, na.rm = TRUE),
    media_risco_fogo = mean(risco_fogo, na.rm = TRUE),
    media_dias_sem_chuva = mean(numero_dias_sem_chuva, na.rm = TRUE)
  ) %>%
  mutate(
    across(where(is.numeric), ~ifelse(is.nan(.x), 0, .x))
  )


library(geobr)
library(dplyr)
library(sf)
library(stringr)

mun_rj <- read_municipality(
  code_muni = "RJ",
  year = 2020
)

mun_rj <- mun_rj %>%
  mutate(municipio = str_to_upper(name_muni))

queimadas_area <- mun_rj %>%
  left_join(dados, by = "municipio") |>
  mutate(across(where(is.numeric), ~ifelse(is.na(.x), 0, .x))) %>%
  st_drop_geometry()

# Exportar
library(writexl)
write_xlsx(queimadas_area, "/home/wagner/Google Drive/UFRRJ/Estatistica_Espacial_EAD_2026/dados/queimadas/queimadas_area.xlsx")
