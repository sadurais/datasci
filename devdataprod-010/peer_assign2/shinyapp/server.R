library(shiny)
library(dplyr)
library(reshape2)
library(ggplot2)
library(scales)

#
# Title: Shiny Application to display the Storm Data Impact on US Population/Property 1950-2011
# Author: Sathish Duraisamy
# Date: Jan 24, 2015
#

shinyServer(function(input, output) ({
    plot_damage <- reactive({
        df <- read.csv("storm_data_analysis_short.csv", header=TRUE)

        if (input$impact_on == 1) {
            dfh <- df %>%
                filter(tot_fatal > 0 | tot_injur > 0) %>%
                arrange(tot_fatal)
            y_scale <- seq_along(1:NROW(dfh))
            dfh <- dfh %>% mutate(evtype_f = factor(y_scale, levels=y_scale, labels=evtype))

            dfh # This is the final contents of our Tidy data, just before plotting

            # Melt a 3 column dataset into a 2 column dataset for easy
            # two series-of-points plotting in the same plot
            df2 <- melt(dfh[,c("evtype_f", "tot_fatal", "tot_injur")], id="evtype_f")
            df2$variable <- gsub("tot_fatal", "Fatalities", df2$variable)
            df2$variable <- gsub("tot_injur", "Injuries", df2$variable)

            plot <- ggplot(df2,
                           aes(y=evtype_f, x=log(value), colour=variable, size=value)) +
                geom_point(shape=20) +
                scale_size_continuous(range = c(4,15)) +
                ylab("Event Type") +
                xlab("Health Impact (Fatalities/Injuries) in log scale") +
                ggtitle("Storm Events impact on US Population Health for 1950-2011")

            top_n_events <- head(arrange(dfh, -tot_fatal)[,c(1,2,3)], input$top_n)
            names(top_n_events) <- c("EventType", "TotalDeathCount", "TotalInjuryCount")
            return(list(plot, top_n_events))
        } else {
            dfp <- df %>%
                filter(complete.cases(evtype, tot_propdmg, tot_cropdmg) &
                           tot_propdmg > 0 | tot_cropdmg > 0) %>%
                arrange(tot_propdmg)
            y_scale <- seq_along(1:NROW(dfp))
            dfp <- dfp %>% mutate(evtype_f = factor(y_scale, levels=y_scale, labels=evtype))

            dfp # This is the final contents of our Tidy data, just before plotting

            # Melt a 3 column dataset into a 2 column dataset for easy
            # two series-of-points plotting in the same plot
            df2 <- melt(dfp[,c("evtype_f", "tot_cropdmg", "tot_propdmg")], id="evtype_f")
            df2$variable <- gsub("tot_cropdmg", "Crops", df2$variable)
            df2$variable <- gsub("tot_propdmg", "Properties", df2$variable)

            plot <- ggplot(df2, aes(y=evtype_f, x=log(value), colour=variable, size=value)) +
                geom_point(shape=20) +
                scale_size_continuous(range = c(4,15), labels=comma) +
                ylab("Event Type") +
                xlab("Financial Impact (Crops/Property damages) in log scale") +
                ggtitle("Storm events impact on US Properties/Crops for 1950-2011")

            top_n_events <- head(arrange(dfp, -tot_propdmg)[,c(1,4,5)], input$top_n)
            names(top_n_events) <- c("EventType", "TotalPropertyDamage", "TotalCropDamage")
            return(list(plot, top_n_events))
        }
    });


    output$plot <- renderPlot({
        results <- plot_damage()

        pl <- results[[1]]

        print(pl)
    });

    output$top_n_events <- renderTable({
        results <- plot_damage()
        top_n_events <- results[[2]]
        top_n_events
    });

    output$top_n_txt <- renderText({
        paste("Top ", input$top_n, " most severe events are: ", sep="")
    })
}))
