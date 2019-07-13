fluidPage(

  title = 'Vote for the RWD Forum hex sticker!',

  h1('Vote for the RWD Forum hex sticker!'),

  fluidRow(
    column(3, DT::dataTableOutput('full_list')),
    column(9, imageOutput('selected_image'))
  ),

  hr()

)
