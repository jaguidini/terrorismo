# Gera lista de anos 
anos <- unique(dataset$ano)
ano_min <- min(anos)
ano_max <- max(anos)

# Gera lista de países
paises <- dataset %>% group_by(pais) %>% summarise(atentados = n()) %>% filter(atentados > 50)
paises <- paises[order(paises$pais), ] %>% select(pais)

dashboardPage(
  dashboardHeader(title = 'Global Terrorism'),
  
  dashboardSidebar(
    sidebarMenu(
      # Home
      menuItem('Home', tabName = 'tabHome', icon = icon('home')),
      
      # Introducao
      menuItem('Introdução', tabName = 'tabIntroducao', icon = icon('comments-o')),
      
      # Database
      menuItem('Base de dados', tabName = 'tabBasedados', icon = icon('database')),
      
      # Atentados
      menuItem(text = 'Eventos',
               tabName = 'atentados',
               icon = icon('fire'),
               
               # Ao longo dos anos
               menuSubItem(text= 'Ao longo dos anos',
                           tabName = 'atentados_anos',
                           icon = icon('line-chart')),
               
               # Tipo de ataque
               menuSubItem(text = 'Tipo de ataque',
                           tabName = 'tipo_ataque',
                           icon = icon('bar-chart'))),
      
      # Grupos Terroristas
      menuItem(text = 'Grupos Terroristas',
               tabName = 'grupos',
               icon = icon('fire'),
               
               # Mais atuantes
               menuSubItem(text = 'Mais atuantes',
                           tabName = 'grupos_mais_atuantes',
                           icon = icon('bar-chart'))),
      
      # Mapa 
      menuItem(text = 'Mapa',
               tabName = 'mapa',
               icon = icon('map-marker'))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Home
      tabItem(
        tabName = 'tabHome',
        fluidRow(
          column(12, includeHTML("html/home.html"))
        )
      ),
      
      # Introducao
      tabItem(
        tabName = 'tabIntroducao',
        fluidRow(
          box(
            width = 12,
            column(12, includeHTML("html/introducao.html")),
            plotOutput('correlacao', height = 500)
          )
        )
      ),
      
      # Base de dados
      tabItem(
        tabName = 'tabBasedados',
        fluidRow(
          column(12, includeHTML("html/base.html"))
        )
      ),
      
      # Atentados ao longo dos anos
      tabItem(
        tabName = 'atentados_anos',
        
        fluidRow(
          column(
            width = 4,
            box(
              width = 12,
              h2('Filtros'),
              sliderInput('interval', 'Intervalo:', ano_min, ano_max, c(dataset), step = 1, dragRange = TRUE),
              selectInput('countries', 'País', paises, selected = 'United States', multiple = TRUE, selectize = TRUE)
            )
          ),
          
          column(
            width = 8,
            
            fluidRow(
              box(
                title = 'Eventos',
                width = 12,
                plotlyOutput('atentados_por_ano')
              ),
              
              box(
                title = 'Eventos',
                width = 12,
                plotlyOutput('atentados_por_pais')
              )
            ),
            
            fluidRow(
              box(
                title = 'Vítimas',
                width = 12,
                plotlyOutput('mortos_feridos_por_ano')
              ),
              
              box(
                title = 'Efetividade',
                width = 12,
                plotlyOutput('atentados_sucesso_falha')
              )
            )
          )
        )
      ),
      
      # Tipo de ataque
      tabItem(
        tabName = 'tipo_ataque',
        
        fluidRow(
          column(
            width = 4,
            box(
              width = 12,
              h2('Filtros'),
              sliderInput('interval2', 'Intervalo:', ano_min, ano_max, c(dataset), step = 1, dragRange = TRUE),
              selectInput('countries2', 'País', paises, selected = 'United States', multiple = TRUE, selectize = TRUE)
            )
          ),
          
          column(
            width = 8,
            fluidRow(
              box(
                title = 'Eventos por tipo',
                width = 12,
                plotlyOutput('atentados_por_tipo_ataque')
              )
            )
          )
        )
      ),
      
      # Grupos mais atuantes
      tabItem(
        tabName = 'grupos_mais_atuantes',
        
        fluidRow(
          column(
            width = 4,
            box(
              width = 12,
              h2('Filtros'),
              sliderInput('interval3', 'Intervalo:', ano_min, ano_max, c(dataset), step = 1, dragRange = TRUE),
              selectInput('countries3', 'País', paises, selected = 'United States', multiple = TRUE, selectize = TRUE)
            )
          ),
          
          column(
            width = 8,
            fluidRow(
              box(
                title = 'Grupos mais atuantes',
                width = 12,
                plotlyOutput('grupos_mais_atuantes')
              ),
              
              box(
                title = 'Atividades por grupo ao longo dos anos',
                width = 12,
                plotlyOutput('atividades_grupos_mais_atuantes')
              )
            )
          )
        )
      ),
      
      tabItem(
        tabName = 'mapa',
        column(
          width = 4,
          box(
            width = 12,
            h2('Filtros'),
            sliderInput('interval4', 'Intervalo:', ano_min, ano_max, c(dataset), step = 1, dragRange = TRUE),
            selectInput('countries4', 'País', paises, selected = 'United States', multiple = TRUE, selectize = TRUE)
          )
        ),
        
        column(
          width = 8,
          fluidRow(
            box(
              title = 'Mapa',
              width = 12,
              leafletOutput("mapa")
            )
          )
        )
      )
    )
  )
)
