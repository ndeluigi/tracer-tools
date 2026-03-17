# Creating a Standalone R Shiny App

## Method 1: Package with Local Library (Recommended)

This method creates a portable folder with all R packages included.

### Step 1: Run the Setup Script

In R or RStudio, run:
```r
source("create_standalone.R")
```

This will create a folder called `discharge_calculator_standalone` containing:
- The app
- All required R packages
- Launcher scripts
- Documentation

### Step 2: Transfer to Another Computer

1. Copy the entire `discharge_calculator_standalone` folder to a USB drive or network location
2. On the new computer, install R (only R, no packages needed)
3. Copy the folder to the new computer
4. Double-click `run_app.bat` (Windows) or run `run_app.R` from R

**No internet needed on the new computer!**

---

## Method 2: Fully Portable with R Portable (Windows Only)

For a completely self-contained solution that doesn't require R to be installed:

### Step 1: Download R Portable

1. Go to https://sourceforge.net/projects/rportable/
2. Download R-Portable (e.g., R-Portable_4.3.1.paf.exe)
3. Extract it to get the R-Portable folder

### Step 2: Create Package Structure

Create this folder structure:
```
discharge_calculator_portable/
├── R-Portable/           (extracted R-Portable folder)
├── app/
│   └── app.R
├── library/              (local R packages)
├── run_app.bat
└── README.txt
```

### Step 3: Install Packages to Local Library

Run this in R:
```r
# Set local library path
local_lib <- "path/to/discharge_calculator_portable/library"
dir.create(local_lib, showWarnings = FALSE)

# Install packages
install.packages(c("shiny", "DT", "ggplot2", "dplyr"), 
                 lib = local_lib, 
                 dependencies = TRUE,
                 repos = "https://cran.r-project.org")
```

### Step 4: Create Launcher

Create `run_app.bat`:
```batch
@echo off
echo Starting Discharge Calculator...
echo.

REM Set paths
set R_PORTABLE=%~dp0R-Portable\App\R-Portable
set R_LIBS=%~dp0library
set PATH=%R_PORTABLE%\bin\x64;%PATH%

REM Run the app
"%R_PORTABLE%\bin\x64\Rscript.exe" -e "shiny::runApp('%~dp0app', launch.browser=TRUE)"

pause
```

### Step 5: Package and Distribute

Zip the entire `discharge_calculator_portable` folder. Users can:
1. Extract the zip anywhere
2. Double-click `run_app.bat`
3. No installation needed!

---

## Method 3: Simple Offline Package (Easiest)

For situations where R is already installed on the target computer:

### Step 1: Download Packages Offline

On a computer with internet:

```r
# Create a folder for packages
dir.create("offline_packages", showWarnings = FALSE)

# Download packages and all dependencies
download.packages(
  pkgs = c("shiny", "DT", "ggplot2", "dplyr"),
  destdir = "offline_packages",
  type = "win.binary",  # or "source" for all platforms
  dependencies = TRUE
)
```

### Step 2: Create Installation Script

Create `install_offline.R`:
```r
# Install packages from local folder
local_packages <- list.files("offline_packages", pattern = "\\.zip$", full.names = TRUE)

for (pkg in local_packages) {
  install.packages(pkg, repos = NULL, type = "win.binary")
}

cat("All packages installed!\n")
cat("Now run: source('run_app.R')\n")
```

### Step 3: Package Everything

Create a folder with:
- `app.R`
- `offline_packages/` (folder with all .zip files)
- `install_offline.R`
- `run_app.R`
- Documentation

### Step 4: On the New Computer

1. Install R (one-time, no internet after this)
2. Copy the folder
3. Run `source('install_offline.R')` once
4. Run `source('run_app.R')` to start the app

---

## Comparison

| Method | Pros | Cons |
|--------|------|------|
| **Method 1: Local Library** | Easy, works on any OS | Requires R installed |
| **Method 2: R Portable** | Fully self-contained | Windows only, larger size (~500MB) |
| **Method 3: Offline Packages** | Smallest size | Requires one-time package installation |

---

## Recommended Approach

**For most users: Use Method 1**

1. Run `source("create_standalone.R")` once
2. Get a folder with everything included
3. Copy to any computer with R installed
4. Run `run_app.bat` or `run_app.R`

**For maximum portability: Use Method 2**
- No R installation needed on target computer
- Completely self-contained
- Just extract and run

---

## File Size Estimates

- App only: < 1 MB
- App + packages: ~50-100 MB
- App + packages + R Portable: ~500 MB

---

## Testing the Standalone Package

1. Copy the standalone folder to a different location
2. Delete the original R library (to simulate a new computer)
3. Run the app - it should work using only the bundled packages

---

## Troubleshooting

### "Cannot find R"
- Make sure R is installed (Method 1 & 3)
- Or use R Portable (Method 2)

### "Package not found"
- Check that the `library` folder contains all packages
- Re-run the setup script

### "Permission denied"
- Run as administrator
- Or extract to a user folder (not Program Files)

---

## Updating the App

To update the app on multiple computers:
1. Update `app.R` in your development environment
2. Copy the new `app.R` to the standalone package
3. Redistribute the updated folder
4. No need to reinstall packages unless you added new dependencies
