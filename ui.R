
navbarPage( title="", id="nav", position = "static-top", windowTitle = "Stay In School",
           
           tabPanel(h3("Welcome"),
                         mainPanel(img(src = "stayinschool_flashpage.png", height = 700, width = 1200), align = "Center")
             ), 
            
           tabPanel(h3("Predict Dropout Rate"),
                    sidebarPanel(
                      radioButtons("Category", "Category", choices=c("ST", "SC", "OBC", "General"),selected = "General", inline = TRUE,width = NULL),
                      sliderInput("StudentTeacherRatio", "Students per Teacher", min=20, max=50, value=30),
                      sliderInput("StudentClassroomRation", "Students per Classroom", min=20, max=60, value=35),
                      sliderInput("ChildLabour", "% of children engaged in child labour", min=0, max=10, value=4),
                      sliderInput("AvgTeachersPerSchool", "Average number of teachers per school", min=2, max=10, value=4),
                      sliderInput("MarriedBelowLegalAgeFemales", "% of girls married before 18", min=0, max=30, value=7),
                      sliderInput("Schooling", "% of children attending school", min=70, max=100, value=90),
                      sliderInput("MarriedIlliterateWomen", "% of Married Illiterate Women", min=20, max=80, value=50),
                      sliderInput("EffectiveLiteracyRate", "Literacy Rate", min=50, max=90, value=70),
                      sliderInput("SexRatio", "Sex Ratio", min=800, max=1200, value=940)    
                    ),
                    mainPanel(
                      h1(textOutput('dropout'))
                    )
           ),
           
           tabPanel(h3("Visualize Data"),
                    h3("Factors influencing student dropout rate in Uttar Pradesh"),
                    hr(),
                    fluidPage(
                      plotlyOutput("plot"),
                      verbatimTextOutput("event")
                    )
           ),
           
           tabPanel(h3("Explore Raw Data"),
                    h3("Factors influencing student dropout rate in Uttar Pradesh"),
                    hr(),
                    DT::dataTableOutput("mytable")
           ),
           
           tabPanel(h3("Dropout Factors"),
                    h3("Factors which influence student dropout, ranked by importance"),
                    hr(),
                    mainPanel(img(src = "dropoutFactors.png", height = 400, width = 600), align = "Center")
                     
           ),
           
           conditionalPanel("false", icon("crosshair"))
)