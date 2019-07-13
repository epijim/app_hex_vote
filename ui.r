fluidPage(

  tags$head(
    tags$meta(name="google-signin-scope",content="profile email"),
    tags$meta(name="google-signin-client_id", content="929050326827-9d96o8evlkrup0av7f44s2rhavij776g.apps.googleusercontent.com"),
    HTML('<script src="https://apis.google.com/js/platform.js?onload=init"></script>'),
    includeScript("signin.js"),
    useShinyjs()
  ),

  titlePanel("Hex sticker voting"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(
      # Login:  ----
      helpText("Please login using your Roche google account"),
      div(
        id="signin",
        class="g-signin2",
        "data-onsuccess"="onSignIn"
        ),
      hidden(
        actionButton(
          "signout",
          "Sign Out",
          onclick="signOut();",
          class="btn-danger")
        ),
      hr(),
      with(tags, dl(dt("User:"), dd(textOutput("g.user")),
                    dt("Image"), dd(uiOutput("g.image")) )),
      hr(),
      # Input:  ----
      DT::dataTableOutput('full_list'),
      hr(),
      # Vote: ----
      helpText("You must be logged in and have selected a sticker to vote"),
      actionButton("submit", "Submit vote for selected"),
      textOutput("yourvote")
    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: ----
      imageOutput('selected_image'),
      plotOutput("plot")

    )
  )

)
