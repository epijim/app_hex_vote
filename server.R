shinyServer(function(input, output, session) {
    # sign in
    output$g.user = renderText({input$g.name})
    output$g.image = renderUI({ img(src=input$g.image) })

    observe({
        if (isTruthy(input$g.id)) {
            show("signout")
            hide("signin")
        } else {
            show("signin")
            hide("signout")
        }
    })

    # server-side processing
    output$full_list = DT::renderDataTable(
        metadata,
        selection = 'single',
        options = list(paging = FALSE, searching = FALSE),
        server = TRUE)

    # selected hex
    selected_hex <- reactive({
        s <- input$full_list_rows_selected

        validate(
            need(!is.null(input$g.email), "Please login")
        )

        validate(
            need(
                !is.null(s),
                "Please select a hex sticker from the table on the left")
        )

        s <- metadata %>%
            filter(
                row_number() == s
            ) %>%
            pull(filename)
    })

    # print the selected image
    output$selected_image = renderImage({
        list(
            src = paste0("data/",selected_hex()),
            contentType = 'image/png',
            width = 400,
            height = 400,
            alt = "A selected image")
    }, deleteFile = FALSE)

    # Whenever a field is filled, aggregate all form data
    formData <- reactive({
        data <- tibble(
            name = input$g.name,
            email = input$g.email,
            vote = selected_hex()
        )
        data
    })

    # Hide submit till data ready
    observe({
        if (is.null(input$g.email) || is.null(input$full_list_rows_selected)) {
            shinyjs::disable("submit")
        } else {
            shinyjs::enable("submit")
        }
    })

    # When the Submit button is clicked, save the form data
    observeEvent(input$submit, {
        saveData(formData())
    })

})
