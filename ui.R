anos = unique(dataset$ano) %>% as.data.frame()
ano_min = min(anos)
ano_max = max(anos)

dashboardPage(
  dashboardHeader(title = 'Dashboard'),
  
dashboardSidebar(
  sidebarMenu(id = 'sidebarmenu',
              menuItem('Home', tabName = 'tabHome', icon = icon('home')),
              menuItem('Introducao', tabName = 'tabIntroducao', icon = icon('comments-o')),
              menuItem('Base de dados', tabName = 'tabBasedados', icon = icon('database')),
              menuItem('Graficos', tabName = 'tabGraficos', icon = icon('sitemap'),
                       menuItem('Atentados',
                                tabName = 'tabAtentados',
                                icon = icon('fire'),
                                menuSubItem('Ao longo dos anos',
                                            tabName = 'tabAtentadosAnos',
                                            icon = icon('line-chart'))),
                       menuItem('Grupos terroristas',
                                tabName = 'tabGrupos',
                                icon = icon('fire'),
                                menuSubItem('Grupos mais atuantes',
                                            tabName = 'tabTerroristGroups',
                                            icon = icon('bar-chart')),
                                menuSubItem('Outros Grupos',
                                            tabName = 'tabOutrosGrupos',
                                            icon = icon('line-chart'))),
                       menuItem('Mapas',
                                tabName = 'tabMapas',
                                icon = icon('fire'),
                                menuSubItem('Mapa1',
                                            tabName = 'tabMapa1',
                                            icon = icon('globe')),
                                menuSubItem('Mapa2',
                                            tabName = 'tabMapa2',
                                            icon = icon('globe')))
              ))),
  
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
          column(12, includeHTML("html/introducao.html"))
        )
      ),
      
      
      # Limpeza de dados
      tabItem(
        tabName = 'tabBasedados',
        fluidRow(
          column(12, includeHTML("html/base.html"))
        )
      ),
      
      # Dashboard tab
      tabItem(
        tabName = 'tabAtentadosAnos', 
        fluidRow(
          box(
            title = 'Numero de atentados ao longo dos anos',
            width = 8,
            plotOutput('atentados_por_ano')
          ),
          
          box(
            title = 'Selecione um periodo',
            width = 4,
            sliderInput('periodo_dashboard', 'Intervalo:', ano_min, ano_max, c(dataset), step = 1, dragRange = TRUE)
          )
        )
      ),
      
      # Teste tab
      tabItem(
        tabName = 'tabTerroristGroups',
        fluidRow(
          box(
            title = 'Grupos mais atuantes',
            width = 8,
            plotOutput('grupos_mais_atuantes')
          ),
          
          box(
            title = 'Selecione um periodo',
            width = 4,
            sliderInput('periodo_terrorist', 'Intervalo:', ano_min, ano_max, c(dataset), step = 1, dragRange = TRUE)
          )
        ),
        
        fluidRow(
          box(
            title = 'Atividades dos grupos ao longo dos anos',
            width = 8,
            plotOutput('atividades_grupos_mais_atuantes')
          )
        )
      )
    )
  )
)
