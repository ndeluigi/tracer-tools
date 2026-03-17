# Installation Guide for Salt Dilution Discharge Calculator

## R Shiny App Installation

### Step 1: Install R

1. Go to [https://cran.r-project.org/](https://cran.r-project.org/)
2. Click on "Download R for Windows"
3. Click on "base"
4. Download and install the latest version of R

### Step 2: Install RStudio (Optional but Recommended)

1. Go to [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)
2. Download and install RStudio Desktop (free version)

### Step 3: Install Required Packages

Open R or RStudio and run:

```r
install.packages(c("shiny", "DT", "ggplot2", "dplyr"))
```

### Step 4: Run the App

#### Option A: Using RStudio (Easiest)
1. Open RStudio
2. File → Open File → Select `app.R` from this folder
3. Click the "Run App" button at the top of the editor

#### Option B: Using R Console
1. Open R
2. Run:
```r
library(shiny)
runApp("c:/Users/deluigi/Desktop/calcualtorq")
```

#### Option C: Using the Launch Script
1. Open R
2. Run:
```r
source("c:/Users/deluigi/Desktop/calcualtorq/run_app.R")
```

## Alternative: Python Version

If you prefer Python, I can create a Python version using Streamlit or Dash. Let me know!

## Troubleshooting

### "Package not found" error
Run the installation command again:
```r
install.packages(c("shiny", "DT", "ggplot2", "dplyr"))
```

### App won't start
1. Make sure you're in the correct directory
2. Check that `app.R` exists in the folder
3. Verify all packages are installed

### Port already in use
If you see "port already in use", either:
- Close other R sessions
- Or specify a different port:
```r
runApp(port = 8080)
```

## Quick Start Without Installation

If you want to use the calculator without installing R, you can:

1. Use the Python verification script: `verify_discharge_calc.py`
2. Modify the conductivity data in the script
3. Run: `python verify_discharge_calc.py`

Or use the standalone HTML calculator (if provided).

## System Requirements

- **Operating System**: Windows 10 or later
- **RAM**: 2 GB minimum, 4 GB recommended
- **Disk Space**: 500 MB for R and packages
- **Internet**: Required for initial installation only

## Getting Help

If you encounter issues:
1. Check the README.md file
2. Review the DISCHARGE_CALCULATION_EXPLAINED.md for methodology
3. Verify your R installation: `R --version` in command prompt
4. Check package installation: `library(shiny)` in R console
