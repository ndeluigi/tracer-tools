# Portable Setup Instructions

This guide explains how to set up and run Tracer Tools as a portable application without installation.

## Prerequisites

You need R installed on your system. Download from [CRAN](https://cran.r-project.org/).

## First-Time Setup

### Step 1: Download the Repository

Download all files from the GitHub repository:
```
https://github.com/ndeluigi/tracer-tools
```

Or clone with git:
```bash
git clone https://github.com/ndeluigi/tracer-tools.git
cd tracer-tools
```

### Step 2: Install Required Packages

**Windows:**
1. Double-click `install_packages.R` and open with R
2. Or run from command line:
   ```
   Rscript install_packages.R
   ```

**Mac/Linux:**
```bash
Rscript install_packages.R
```

This will install: `shiny`, `DT`, `ggplot2`, `dplyr`, `qrcode`, `jsonlite`

## Running the App

### Windows
Double-click `run_app.bat`

The app will open automatically in your default web browser.

### Mac/Linux
1. Make the script executable (first time only):
   ```bash
   chmod +x run_app.sh
   ```

2. Run the app:
   ```bash
   ./run_app.sh
   ```

The app will open automatically in your default web browser.

### Alternative Method (Any OS)
Open R or RStudio and run:
```r
library(shiny)
runApp("app.R")
```

## Portable Distribution

To create a portable package for others:

1. **Copy these files to a folder:**
   - `app.R`
   - `field_timer.html`
   - `manifest.json`
   - `service-worker.js`
   - `install_packages.R`
   - `run_app.bat` (Windows)
   - `run_app.sh` (Mac/Linux)
   - `README.md`
   - `PORTABLE_SETUP.md`

2. **Zip the folder**

3. **Share with users** - they just need R installed

## Troubleshooting

**"R is not installed or not in PATH"**
- Install R from https://cran.r-project.org/
- Make sure R is added to your system PATH during installation

**"Package installation failed"**
- Check your internet connection
- Try running `install_packages.R` again
- Manually install packages in R:
  ```r
  install.packages(c("shiny", "DT", "ggplot2", "dplyr", "qrcode", "jsonlite"))
  ```

**App doesn't open in browser**
- The app is running at `http://127.0.0.1:XXXX` (port number shown in console)
- Manually open this URL in your browser
- Press Ctrl+C in the console to stop the app

## Mobile Timer App

The mobile field timer is available online at:
```
https://ndeluigi.github.io/tracer-tools/field_timer.html
```

No separate installation needed - just access from your phone's browser and install as PWA.

## File Structure

```
tracer-tools/
├── app.R                    # Main Shiny application
├── field_timer.html         # Mobile PWA timer
├── manifest.json            # PWA manifest
├── service-worker.js        # PWA offline support
├── install_packages.R       # Package installer
├── run_app.bat             # Windows launcher
├── run_app.sh              # Mac/Linux launcher
├── README.md               # Main documentation
└── PORTABLE_SETUP.md       # This file
```

## Updates

To update to the latest version:
1. Download the latest files from GitHub
2. Replace old files with new ones
3. Run `install_packages.R` again if packages have changed
