#!/usr/bin/env Rscript
# Automated script to create a portable discharge calculator app
# Run this script once to create a standalone package

cat("\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("   Creating Portable Discharge Calculator\n")
cat("═══════════════════════════════════════════════════════════════\n\n")

# Configuration
output_dir <- "DischargeCalculator_Portable"
required_packages <- c("shiny", "DT", "ggplot2", "dplyr")

# Step 1: Create directory structure
cat("Step 1: Creating directory structure...\n")
if (dir.exists(output_dir)) {
  cat("  Removing existing directory...\n")
  unlink(output_dir, recursive = TRUE)
}

dir.create(output_dir)
dir.create(file.path(output_dir, "app"))
dir.create(file.path(output_dir, "library"))
dir.create(file.path(output_dir, "docs"))

cat("  ✓ Directories created\n\n")

# Step 2: Install packages to local library
cat("Step 2: Installing R packages locally...\n")
cat("  This may take a few minutes...\n\n")

local_lib <- normalizePath(file.path(output_dir, "library"), mustWork = FALSE)

for (pkg in required_packages) {
  cat(paste0("  Installing ", pkg, "..."))
  
  tryCatch({
    install.packages(pkg, 
                     lib = local_lib, 
                     dependencies = TRUE,
                     repos = "https://cran.r-project.org",
                     quiet = TRUE)
    cat(" ✓\n")
  }, error = function(e) {
    cat(" ✗ FAILED\n")
    cat("    Error:", conditionMessage(e), "\n")
  })
}

cat("\n")

# Step 3: Copy app files
cat("Step 3: Copying application files...\n")

file.copy("app.R", file.path(output_dir, "app", "app.R"), overwrite = TRUE)
cat("  ✓ app.R copied\n")

# Copy documentation if exists
docs_to_copy <- c(
  "README.md",
  "TRACER_MASS_CALCULATION.md",
  "DISCHARGE_CALCULATION_EXPLAINED.md",
  "Q_measurement_salt_inj.xlsx"
)

for (doc in docs_to_copy) {
  if (file.exists(doc)) {
    file.copy(doc, file.path(output_dir, "docs", doc), overwrite = TRUE)
    cat(paste0("  ✓ ", doc, " copied\n"))
  }
}

cat("\n")

# Step 4: Create launcher scripts
cat("Step 4: Creating launcher scripts...\n")

# Windows batch file
bat_content <- c(
  "@echo off",
  "title Discharge Calculator",
  "cls",
  "echo ===============================================",
  "echo    Discharge Calculator",
  "echo ===============================================",
  "echo.",
  "echo Starting application...",
  "echo.",
  "",
  "REM Set library path to use local packages",
  "set R_LIBS=%~dp0library",
  "",
  "REM Check if Rscript is available",
  "where Rscript.exe >nul 2>nul",
  "if %ERRORLEVEL% NEQ 0 (",
  "    echo ERROR: R is not installed or not in PATH",
  "    echo.",
  "    echo Please install R from: https://cran.r-project.org/",
  "    echo.",
  "    pause",
  "    exit /b 1",
  ")",
  "",
  "REM Run the app",
  "Rscript.exe -e \".libPaths(c('%R_LIBS%', .libPaths())); shiny::runApp('%~dp0app', launch.browser=TRUE)\"",
  "",
  "if %ERRORLEVEL% NEQ 0 (",
  "    echo.",
  "    echo ERROR: Failed to start application",
  "    echo.",
  "    pause",
  ")"
)

writeLines(bat_content, file.path(output_dir, "START_APP.bat"))
cat("  ✓ START_APP.bat created\n")

# R script launcher
r_launcher <- c(
  "# Discharge Calculator - Portable Launcher",
  "# This script runs the app using local packages",
  "",
  "# Set library path to local packages first",
  "local_lib <- file.path(getwd(), 'library')",
  ".libPaths(c(local_lib, .libPaths()))",
  "",
  "# Verify packages are available",
  "required <- c('shiny', 'DT', 'ggplot2', 'dplyr')",
  "available <- sapply(required, function(pkg) {",
  "  requireNamespace(pkg, quietly = TRUE)",
  "})",
  "",
  "if (!all(available)) {",
  "  missing <- required[!available]",
  "  cat('\\nERROR: Missing packages:', paste(missing, collapse=', '), '\\n')",
  "  cat('\\nTrying to install missing packages...\\n')",
  "  ",
  "  for (pkg in missing) {",
  "    install.packages(pkg, lib = local_lib, repos = 'https://cran.r-project.org')",
  "  }",
  "}",
  "",
  "# Load shiny",
  "library(shiny)",
  "",
  "# Display startup message",
  "cat('\\n')",
  "cat('═══════════════════════════════════════════════════════════════\\n')",
  "cat('   Discharge Calculator\\n')",
  "cat('═══════════════════════════════════════════════════════════════\\n')",
  "cat('\\n')",
  "cat('Starting application...\\n')",
  "cat('The app will open in your web browser.\\n')",
  "cat('\\n')",
  "cat('To stop: Press Ctrl+C or close this window\\n')",
  "cat('\\n')",
  "",
  "# Run the app",
  "runApp('app', launch.browser = TRUE)"
)

writeLines(r_launcher, file.path(output_dir, "START_APP.R"))
cat("  ✓ START_APP.R created\n\n")

# Step 5: Create README
cat("Step 5: Creating README...\n")

readme_content <- c(
  "═══════════════════════════════════════════════════════════════",
  "   DISCHARGE CALCULATOR - PORTABLE VERSION",
  "═══════════════════════════════════════════════════════════════",
  "",
  "This is a standalone version of the Discharge Calculator that",
  "includes all required R packages. No internet connection needed!",
  "",
  "═══════════════════════════════════════════════════════════════",
  "   QUICK START",
  "═══════════════════════════════════════════════════════════════",
  "",
  "METHOD 1: Double-click START_APP.bat (Windows)",
  "  - Easiest method",
  "  - Opens automatically in your browser",
  "",
  "METHOD 2: Run from R/RStudio",
  "  1. Open R or RStudio",
  "  2. Set working directory to this folder",
  "  3. Run: source('START_APP.R')",
  "",
  "═══════════════════════════════════════════════════════════════",
  "   REQUIREMENTS",
  "═══════════════════════════════════════════════════════════════",
  "",
  "- R must be installed (download from https://cran.r-project.org/)",
  "- All packages are included in the 'library' folder",
  "- No internet connection needed after setup",
  "",
  "═══════════════════════════════════════════════════════════════",
  "   TRANSFERRING TO ANOTHER COMPUTER",
  "═══════════════════════════════════════════════════════════════",
  "",
  "1. Copy this ENTIRE folder to USB drive or network",
  "2. On the new computer:",
  "   - Install R (if not already installed)",
  "   - Copy the folder",
  "   - Double-click START_APP.bat",
  "",
  "That's it! No package installation needed.",
  "",
  "═══════════════════════════════════════════════════════════════",
  "   FOLDER CONTENTS",
  "═══════════════════════════════════════════════════════════════",
  "",
  "app/           - The Shiny application",
  "library/       - All required R packages (shiny, DT, ggplot2, dplyr)",
  "docs/          - Documentation and example data",
  "START_APP.bat  - Windows launcher",
  "START_APP.R    - R launcher script",
  "README.txt     - This file",
  "",
  "═══════════════════════════════════════════════════════════════",
  "   TROUBLESHOOTING",
  "═══════════════════════════════════════════════════════════════",
  "",
  "Problem: \"R is not installed or not in PATH\"",
  "Solution: Install R from https://cran.r-project.org/",
  "",
  "Problem: \"Package not found\"",
  "Solution: Make sure the 'library' folder is in the same",
  "          directory as START_APP.bat",
  "",
  "Problem: App won't start",
  "Solution: Try running START_APP.R from R/RStudio instead",
  "",
  "═══════════════════════════════════════════════════════════════",
  "   PACKAGE INFORMATION",
  "═══════════════════════════════════════════════════════════════",
  "",
  paste0("Created: ", Sys.time()),
  paste0("R Version: ", R.version.string),
  "",
  "Included packages:",
  paste0("  - shiny ", packageVersion("shiny")),
  paste0("  - DT ", packageVersion("DT")),
  paste0("  - ggplot2 ", packageVersion("ggplot2")),
  paste0("  - dplyr ", packageVersion("dplyr")),
  "",
  "═══════════════════════════════════════════════════════════════"
)

writeLines(readme_content, file.path(output_dir, "README.txt"))
cat("  ✓ README.txt created\n\n")

# Step 6: Verify installation
cat("Step 6: Verifying installation...\n")

all_good <- TRUE

# Check app file
if (file.exists(file.path(output_dir, "app", "app.R"))) {
  cat("  ✓ App file present\n")
} else {
  cat("  ✗ App file missing\n")
  all_good <- FALSE
}

# Check packages
for (pkg in required_packages) {
  pkg_path <- file.path(local_lib, pkg)
  if (dir.exists(pkg_path)) {
    cat(paste0("  ✓ Package ", pkg, " installed\n"))
  } else {
    cat(paste0("  ✗ Package ", pkg, " missing\n"))
    all_good <- FALSE
  }
}

# Check launchers
if (file.exists(file.path(output_dir, "START_APP.bat"))) {
  cat("  ✓ Windows launcher present\n")
} else {
  cat("  ✗ Windows launcher missing\n")
  all_good <- FALSE
}

cat("\n")

# Final message
cat("═══════════════════════════════════════════════════════════════\n")
if (all_good) {
  cat("   ✓ PORTABLE APP CREATED SUCCESSFULLY!\n")
} else {
  cat("   ⚠ COMPLETED WITH WARNINGS\n")
}
cat("═══════════════════════════════════════════════════════════════\n\n")

cat("Location:", normalizePath(output_dir), "\n\n")

cat("Next steps:\n")
cat("  1. Test: Double-click", file.path(output_dir, "START_APP.bat"), "\n")
cat("  2. Transfer: Copy the entire folder to any computer with R\n")
cat("  3. Run: Double-click START_APP.bat on the new computer\n\n")

cat("Folder size:", round(sum(file.info(list.files(output_dir, recursive = TRUE, full.names = TRUE))$size) / 1024^2, 1), "MB\n\n")

cat("═══════════════════════════════════════════════════════════════\n")
