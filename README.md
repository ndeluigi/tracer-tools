# Tracer Tool - Stream Discharge & Tracer Mass Calculator

A comprehensive Shiny web application for calculating stream discharge using salt dilution or Rhodamine WT methods, and for determining optimal tracer masses for stream metabolism studies.

## Description

This tool provides three integrated workflows for stream hydrological measurements:

1. **Q_salt**: Calculate discharge from salt slug injection using conductivity measurements
2. **Q_rhoWT**: Calculate discharge from Rhodamine WT injection using fluorescence measurements  
3. **Injections**: Calculate required masses of arabinose, glucose, and Rhodamine WT tracers based on salt slug test results and target concentrations

The tool includes temperature correction for Rhodamine WT, effective width calculations, and sampling strategy recommendations for breakthrough curve analysis.

## Installation

### Prerequisites

You need R installed on your system. Download from [CRAN](https://cran.r-project.org/).

Then install the required packages:

```r
install.packages(c("shiny", "DT", "ggplot2", "dplyr"))
```

## Running the App

### Option 1: From R/RStudio

```r
library(shiny)
runApp()
```

### Option 2: Using the run script

```r
source("run_app.R")
```

### Option 3: From Command Line

```bash
Rscript run_app.R
```

## Features

- **Multiple discharge calculation methods**: Salt dilution and Rhodamine WT fluorescence
- **Tracer mass calculator**: Determine optimal masses for arabinose, glucose, and Rhodamine WT
- **Temperature correction**: Automatic Rhodamine WT fluorescence correction (2-3% per °C)
- **Effective width calculation**: Based on breakthrough curve analysis
- **Sampling strategy**: Recommended sampling times for breakthrough curves
- **Interactive visualizations**: Real-time plots of conductivity/fluorescence and concentration
- **Data export**: Download results and complete time series as CSV
- **Comprehensive documentation**: Built-in methodology explanations

## How to Use

### Workflow 1: Q_salt (Salt Dilution Discharge)

1. Navigate to the **Q_salt** tab in the sidebar
2. Enter your **Mass of Salt Added** (g)
3. Enter **Background Conductivity** (µS/cm)
4. Set the **Time Step** for your measurements (s)
5. Paste your **Conductivity Timeseries** data (one value per line, or comma/space separated)
6. Click **"Calculate Q from Salt"**
7. View results in the main panel tabs (Results, Data Table, Plot, Method)

### Workflow 2: Q_rhoWT (Rhodamine WT Discharge)

1. Navigate to the **Q_rhoWT** tab in the sidebar
2. Enter **Mass of Rhodamine WT Injected** (g)
3. Enter **Background Fluorescence** (RFU or ppb)
4. Set the **Time Step** (s) and **Water Temperature** (°C)
5. Paste your **Fluorescence Timeseries** data
6. Click **"Calculate Q from Rhodamine"**
7. Results include automatic temperature correction

### Workflow 3: Injections (Tracer Mass Calculator)

1. Navigate to the **Injections** tab in the sidebar
2. Enter your salt slug test parameters:
   - Mass of Salt Added (g)
   - Background Conductivity (µS/cm)
   - Time Step (s)
   - Water Temperature (°C)
3. Set your **Target Tracer Concentrations** (ppb):
   - Target Arabinose Increase
   - Target Glucose Increase
   - Target Rhodamine WT Increase
4. Paste your **Conductivity Timeseries** from the salt slug test
5. Click **"Calculate Tracer Masses"**
6. View required masses for each tracer, accounting for effective width and temperature

### Settings Tab

Configure global parameters:
- **Calibration Value** (1/b): Default 1915.89616, where b = (g/L)/(µS/cm)
- **Rhodamine WT Solution Concentration** (%): Default 23.83%
- **Rhodamine Temperature Coefficient** (°C⁻¹): Default 0.026
- **Sampling Strategy**: Number of samples during breakthrough curve

### Download Report
Click **"Download Report (CSV)"** at any time to save your results and complete time series data.

## Methodology

### Salt Dilution Method

Calculate discharge from a known mass of salt injected into the stream:

**Formula:**
```
Q = M / ((SUM(conductivity) - background × COUNT(conductivity)) × b × dt)
```

**Where:**
- **Q** = Discharge [L/s]
- **M** = Mass of salt injected [g]
- **SUM(conductivity)** = Sum of all conductivity measurements [µS/cm]
- **background** = Background conductivity [µS/cm]
- **COUNT(conductivity)** = Number of measurements
- **b** = Calibration coefficient [(g/L)/(µS/cm)]
- **dt** = Time step between measurements [s]

### Rhodamine WT Method

Calculate discharge from a known mass of Rhodamine WT with temperature correction:

**Formula:**
```
Q = M / ((SUM(fluorescence) - background × COUNT(fluorescence)) × dt)
```

**Temperature Correction:**
- Fluorescence decreases ~2-3% per °C above 25°C
- Correction factor: `exp(n × (T - 25°C))` where n = 0.026 °C⁻¹
- All calculations referenced to 25°C

### Tracer Mass Calculation

Calculate required tracer masses based on effective width:

**Formula:**
```
M = Q × C_target × W_eff
```

**Where:**
- **M** = Required tracer mass [µg]
- **Q** = Discharge from salt slug test [L/s]
- **C_target** = Target concentration increase [ppb = µg/L]
- **W_eff** = Effective width [s] = Area under curve / Peak excess

## Files in This Repository

### Core Application
- `app.R` - Main Shiny application with all three workflows
- `run_app.R` - Convenience script to launch the app

### Documentation
- `README.md` - This file
- `INSTALLATION_GUIDE.md` - Detailed installation instructions
- `APP_STRUCTURE.md` - Application architecture documentation
- `DISCHARGE_CALCULATION_EXPLAINED.md` - Detailed calculation methodology
- `TRACER_MASS_CALCULATION.md` - Tracer mass calculation details
- `RHODAMINE_TEMPERATURE_CORRECTION.md` - Temperature correction methodology
- `SAMPLING_STRATEGY.md` - Sampling frequency recommendations
- `WORKFLOW_SUMMARY.md` - Overview of all workflows
- `STANDALONE_INSTRUCTIONS.md` - Instructions for creating standalone version

### Data Files
- `Q_measurement_salt_inj.xlsx` - Example Excel file with measurements
- `with_salt_data.csv` - Example salt measurement data
- `with_rhodamine_data.csv` - Example rhodamine measurement data

### Utilities
- `create_standalone.R` - Script to create standalone executable
- `make_portable.R` - Script to create portable version
- Various Python scripts for data analysis and verification

## Troubleshooting

### App won't start
- Make sure all required packages are installed
- Check that you're running the command from the correct directory

### "Invalid conductivity data" error
- Ensure your data contains only numeric values
- Check for any non-numeric characters in your paste
- Make sure values are separated by newlines, commas, or spaces

### Discharge seems incorrect
- Verify the calibration coefficient
- Check that background conductivity is correct
- Ensure time step matches your data collection interval
- Confirm mass of salt is in grams

### Q value not updating in Injections tab
- This was a known issue that has been fixed
- Make sure you're using the latest version of app.R
- The Q value now updates correctly when changing salt mass

## Use Cases

This tool is designed for:
- **Stream metabolism studies**: Calculate optimal tracer masses for arabinose and glucose injections
- **Discharge measurements**: Quick and accurate stream discharge calculations
- **Hydrological surveys**: Multiple measurement methods in one tool
- **Field work planning**: Determine tracer requirements before field deployment
- **Data analysis**: Process and visualize breakthrough curves

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is open source and available for research and educational purposes.

## Citation

If you use this tool in your research, please cite it appropriately and reference the underlying methodologies for salt dilution and Rhodamine WT discharge measurements.

## Contact

For questions, issues, or suggestions, please open an issue on GitHub.
