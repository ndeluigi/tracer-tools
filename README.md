# Tracer Tools - Stream Discharge & Field Sampling Timer

A comprehensive tool for stream discharge measurements and field sampling, consisting of:
1. **R Shiny App** (`app.R`) - Calculate discharge and generate sampling schedules
2. **Mobile Field Timer** (`field_timer.html`) - Progressive Web App for field sampling with offline support

## Files
- `app.R` - R Shiny app for discharge calculations and sampling schedule generation
- `field_timer.html` - Mobile timer PWA for field use
- `manifest.json` - PWA manifest for installation
- `service-worker.js` - Service worker for offline capability

---

# Part 1: R Shiny App (app.R)

## Features

- **Discharge calculations**: Q_salt, Q_rhoWT, and Injections methods
- **Manual sampling point placement**: Click on plots to place sampling points where you want them
- **Interactive plots**: Visualize breakthrough curves
- **QR code generation**: Creates QR codes with sampling schedules for the mobile app
- **Temperature correction**: Automatic Rhodamine WT fluorescence correction
- **Data export**: Download results as CSV

## Installation

### Prerequisites

You need R installed on your system. Download from [CRAN](https://cran.r-project.org/).

### Install Required Packages

```r
install.packages(c("shiny", "DT", "ggplot2", "dplyr", "qrcode", "jsonlite"))
```

## Running the Shiny App

```r
library(shiny)
runApp("app.R")
```

## How to Use

### Workflow 1: Calculate Discharge (Q_salt or Q_rhoWT)

1. Navigate to **Q_salt** or **Q_rhoWT** tab
2. Enter your parameters (mass, background, time step, temperature)
3. Paste your conductivity/fluorescence timeseries data
4. Click **Calculate**
5. View results and plots

### Workflow 2: Calculate Tracer Masses (Injections)

1. Navigate to **Injections** tab
2. Enter salt slug test parameters
3. Set target tracer concentrations
4. Paste conductivity timeseries
5. Click **Calculate Tracer Masses**

### Workflow 3: Generate Sampling Schedule

1. After calculating in Injections tab, go to **Plot** tab
2. **Click on the plots** to manually place sampling points where you want them
3. Use **Clear All**, **Undo Last**, or **Auto-Suggest** buttons to adjust
4. Go to **Sampling** tab to see:
   - Your sampling schedule with times
   - QR code for mobile app
   - Copyable list of times

---

# Part 2: Mobile Field Timer (PWA)

## Installation on Android/iOS

### Method 1: Install as PWA (Recommended)

**Access the hosted app:**
- Open Chrome (Android) or Safari (iOS)
- Navigate to `https://ndeluigi.github.io/tracer-tools/field_timer.html`
- Tap the menu (⋮ on Android, Share button on iOS) → **"Add to Home screen"** or **"Install app"**
- The app will be installed and appear on your home screen

**Use the installed app:**
- Tap the app icon on your home screen
- The app runs in standalone mode
- Works offline after first load

## Camera Permissions

**Android:**
- Once installed as PWA, Chrome will ask for camera permission
- Grant permission once, and it's remembered
- If blocked, use your phone's built-in Camera app to scan QR codes, then manually enter the times

**iOS:**
- iOS does not allow installed web apps to access the camera
- Use your iPhone's built-in Camera app to scan QR codes
- Copy the numbers and use "Enter Schedule Manually" in the app

## Features

- **QR Code Scanner**: Scan QR codes from the Shiny app to load sampling schedules (Android only when installed)
- **Manual Input**: Enter sampling times manually (one per line in seconds) - works on all platforms
- **Timer**: Visual countdown with audio alerts
- **Save Results**: Export sampling data as CSV with timestamps and injection name
- **Offline**: Works offline after first installation

## Generating Sampling Schedules

Use `app.R` in R/RStudio:
1. Calculate discharge and breakthrough curve
2. Click on plots to manually place sampling points
3. Go to Sampling tab to get QR code
4. Scan QR code with your phone's built-in camera app
5. Copy the numbers and paste into the timer app using "Enter Schedule Manually"

## Troubleshooting

**Camera not working?**
- **iOS**: Camera is not supported in installed web apps - use built-in Camera app + manual input
- **Android**: Make sure you installed as PWA (not just bookmarked)
- Check Chrome Settings → Site Settings → Camera → Allow
- Try reloading the app
- **Workaround for both**: Use phone's built-in Camera app to scan QR, then manually enter times

**Can't install as PWA?**
- Make sure you're accessing via HTTPS (GitHub Pages URL)
- Chrome/Safari must detect the manifest.json and service-worker.js
- Check browser console for errors

**App not working offline?**
- Visit the app at least once while online
- Service worker needs to cache resources first
- Check if service worker is registered in browser DevTools
