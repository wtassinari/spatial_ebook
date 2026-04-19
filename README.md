# 📚 Estatística Espacial: Uma Breve Introdução

[![Quarto](https://img.shields.io/badge/built%20with-Quarto-blue)](https://quarto.org/)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![GitHub Pages](https://img.shields.io/badge/hosted%20on-GitHub%20Pages-green)](https://wtassinari.github.io/spatial_ebook/)

**Material educacional completo sobre análise espacial aplicada à epidemiologia.**

🔗 **Acesse o ebook:** [https://wtassinari.github.io/spatial_ebook/](https://wtassinari.github.io/spatial_ebook/)

---

## 📖 Sobre

Este é um **ebook interativo** desenvolvido para o curso de **Estatística Espacial: Métodos e Aplicações em Epidemiologia** ministrado pelo **Prof. Wagner Tassinari** na **UFRRJ/FIOCRUZ**.

O material abrange conceitos fundamentais e aplicações práticas de análise espacial, com foco especial em:

- **Mapeamento de doenças** — Análise de padrões de saúde em regiões geográficas
- **Dados de área** — Técnicas para dados agregados em unidades administrativas
- **Padrões pontuais** — Análise da localização específica de eventos de saúde
- **Geoestatística** — Estimação em locais não amostrados
- **Métodos Bayesianos** — Bayes Empírico asspacial e espacial

---

## 🎯 Objetivos do Curso

Ao concluir este material, você será capaz de:

✅ Compreender os conceitos fundamentais de análise espacial em epidemiologia  
✅ Aplicar métodos de mapeamento de doenças em **R**  
✅ Interpretar mapas de risco e taxa de doença  
✅ Executar análises de padrões pontuais espaciais  
✅ Realizar análises geoestatísticas com dados epidemiológicos  
✅ Implementar técnicas de Bayes Empírico para pequena área  

---

## 📚 Conteúdo do Ebook

### **Parte I: Fundamentos**

#### 1. **Introdução à Estatística Espacial**
- Conceitos básicos de análise espacial
- Ferramentas computacionais (QGIS, GeoDa, R, Python)
- Principais bibliotecas R para análise espacial
- Primeira Lei da Geografia de Tobler

#### 2. **Tipologia dos Dados Espaciais**
- Classificação segundo Cressie (1993)
- Dados pontuais (point-referenced data)
- Dados de área (areal data / lattice data)
- Dados geoestatísticos (geostatistical data)

---

### **Parte II: Análise por Tipo de Dado**

#### 3. **Dados de Área**
- Mapas temáticos e visualização
- Autocorrelação espacial (Índice de Moran's I)
- Indicadores Locais de Associação Espacial (LISA)
- Regressão espacial:
  - Modelo SAR (Spatial Autoregressive)
  - Modelo CAR (Conditional Autoregressive)
  - Regressão Geograficamente Ponderada (GWR)

**Aplicações Práticas:**
- Expectativa de vida mundial
- Dengue no Estado do Rio de Janeiro
- Hanseníase no Mato Grosso
- Queimadas e regressão espacial no RJ

#### 4. **Padrões Pontuais**
- Processos de pontos espaciais
- Complete Spatial Randomness (CSR)
- Análise Kernel (Kernel Density Estimation)
- Funções K e L
- Detecção de clusters

**Aplicações Práticas:**
- Focos de queimadas no Rio de Janeiro
- Estudo histórico: Cólera em Londres (John Snow, 1854)

#### 5. **Geoestatística**
- Variogramas e estrutura espacial
- Modelos de variograma (esférico, exponencial, gaussiano)
- Krigagem ordinária
- Kriagem com covariáveis
- Validação cruzada

**Aplicação Prática:**
- Interpolação de pluviosidade na Região Metropolitana do Rio de Janeiro

---

### **Parte III: Mapeamento Avançado de Doenças**

#### 6. **Bayes Empírico Asspacial**
- Razão de Morbidade/Mortalidade Padronizada (RME)
- Esperança de contagens
- Estimação de Bayes Empírico global
- Shrinkage de parâmetros
- Probabilidades de exceedance Bayesianas
- Intervalos críveis

#### 7. **Bayes Empírico Espacial**
- Pensamento espacial em epidemiologia
- Definições de vizinhos espaciais:
  - Contiguidade (Rook, Queen)
  - Distância (fixa, KNN, inversa)
  - Gráficos de esfera de influência
- Efeitos de borda
- Bayes Empírico com informação local
- Comparação entre métodos asspacial vs espacial

---

### **Parte IV: Conclusão**

#### 8. **Trabalho Final**
- Projeto integrador com dados reais
- Roteiro avaliativo
- Referências bibliográficas completas

---

## 🛠️ Tecnologia

Este ebook foi desenvolvido utilizando:

- **[Quarto](https://quarto.org/)** — Sistema de publicação científica (versão ≥ 1.4)
- **[R](https://cran.r-project.org/)** — Linguagem de programação estatística (≥ 4.3.0)
- **[RStudio](https://posit.co/download/rstudio-desktop/)** ou **[Positron](https://positron.posit.co/)** — IDEs para R
- **GitHub Pages** — Hospedagem do site

### Principais Pacotes R Utilizados

```r
# Manipulação de dados
tidyverse, dplyr, sf, tibble

# Visualização
ggplot2, tmap, leaflet, mapview
RColorBrewer, viridis, knitr

# Dados espaciais
sf, sp, terra, raster
geobr, rnaturalearth

# Estatística espacial
spdep, spatialreg, spgwr
spatstat, spatstat.explore
gstat, automap

# Utilities
kableExtra, klippy
```

---

## 📊 Aplicações Práticas Incluídas

| # | Tipo de Dado | Tema | Descrição |
|---|-------------|------|-----------|
| **I** | Dados de Área | Expectativa de vida | Mapa temático mundial com dados de saúde |
| **II** | Dados de Área | Dengue RJ | Análise de padrão espacial de dengue |
| **III** | Dados de Área | Hanseníase MT | Bayes Empírico asspacial |
| **IV** | Dados de Área | Queimadas RJ | Regressão espacial (SAR, CAR, GWR) |
| **V** | Padrões Pontuais | Queimadas | Análise Kernel de focos de fogo |
| **VI** | Padrões Pontuais | Cólera Londres | Recriação do estudo de John Snow (1854) |
| **VII** | Geoestatística | Pluviosidade RJ | Interpolação e validação cruzada |

---

## 📥 Como Usar Localmente

### Pré-requisitos

1. Instale [R](https://cran.r-project.org/) (≥ 4.3.0)
2. Instale [RStudio](https://posit.co/download/rstudio-desktop/) ou [Positron](https://positron.posit.co/)
3. Instale [Quarto](https://quarto.org/docs/get-started/)

### Instalação

```bash
# Clone o repositório
git clone https://github.com/wtassinari/spatial_ebook.git
cd spatial_ebook

# Abra em RStudio/Positron
# File → Open Project → spatial_ebook.Rproj
```

### Instalar Pacotes R

```r
pacotes <- c(
  # Manipulação
  "tidyverse", "readxl", "dplyr", "tibble",
  # Visualização
  "ggplot2", "tmap", "leaflet", "mapview",
  "RColorBrewer", "viridis",
  # Espacial
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

### Renderizar o Ebook

```bash
# Via terminal
quarto render

# Ou via RStudio
# Build → Render Book

# Ou via Console R
quarto::quarto_render()
```

O site será gerado em `docs/` e pode ser visualizado abrindo `docs/index.html` no navegador.

---

## 📂 Estrutura do Projeto

```
spatial_ebook/
├── _quarto.yml              # Configuração principal do livro
├── index.qmd                # Página inicial (Bem-vindo)
├── 01-introducao.qmd        # Cap. 1: Introdução
├── 02-tipos_dados.qmd       # Cap. 2: Tipologia dos Dados
├── 03-dados_area.qmd        # Cap. 3: Dados de Área
├── 04-padroes_pontuais.qmd  # Cap. 4: Padrões Pontuais
├── 05-geoestatistica.qmd    # Cap. 5: Geoestatística
├── 07-bayes_aspatial.qmd    # Cap. 7: Bayes Empírico Asspacial
├── 08-bayes_spatial.qmd     # Cap. 8: Bayes Empírico Espacial
├── 06-trabalho_final.qmd    # Cap. 6: Trabalho Final
├── references.bib           # Referências bibliográficas (BibTeX)
├── abnt.csl                 # Estilo de citação ABNT
├── styles.css               # Estilos CSS customizados
├── README.md                # Este arquivo
├── figuras/                 # Imagens e capa
│   ├── capa_ebook_v3.png   # Capa do ebook
│   ├── logo_ufrrj.png
│   └── ...
├── dados/                   # Dados dos exemplos
│   ├── dengue/
│   ├── queimadas/
│   ├── hanseniase/
│   ├── pluviometria/
│   └── trabalho_final/
├── docs/                    # Output renderizado (GitHub Pages)
│   ├── index.html
│   ├── 01-introducao.html
│   └── ...
└── .gitignore
```

---

## 📚 Referências Principais

- **Cressie, N.** (1993). *Statistics for Spatial Data*. Wiley-Interscience.
- **Waller, L. & Gotway, C.** (2004). *Applied Spatial Statistics for Public Health Data*. Wiley-Interscience.
- **Bivand, R., Pebesma, E. & Gómez-Rubio, V.** (2013). *Applied Spatial Data Analysis with R* (2nd ed.). Springer.
- **Lovelace, R., Nowosad, J. & Muenchow, J.** (2021). *Geocomputation with R*. https://geocompr.robinlovelace.net/
- **Druck, S., Carvalho, M. S., Câmara, G. & Monteiro, A. M. V.** (2004). *Análise Espacial de Dados Geográficos*. EMBRAPA.

---

## 👨‍🏫 Sobre o Professor

**Prof. Wagner Tassinari**

- Doutor em Epidemiologia
- Pesquisador em Epidemiologia Espacial
- **UFRRJ** — Universidade Federal Rural do Rio de Janeiro
- **FIOCRUZ** — Fundação Oswaldo Cruz

📧 **Contato:** [tassinari@ufrrj.br](mailto:tassinari@ufrrj.br)

---

## 📜 Licença

Este trabalho está licenciado sob a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

Você é livre para:
- ✅ Compartilhar — Copiar e redistribuir o material em qualquer meio ou formato
- ✅ Adaptar — Remixar, transformar e construir sobre o material

Com a obrigação de:
- 🏷️ Atribuir — Dar crédito apropriado, fornecer um link para a licença

---

## 🤝 Contribuições

Encontrou um erro ou tem uma sugestão? 

- 📧 **Email:** tassinari@ufrrj.br
- 🐛 **Issues:** [GitHub Issues](https://github.com/wtassinari/spatial_ebook/issues)
- 📝 **Pull Requests:** Contribuições são bem-vindas!

---

## 🙏 Agradecimentos

Este material foi desenvolvido com base em:

- Curso "Spatial Epidemiology Workshop" - [E. Peterson](https://bookdown.org/epeterson_2010/spatial_epidemiology_workshop/)
- Comunidade R de análise espacial
- Comunidade Quarto
- Todos os estudantes que forneceram feedback

---

## 📊 Estatísticas do Projeto

- **Total de Capítulos:** 8
- **Páginas (aprox.):** 150+
- **Aplicações Práticas:** 7
- **Referências Bibliográficas:** 20+
- **Código R (linhas):** 1000+

---

## 🔗 Links Rápidos

- 🌐 **Website:** https://wtassinari.github.io/spatial_ebook/
- 📁 **GitHub:** https://github.com/wtassinari/spatial_ebook
- 📖 **Quarto:** https://quarto.org/
- 🔍 **R:** https://www.r-project.org/
- 📚 **Geocomputation with R:** https://geocompr.robinlovelace.net/

---

## 📝 Citação

Se você usar este material em sua pesquisa ou ensino, por favor cite como:

```bibtex
@book{tassinari2026,
  title={Estatística Espacial: Uma Breve Introdução},
  author={Tassinari, Wagner},
  year={2026},
  publisher={UFRRJ/FIOCRUZ},
  url={https://wtassinari.github.io/spatial_ebook/}
}
```

---

**Última atualização:** Abril de 2026  
**Versão:** 1.0

---

<div align="center">

**Desenvolvido com ❤️ para a comunidade científica**

[Quarto](https://quarto.org/) • [R](https://www.r-project.org/) • [GitHub Pages](https://pages.github.com/)

</div>
