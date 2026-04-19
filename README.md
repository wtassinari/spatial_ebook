# Estatística Espacial — Ebook Quarto

**Métodos e Aplicações em Epidemiologia**  
Prof. Wagner Tassinari | FIOCRUZ / UFRRJ | 2026

---

## Estrutura do Projeto

```
spatial_ebook_project/
├── _quarto.yml              # Configuração principal do livro Quarto
├── index.qmd                # Página inicial (Bem-vindo)
├── 01-introducao.qmd        # Cap. 1: Introdução à Estatística Espacial
├── 02-tipos_dados.qmd       # Cap. 2: Tipologia dos Dados Espaciais
├── 03-dados_area.qmd        # Cap. 3: Dados de Área (+ Aplicações I–IV)
├── 04-padroes_pontuais.qmd  # Cap. 4: Padrões Pontuais (+ Aplicações V–VI)
├── 05-geoestatistica.qmd    # Cap. 5: Geoestatística (+ Aplicação VII)
├── 06-trabalho_final.qmd    # Cap. 6: Trabalho Final + Referências
├── references.bib           # Referências bibliográficas (BibTeX)
├── styles.css               # Estilos CSS customizados
├── figuras/                 # Imagens e capa do ebook
│   ├── capa_ebook.png       # Capa gerada por IA
│   ├── logo_ufrrj.png
│   ├── padrao_espacial.png
│   └── ...
└── dados/                   # (Necessário: copiar da pasta do curso)
    ├── dengue/
    ├── queimadas/
    ├── hanseniase/
    ├── pluviometria/
    └── trabalho_final/
```

---

## Pré-requisitos

### Software necessário

- **R** (versão ≥ 4.3.0): [https://cran.r-project.org/](https://cran.r-project.org/)
- **RStudio** (versão ≥ 2023.06) ou **Positron**: [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)
- **Quarto** (versão ≥ 1.4): [https://quarto.org/docs/get-started/](https://quarto.org/docs/get-started/)

### Pacotes R necessários

Execute o seguinte código no R para instalar todos os pacotes:

```r
pacotes <- c(
  # Manipulação de dados
  "tidyverse", "readxl", "dplyr", "tibble",
  
  # Visualização
  "ggplot2", "tmap", "leaflet", "mapview",
  "RColorBrewer", "viridis",
  
  # Dados espaciais
  "sf", "sp", "terra", "raster",
  "geobr", "rnaturalearth",
  
  # Estatística espacial
  "spdep", "spatialreg", "spgwr",
  "spatstat", "spatstat.explore",
  "gstat", "automap",
  
  # Utilitários
  "knitr", "kableExtra", "klippy"
)

install.packages(pacotes, dependencies = TRUE)
```

---

## Como Renderizar o Ebook

### Opção 1: Via Terminal

```bash
# Navegar até a pasta do projeto
cd caminho/para/spatial_ebook_project

# Renderizar em HTML (padrão)
quarto render

# Renderizar apenas em HTML
quarto render --to html

# Renderizar em PDF
quarto render --to pdf

# Renderizar em EPUB
quarto render --to epub
```

### Opção 2: Via RStudio / Positron

1. Abra o arquivo `_quarto.yml` no RStudio/Positron
2. Clique no botão **"Render Book"** na aba Build
3. Ou use o atalho: `Ctrl+Shift+B` (Windows/Linux) / `Cmd+Shift+B` (Mac)

### Opção 3: Via Console R

```r
quarto::quarto_render()
```

---

## Dados do Curso

Os dados utilizados nos exemplos práticos devem ser baixados separadamente:

📥 [Clique aqui para baixar os dados](https://drive.google.com/drive/folders/1lBUWVYcwFDBqrxdz6s0oxaiCS8gAVWj7?usp=sharing)

1. Baixe o arquivo `Estatistica_Espacial.zip`
2. Descomprima o arquivo
3. Copie a pasta `dados/` para dentro de `spatial_ebook_project/`

---

## Estrutura dos Capítulos

| Arquivo | Capítulo | Conteúdo Principal |
|---------|----------|-------------------|
| `index.qmd` | Bem-vindo | Apresentação, estrutura e dados do curso |
| `01-introducao.qmd` | 1. Introdução | Conceitos, ferramentas (QGIS, GeoDa, R, Python), bibliotecas R |
| `02-tipos_dados.qmd` | 2. Tipologia | Classificação de Cressie (1993): pontuais, geoestatísticos, área |
| `03-dados_area.qmd` | 3. Dados de Área | Mapas temáticos, Moran I, LISA, Bayes Empírico, SAR, CAR, GWR |
| `04-padroes_pontuais.qmd` | 4. Padrões Pontuais | CSR, Kernel, Aplicações (Queimadas, John Snow) |
| `05-geoestatistica.qmd` | 5. Geoestatística | Variograma, Krigagem, Validação cruzada (Pluviosidade RJ) |
| `06-trabalho_final.qmd` | 6. Trabalho Final | Roteiro avaliativo + Referências bibliográficas |

---

## Aplicações Práticas

| Aplicação | Tipo de Dado | Tema |
|-----------|-------------|------|
| I | Dados de Área | Mapa Temático Mundial da Expectativa de Vida |
| II | Dados de Área | Dengue no Estado do Rio de Janeiro |
| III | Dados de Área | Hanseníase no Mato Grosso (Bayes Empírico) |
| IV | Dados de Área | Queimadas/RJ — Regressão Espacial (SAR, CAR, GWR) |
| V | Padrões Pontuais | Focos de Queimadas no Rio de Janeiro |
| VI | Padrões Pontuais | Estudo de John Snow (Cólera em Londres, 1854) |
| VII | Geoestatística | Pluviosidade na Cidade do Rio de Janeiro |

---

## Contato

📧 **Prof. Wagner Tassinari**  
[tassinari@ufrrj.br](mailto:tassinari@ufrrj.br)  
FIOCRUZ / UFRRJ

---

*Construído com [Quarto](https://quarto.org/) — Posit PBC*
