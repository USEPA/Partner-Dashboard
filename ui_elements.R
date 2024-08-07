# All Indicators, One Condition Category
allIndicatorsOneConditionCategory <- function() {
  tags$div(
    class="dash-container",
    tags$div(
      class="chart-container",
        r2d3::d3Output("allindicators", height="100%", width="100%")
    )
  )
}


# One Indicator, All Condition Categories Dashboard
oneIndicatorAllConditionCategories <- function() {
  tags$div(
    class="dash-container",
    tags$div(
      class="chart-container",
      r2d3::d3Output("oneindicator", height="100%", width="100%")
    )
  )
}


# Dashboard Control Panel
controlPanel <- function() {
    tags$div(
      style = "font-weight: bold; font-size: 14px;", 
      class="controls-container",
      div(id="step4",
      uiOutput('state'),
      tags$head(tags$style(HTML("#resource_pop ~ .selectize-control.single .selectize-input {background-color: #eee; font-weight: bold;}"))),
      selectInput("resource_pop",
                  span("Select a Resource Type", 
                       style = "font-weight: bold; font-size: 16px"),
                  choices = "") %>%
        #Resource Type helper
        helper(type = "inline",
               icon = "circle-question",
               title = "Resource Type",
               content = c("The Resource Types shown are the aquatic resources which the State/Territory/Tribe has reported. Explore water quality conditions across Resource Types, if available."),
               size = "s", easyClose = TRUE, fade = TRUE),
      tags$head(tags$style(HTML("#primary_subpop ~ .selectize-control.single .selectize-input {background-color: #eee; font-weight: bold;}"))),
      selectInput("primary_subpop",
                  span("Select a Population", 
                       style = "font-weight: bold; font-size: 16px"),
                  choices = "") %>%
        #Subpopulation helper
        helper(type = "inline",
               icon = "circle-question",
               title = "Population",
               content = c("Explore water quality conditions across Populations, if available."),
               size = "s", easyClose = TRUE, fade = TRUE),
      conditionalPanel(
        condition = "output.comp_exists=='TRUE'",
        tags$head(tags$style(HTML("#comp_subpop ~ .selectize-control.single .selectize-input {background-color: #eee; font-weight: bold;}"))),
        selectInput("comp_subpop",
                    span("Select a Comparison Population", 
                         style = "font-weight: bold; font-size: 16px"),
                    choices = "") %>%
          #Comparison Subpopulation helper
          helper(type = "inline",
                 icon = "circle-question",
                 title = "Comparision Population",
                 content = c("Users can compare water quality conditions across populations by overlaying the confidence intervals of a comparison population."),
                 size = "s", easyClose = TRUE, fade = TRUE),
      ),
      conditionalPanel(
        condition = "input.tabs == 'all_indicator'",
        tags$head(tags$style(HTML("#condition_category ~ .selectize-control.single .selectize-input {background-color: #eee; font-weight: bold;}"))),
        selectInput("condition_category",
                    span("Select a Condition Category", 
                         style = "font-weight: bold; font-size: 16px"),
                    choices = "") %>%
          #Condition Category helper
          helper(type = "inline",
                 icon = "circle-question",
                 title = "Condition Category",
                 content = c("Condition Categories are set by States/Territories/Tribes to determine condition based on certain thresholds or benchmarks. Use the input to explore the results for different Condition Categories."),
                 size = "s", easyClose = TRUE, fade = TRUE)
      ),
      conditionalPanel(
        condition = "input.tabs == 'one_indicator'",
        tags$head(tags$style(HTML("#indicator ~ .selectize-control.single .selectize-input {border-color: black; border-width: 3px; background-color: #eee; font-weight: bold;}"))),
        selectInput("indicator",
                    span("Select an Indicator", 
                         style = "font-weight: bold; font-size: 16px"),
                    choices = "") %>%
          #Indicator helper
          helper(type = "inline",
                 icon = "circle-question",
                 title = "Indicator",
                 content = c("An Indicator represents the state or trend of certain environmental conditions over a given area and a specified period of time. Use the input to explore the results for different Indicators."),
                 size = "s", easyClose = TRUE, fade = TRUE)
      ),
      conditionalPanel(
        condition = "input.changediff != 'Only One Year Available'",
      tags$head(tags$style(HTML("#changediff ~ .selectize-control.single .selectize-input {background-color: #eee; font-weight: bold;}"))),
      selectInput("changediff",
                  span("Select Change Comparison", 
                       style = "font-weight: bold; font-size: 16px"),
                  choices = "") %>%
        #Change helper
        helper(type = "inline",
               icon = "circle-question",
               title = "Change Comparison",
               content = c("Often States/Territories/Tribes have collected data over numerous years. Use the input to compare the results across available years. <b>Please note
                           that the years shown are the years data was reported and not necessarily the collection year.</b>"),
               size = "s", easyClose = TRUE, fade = TRUE)
      ),
      
      tags$head(tags$style(HTML("#label ~ .selectize-control.single .selectize-input {background-color: #eee; font-weight: bold;}"))),
      selectInput("label",
                  span("Select Label Options", 
                       style = "font-weight: bold; font-size: 16px"),
                  list('Point Estimate', 'Confidence Intervals', 'None')) %>%
        #Label helper
        helper(type = "inline",
               icon = "circle-question",
               title = "Label Options",
               content = c("Choose a Label to display in the dashboard.",
                           "<b>Point Estimate:</b> Represents the condition estimate for the proportion of the population.",
                           "<b>Confidence Interval:</b> Margin of error around the estimate."),
               size = "s", easyClose = TRUE, fade = TRUE)),#div
      div(id="step5",
          fluidRow(
      conditionalPanel(
        condition = "input.tabs == 'all_indicator'",
          column(4, 
                    div(id="capture_all",
        capture::capture(
          selector = "#allindicators",
          format = "jpeg",
          filename = "All_Indicators_Dashboard.png",
          icon("camera"), 
          "",
          style = "font-size:25px;"
        )),
        bsTooltip("capture_all", "Screenshot the Dashboard",
                  "top"))
        ),
      conditionalPanel(
        condition = "input.tabs == 'one_indicator'",
          column(4, 
                 div(id="capture_one",
                     capture::capture(
                       selector = "#oneindicator",
                       format = "jpeg",
                       filename = "One_Indicator_Dashboard.png",
                       icon("camera"), 
                       "",
                       style = "font-size:25px;" 
                     )),
                 bsTooltip("capture_one", "Export Dashboard Image",
                           "top"))
        ),
     conditionalPanel(
       condition = "input.org_idcode !== ''",
       column(4, 
              downloadButton("dwnld", icon=icon("download"), "", 
                             style = "background-color:#337AB7;
                                         border-color:#FFFFFF;
                                         color:white;
                                         font-size:25px;"), 
              bsTooltip("dwnld", "Download the Data",
                        "top")),
     column(4, 
            actionButton("help", icon=icon('circle-info'), "",
                         style = "background-color:#e7ad24;
                                  border-color:#e7ad24;
                                  color:white;
                                  font-size:25px;"
            ),
            bsTooltip("help", "Help Interpretting the Dashboard",
                      "top"))
        )
      )
    )
  )
}
