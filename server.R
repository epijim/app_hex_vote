shinyServer(function(input, output, session) {

    # server-side processing
    output$x3 = DT::renderDataTable(
        metadata,
        selection = 'single',
        options = list(paging = FALSE, searching = FALSE),
        server = TRUE)

    # print the selected indices
    output$x4 = renderImage({
        s <- input$x3_rows_selected

        validate(
            need(!is.null(s), "Please select a hex sticker")
        )

        s <- metadata %>%
            filter(
                row_number() == s
            ) %>%
            pull(filename)

        list(
            src = paste0("data/",s),
            contentType = 'image/png',
            width = 400,
            height = 400,
            alt = "A selected image")
    }, deleteFile = FALSE)

})
