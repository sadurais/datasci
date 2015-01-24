---
title: "Shiny App documentation for Storm Data Analysis"
author: "Sathish Duraisamy"
date: "January 24, 2015"
output: html_document
runtime: shiny
---

## Introduction
This R Markdown document explains about the Shiny App created for
viewing the analysis done on US National Ocean And Atmospheric Administration
[NOAA](http://www.noaa.gov) Storm database. This database documents the weather/storm events
happened in US during the years 1950-2011. This app uses a filtered extract
of that data and answers the questions such as:
Which weather events caused the most damage to Human Life/Injuries?
Which weather events caused the most damage to Property and Crops in US?


## Inputs and Outputs
This app lets the user select the type of damage s/he wants to see. And also
select the Top-N records of that data to be displayed in tabular form. The N
choices are 5, 10 and 15.

Output will be a plot of Damage (log scale) to the Event Type (y-axis) and 
a table display of the top-N severe events.


<!--html_preserve--><div class="container-fluid">
<div class="row">
<div class="col-sm-12">
<h1>Impact of Storm Events on Humans/Propery in US for years 1950-2011</h1>
</div>
</div>
<div class="row">
<div class="col-sm-4">
<form class="well">
<div id="impact_on" class="form-group shiny-input-radiogroup shiny-input-container">
<label class="control-label" for="impact_on">
<h3>Select the Impact on:</h3>
</label>
<div class="shiny-options-group">
<div class="radio">
<label>
<input type="radio" name="impact_on" id="impact_on1" value="1" checked="checked"/>
<span>Human Life/Injury</span>
</label>
</div>
<div class="radio">
<label>
<input type="radio" name="impact_on" id="impact_on2" value="2"/>
<span>Property/Crops</span>
</label>
</div>
</div>
</div>
<div class="form-group shiny-input-container">
<label for="top_n">Display top N severe events:</label>
<input id="top_n" type="number" class="form-control" value="5" min="5" max="15" step="5"/>
</div>
<div>
<button type="submit" class="btn btn-primary">Go</button>
</div>
</form>
</div>
<div class="col-sm-8">
<p>
Note: The Storm/Weather data used in this app is a filtered extract of much
           detailed dataset obtained from U.S. National Oceanic and Atmospheric
          Administration 
<a href="http://www.noaa.gov/">(NOAA)</a>
 storm database
</p>
<br/>
<div class="row">
<div id="plot" class="shiny-plot-output" style="width: 100% ; height: 400px"></div>
</div>
<div class="row">
<br/>
<hr/>
<h2>
<div id="top_n_txt" class="shiny-text-output"></div>
</h2>
<div id="top_n_events" class="shiny-html-output"></div>
</div>
</div>
</div>
</div><!--/html_preserve-->

```
## Error in output$plot <- renderPlot({: object 'output' not found
```

```
## Error in output$top_n_events <- renderTable({: object 'output' not found
```

```
## Error in output$top_n_txt <- renderText({: object 'output' not found
```


--end--
