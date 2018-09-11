
function(input, output) {
  
  data <- reactive({
    
    subset(HouseData, HouseData$date >= input$date[1] & 
                      HouseData$date <= input$date[2] &
                      HouseData$price >= input$price[1] &
                      HouseData$price <= input$price[2] &
                      HouseData$yr_built >= input$bltyr[1] &
                      HouseData$yr_built <= input$bltyr[2] &
                      HouseData$bedrooms %in% input$bedrooms &
                      HouseData$bathrooms %in% input$bathrooms &
                      HouseData$sqft_living >= input$homesqft[1] &
                      HouseData$sqft_living <= input$homesqft[2] &
                      HouseData$sqft_lot >= input$lotsqft[1] &          
                      HouseData$sqft_lot <= input$lotsqft[2] &
                      HouseData$floors == input$floors &
                      HouseData$waterfront == input$waterfront)
  })
  
  output$meanprice <- renderValueBox({
    data <- data.frame(data())
     valueBox(formatC(round(mean(data$price)),format = "d", big.mark = ",")
              ,"Mean Price", icon = icon('home'),
              color = 'purple'
              ) 
    })
  
  output$medianprice <- renderValueBox({
    data <- data.frame(data())
    valueBox(formatC(round(median(data$price)),format = "d", big.mark = ",")
             ,"Median Price", icon = icon('home'),
             color = 'purple') 
  })
  
  output$housingmap <- renderLeaflet({
    icons <- awesomeIcons(
      icon = 'home',
      iconColor = '#e34bn5',
      library = 'ion'
    )
    
  houses <- data.frame(data())
              
    m <- leaflet(data = houses) %>%
      addTiles() %>%
      addAwesomeMarkers(lng = houses$long,
                        lat = houses$lat,
                        icon = icons,
                        label = paste0("Price: $",formatC(houses$price,format = "d",big.mark = ","), " ; ",
                 'Built year: ',houses$yr_built))
  m
  })
    
  observeEvent(input$submit,
               {output$housingdata <- renderDataTable(
                 
                 datatable(data(), options = list(lengthMenu = c(10, 20, 35), paging = TRUE, searching = TRUE, lengthChange = TRUE, bInfo=0, bAutoWidth = TRUE,
                                                rownames=FALSE, deferRender = TRUE)) %>%
                   formatCurrency(columns = 3, currency = '$')
               )}
  )
  
  output$downloadfile <- downloadHandler(
    
    filename = function() {
      paste('Housing Data','.csv', sep='')
    },
    
    content = function(file) {
      write.csv(as.data.frame(data()), file)
    }
    
  )
  
}