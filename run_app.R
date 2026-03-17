# Script to run the Salt Dilution Discharge Calculator Shiny App

# Install required packages if not already installed
required_packages <- c("shiny", "DT", "ggplot2", "dplyr")

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    cat(paste("Installing package:", pkg, "\n"))
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Run the app
cat("\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("   Salt Dilution Discharge Calculator\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("\n")
cat("Starting the Shiny app...\n")
cat("The app will open in your default web browser.\n")
cat("Press Ctrl+C or Esc to stop the app.\n")
cat("\n")

shiny::runApp(getwd(), launch.browser = TRUE)
