# Install required packages for Tracer Tools
# Run this script once before using the app

cat("Installing required packages for Tracer Tools...\n\n")

# List of required packages
packages <- c("shiny", "DT", "ggplot2", "dplyr", "qrcode", "jsonlite")

# Check which packages are already installed
installed <- packages %in% rownames(installed.packages())
to_install <- packages[!installed]

if (length(to_install) > 0) {
  cat("Installing packages:", paste(to_install, collapse = ", "), "\n")
  install.packages(to_install, repos = "https://cran.r-project.org")
} else {
  cat("All required packages are already installed.\n")
}

cat("\nPackage installation complete!\n")
cat("You can now run the app using run_app.bat (Windows) or run_app.sh (Mac/Linux)\n")
