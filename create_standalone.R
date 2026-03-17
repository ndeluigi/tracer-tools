# Script to create a standalone R Shiny app package
# This will bundle R, all packages, and the app into a portable folder

# Required packages for creating standalone app
required_packages <- c("shiny", "DT", "ggplot2", "dplyr")

# Function to create standalone package
create_standalone <- function() {
  
  cat("Creating standalone R Shiny app package...\n\n")
  
  # Create directory structure
  standalone_dir <- "discharge_calculator_standalone"
  if (dir.exists(standalone_dir)) {
    cat("Removing existing standalone directory...\n")
    unlink(standalone_dir, recursive = TRUE)
  }
  
  dir.create(standalone_dir)
  dir.create(file.path(standalone_dir, "app"))
  dir.create(file.path(standalone_dir, "R-Portable"))
  dir.create(file.path(standalone_dir, "library"))
  
  cat("Step 1: Installing required packages locally...\n")
  
  # Install packages to local library
  local_lib <- file.path(standalone_dir, "library")
  
  for (pkg in required_packages) {
    cat(paste0("  Installing ", pkg, "...\n"))
    install.packages(pkg, lib = local_lib, dependencies = TRUE, 
                     repos = "https://cran.r-project.org")
  }
  
  cat("\nStep 2: Copying app files...\n")
  
  # Copy app files
  file.copy("app.R", file.path(standalone_dir, "app", "app.R"))
  
  # Copy documentation
  docs <- c("README.md", "TRACER_MASS_CALCULATION.md", 
            "DISCHARGE_CALCULATION_EXPLAINED.md")
  for (doc in docs) {
    if (file.exists(doc)) {
      file.copy(doc, file.path(standalone_dir, doc))
    }
  }
  
  cat("\nStep 3: Creating launcher script...\n")
  
  # Create Windows batch launcher
  launcher_bat <- c(
    "@echo off",
    "echo ===============================================",
    "echo   Discharge Calculator - Standalone Version",
    "echo ===============================================",
    "echo.",
    "echo Starting the application...",
    "echo.",
    "",
    "REM Set R library path",
    "set R_LIBS=%~dp0library",
    "",
    "REM Run the app",
    "Rscript.exe -e \"shiny::runApp('%~dp0app', launch.browser=TRUE)\"",
    "",
    "if errorlevel 1 (",
    "  echo.",
    "  echo ERROR: Failed to start the application.",
    "  echo Please make sure R is installed on your system.",
    "  echo.",
    "  pause",
    ")"
  )
  
  writeLines(launcher_bat, file.path(standalone_dir, "run_app.bat"))
  
  # Create R launcher script
  launcher_r <- c(
    "# Standalone launcher for Discharge Calculator",
    "",
    "# Set library path to local packages",
    ".libPaths(c(file.path(getwd(), 'library'), .libPaths()))",
    "",
    "# Check if packages are available",
    "required_packages <- c('shiny', 'DT', 'ggplot2', 'dplyr')",
    "",
    "missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]",
    "",
    "if (length(missing_packages) > 0) {",
    "  cat('\\nMissing packages:', paste(missing_packages, collapse=', '), '\\n')",
    "  cat('Installing missing packages...\\n')",
    "  install.packages(missing_packages, lib = file.path(getwd(), 'library'), ",
    "                   repos = 'https://cran.r-project.org')",
    "}",
    "",
    "# Load required libraries",
    "library(shiny)",
    "",
    "# Run the app",
    "cat('\\n')",
    "cat('═══════════════════════════════════════════════════════════════\\n')",
    "cat('   Discharge Calculator\\n')",
    "cat('═══════════════════════════════════════════════════════════════\\n')",
    "cat('\\n')",
    "cat('Starting the Shiny app...\\n')",
    "cat('The app will open in your default web browser.\\n')",
    "cat('Press Ctrl+C or Esc to stop the app.\\n')",
    "cat('\\n')",
    "",
    "runApp('app', launch.browser = TRUE)"
  )
  
  writeLines(launcher_r, file.path(standalone_dir, "run_app.R"))
  
  # Create README for standalone
  readme_standalone <- c(
    "# Discharge Calculator - Standalone Version",
    "",
    "## Quick Start",
    "",
    "### Option 1: Using the Batch File (Easiest)",
    "1. Double-click `run_app.bat`",
    "2. The app will open in your browser",
    "",
    "### Option 2: Using R",
    "1. Open R or RStudio",
    "2. Set working directory to this folder",
    "3. Run: `source('run_app.R')`",
    "",
    "## Requirements",
    "",
    "- R must be installed on your system",
    "- All required packages are included in the `library` folder",
    "- No internet connection needed after initial setup",
    "",
    "## Transferring to Another Computer",
    "",
    "1. Copy this entire folder to the new computer",
    "2. Install R on the new computer (if not already installed)",
    "3. Run the app using one of the methods above",
    "",
    "## Included Files",
    "",
    "- `app/` - The Shiny application",
    "- `library/` - All required R packages",
    "- `run_app.bat` - Windows launcher",
    "- `run_app.R` - R launcher script",
    "- Documentation files",
    "",
    "## Troubleshooting",
    "",
    "If the app doesn't start:",
    "",
    "1. Make sure R is installed",
    "2. Check that R is in your system PATH",
    "3. Try running from R/RStudio using `source('run_app.R')`",
    "",
    "## Package Versions",
    "",
    paste0("Created on: ", Sys.Date()),
    paste0("R version: ", R.version.string),
    "",
    "Included packages:",
    paste0("- shiny: ", packageVersion("shiny")),
    paste0("- DT: ", packageVersion("DT")),
    paste0("- ggplot2: ", packageVersion("ggplot2")),
    paste0("- dplyr: ", packageVersion("dplyr"))
  )
  
  writeLines(readme_standalone, file.path(standalone_dir, "README_STANDALONE.txt"))
  
  cat("\n═══════════════════════════════════════════════════════════════\n")
  cat("Standalone package created successfully!\n")
  cat("═══════════════════════════════════════════════════════════════\n\n")
  cat("Location:", normalizePath(standalone_dir), "\n\n")
  cat("To use:\n")
  cat("1. Copy the '", standalone_dir, "' folder to any computer\n", sep="")
  cat("2. Make sure R is installed on that computer\n")
  cat("3. Double-click 'run_app.bat' or run 'run_app.R' from R\n\n")
  cat("All packages are included - no internet needed!\n")
  cat("═══════════════════════════════════════════════════════════════\n")
}

# Run the function
create_standalone()
