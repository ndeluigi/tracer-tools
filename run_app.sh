#!/bin/bash
# Launcher script for Tracer Tools (Mac/Linux)

echo "Starting Tracer Tools..."
echo ""

# Check if R is installed
if ! command -v Rscript &> /dev/null
then
    echo "ERROR: R is not installed or not in PATH."
    echo "Please install R from https://cran.r-project.org/"
    echo ""
    exit 1
fi

# Run the Shiny app
echo "Opening Tracer Tools in your browser..."
Rscript -e "shiny::runApp('app.R', launch.browser = TRUE)"
