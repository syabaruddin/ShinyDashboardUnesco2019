function(input, output)  {
  #Dashboard Global Tab--------------------------------------------------------------
  
  reactive_data <- reactive({
    whc %>%
      filter(region == input$regional)
    
  })
  
  
  output$numsites <- renderValueBox({
    num_sites <-  reactive_data() %>%
      group_by(region) %>%
      summarise(freq = n()) %>%
      pull(freq)
    
    
    
    valueBox(
      value = num_sites,
      subtitle = "Number of Sites",
      icon = icon("gopuram"),
      color = "green",
      width = 12
    )
    
  })
  
  output$numdanger <- renderValueBox({
    num_danger <- reactive_data() %>%
      filter(danger == "0") %>%
      group_by(region) %>%
      summarise(freq = n()) %>%
      pull(freq)
    
    
    
    valueBox(
      value = num_danger,
      subtitle = "Sites in Good Condition",
      icon = icon("smile"),
      color = "blue",
      width = 12
    )
    
  })
  
  reactive_kategori <- reactive({
    whc %>%
      filter(category == input$kategori)
  })
  
  output$num_kategori <- renderValueBox({
    numkategori <- reactive_kategori() %>%
      group_by(category) %>%
      summarise(freq = n()) %>%
      pull(freq)
    
    
    
    valueBox(
      value = numkategori,
      subtitle = "Number of Sites",
      icon = icon("pagelines"),
      color = "green",
      width = 12
    )
    
  })
  
  output$num_katdang <- renderValueBox({
    numkatdang <- reactive_kategori() %>%
      filter(danger == "0") %>%
      group_by(category) %>%
      summarise(freq = n()) %>%
      pull(freq)
    
    
    
    valueBox(
      value = numkatdang,
      subtitle = "Sites in Good Condition",
      icon = icon("smile"),
      color = "blue",
      width = 12
    )
    
  })
  
  
  reactive_tahun <- reactive({
    filter_column <- sym(input$register)
    
    whc %>%
      filter(region == input$register)
    
  })
  
  output$registerglobal <- renderPlotly({
    whdate <- reactive_tahun() %>%
      group_by(date_recorded, input$register) %>%
      summarise(freq = n()) %>%
      mutate(
        label = glue(
          "Year Recorded: {date_recorded}
        Region: {input$register}
        Number of Sites: {freq}"
        )
      ) %>%
      ggplot(aes(
        x = date_recorded,
        y = freq,
        text = label,
        col = input$register,
        group = 1
      )) +
      geom_line() + geom_point() +
      labs(title = "",
           x = "Registration Year",
           y = "Number of Sites") +
      theme_bw()
    
    ggplotly(whdate, tooltip = "text") %>% layout(showlegend = F)
    
  })
  
  reactive_cat <- reactive({
    filter_column <- sym(input$categorical)
    
    whc %>%
      filter(category == input$categorical)
    
  })
  
  output$categoricalglobal <- renderPlotly({
    whcat <- reactive_cat() %>%
      group_by(region) %>%
      summarise(freq = n())  %>%
      mutate(label = glue("Region: {region}
         Number of sites in this category: {freq}")) %>%
      ggplot(aes(
        y = reorder(region, freq),
        x = freq,
        text = label
      )) +
      geom_col(aes(fill = freq), show.legend = F) +
      scale_fill_gradient(low = "yellow", high = "orange") +
      theme_bw() +
      labs(title = "",
           x = "Number of Sites",
           y = "")
    
    
    ggplotly(whcat, tooltip = "text") %>%  layout(showlegend = F)
    
  })
  
  output$datatable <- renderDataTable(whc)
  
  output$mapglobal <- renderLeaflet({
    map <-
      leaflet() %>%
      addTiles() %>%
      addAwesomeMarkers(
        lng = whc$longitude,
        lat = whc$latitude,
        label = whc$name
      )
    
    map
    
  })
  
  reactive_negara <- reactive({
    whc %>%
      filter(country == input$negara)
    
  })
  
  
  output$cosites <- renderValueBox({
    count_sites <-  reactive_negara() %>%
      group_by(country) %>%
      summarise(freq = n()) %>%
      pull(freq)
    
    
    
    valueBox(
      value = count_sites,
      subtitle = "Number of Sites",
      icon = icon("gopuram"),
      color = "purple",
      width = 12
    )
    
  })
  
  reactive_neg <- reactive({
    whc %>%
      filter(region == input$neg)
    
  })
  
  output$coneg <- renderValueBox({
    count_neg <- reactive_neg() %>%
      group_by(country) %>%
      summarise(freq = n()) %>%
      select(country) %>%
      count(country) %>%
      summarise(jumlahnegara = sum(n)) %>%
      pull(jumlahnegara)
    
    
    valueBox(
      value = count_neg,
      subtitle = "Number of Countries Registered",
      icon = icon("pagelines"),
      color = "green",
      width = 12
    )
    
  })
  
  
  
  reactive_regcount <- reactive({
    filter_column <- sym(input$regcount)
    
    whc %>%
      filter(region == input$regcount)
    
  })
  
  output$registercount <- renderPlotly({
    whregcount <- reactive_regcount() %>%
      group_by(country) %>%
      summarise(freq = n())  %>%
      arrange(desc(freq)) %>%
      head(10) %>%
      mutate(label = glue("Country: {country}
         Number of sites in this country : {freq}")) %>%
      ggplot(aes(
        y = reorder(country, freq),
        x = freq,
        text = label
      )) +
      geom_col(aes(fill = freq), show.legend = F) +
      scale_fill_gradient(low = "yellow",
                          high = "green") +
      theme_bw() +
      labs(title = "",
           x = "Number of Sites",
           y = "")
    
    
    ggplotly(whregcount, tooltip = "text") %>%  layout(showlegend = F)
    
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}