fluidPage(

  title = 'Select Table Rows',

  h1('A Server-side Table'),

  fluidRow(
    column(3, DT::dataTableOutput('x3')),
    column(9, imageOutput('x4'))
  ),

  hr()

)
