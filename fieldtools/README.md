# Field Sampling Timer - PWA Installation Guide

This is a Progressive Web App (PWA) that can be installed on Android devices to access the camera without HTTPS/localhost restrictions.

## Files
- `field_timer.html` - Main timer application
- `manifest.json` - PWA manifest for installation
- `service-worker.js` - Service worker for offline capability
- `app2.R` - R Shiny app for generating sampling schedules

## Installation on Android

### Method 1: Install as PWA (Recommended)

1. **Serve the files via HTTP server**
   - You can use any simple HTTP server (Python, Node.js, etc.)
   - Example with Python: `python -m http.server 8000` in the `fieldtools` folder
   - Access from your phone at `http://YOUR_PC_IP:8000/field_timer.html`

2. **Install the PWA**
   - Open Chrome on Android
   - Navigate to `http://YOUR_PC_IP:8000/field_timer.html`
   - Tap the menu (⋮) → **"Add to Home screen"** or **"Install app"**
   - The app will be installed and appear on your home screen

3. **Use the installed app**
   - Tap the app icon on your home screen
   - The app runs in standalone mode with full camera access
   - Works offline after first load

### Method 2: Open HTML file directly

1. Copy `field_timer.html` to your Android device
2. Open it with Chrome using a file manager
3. Camera access works with `file://` URLs

## Camera Permissions

Once installed as a PWA, the app has proper camera permissions:
- First time: Chrome will ask for camera permission
- Grant permission once, and it's remembered
- No HTTPS required when installed as PWA

## Features

- **QR Code Scanner**: Scan QR codes from the Shiny app to load sampling schedules
- **Manual Input**: Enter sampling times manually (one per line in seconds)
- **Timer**: Visual countdown with audio alerts
- **Save Results**: Export sampling data as CSV with timestamps
- **Offline**: Works offline after first installation

## Generating Sampling Schedules

Use `app2.R` in R/RStudio:
1. Calculate discharge and breakthrough curve
2. Click on plots to manually place sampling points
3. Go to Sampling tab to get QR code
4. Scan QR code with the mobile timer app

## Troubleshooting

**Camera not working?**
- Make sure you installed as PWA (not just bookmarked)
- Check Chrome Settings → Site Settings → Camera → Allow
- Try reloading the app

**Can't install as PWA?**
- Make sure you're accessing via HTTP server (not file://)
- Chrome must detect the manifest.json and service-worker.js
- Check browser console for errors

**App not working offline?**
- Visit the app at least once while online
- Service worker needs to cache resources first
- Check if service worker is registered in Chrome DevTools
