# Salt Dilution Discharge Calculator

A Shiny web application for calculating stream discharge using the salt dilution method.

## Installation

### Prerequisites

You need R installed on your system. Then install the required packages:

```r
install.packages(c("shiny", "DT", "ggplot2", "dplyr"))
```

## Running the App

### Option 1: From R/RStudio

```r
library(shiny)
runApp("c:/Users/deluigi/Desktop/calcualtorq")
```

Or if you're in the directory:

```r
library(shiny)
runApp()
```

### Option 2: From Command Line

```bash
R -e "shiny::runApp('c:/Users/deluigi/Desktop/calcualtorq')"
```

## How to Use

### 1. Calibration Parameters
- Enter the **Calibration Value** (default: 1915.89616)
- The app calculates: `b = 1 / calibration value`
- Units: `b` is in (g/L)/(µS/cm)

### 2. Measurement Parameters
- **Point Description**: Name/description of your measurement location
- **Mass of Salt Added**: Amount of salt injected in grams
- **Background Conductivity**: Baseline conductivity before salt injection (µS/cm)
- **Time Step**: Interval between conductivity measurements in seconds

### 3. Conductivity Data
Paste your conductivity measurements in the text area. The app accepts:
- One value per line
- Comma-separated values
- Space-separated values
- Tab-separated values

Example:
```
359
359
359.4
361.6
375.2
419.2
```

### 4. Calculate
Click the **"Calculate Discharge"** button to compute the discharge.

### 5. View Results
- **Results Tab**: Shows the calculated discharge in L/s, L/min, and m³/s
- **Data Table Tab**: Shows the complete time series with calculated concentrations
- **Plot Tab**: Visualizes conductivity and concentration over time
- **Method Tab**: Explains the calculation methodology

### 6. Download Report
Click **"Download Report (CSV)"** to save your results and data.

## Methodology

The app uses the **salt dilution method** to calculate discharge:

### Formula

```
Q = M / ((SUM(conductivity) - background × COUNT(conductivity)) × b × dt)
```

Where:
- **Q** = Discharge [L/s]
- **M** = Mass of salt injected [g]
- **SUM(conductivity)** = Sum of all conductivity measurements [µS/cm]
- **background** = Background conductivity [µS/cm]
- **COUNT(conductivity)** = Number of measurements
- **b** = Calibration coefficient [(g/L)/(µS/cm)]
- **dt** = Time step between measurements [s]

### Calculation Steps

1. **Total excess conductivity** = SUM(conductivity) - background × COUNT(conductivity)
2. **Integral of excess concentration** = Total excess conductivity × b × dt [g·s/L]
3. **Discharge** = Mass of salt / Integral [L/s]

## Example Data

The app comes pre-loaded with example data from a field measurement:
- Mass of salt: 3500 g
- Background conductivity: 359 µS/cm
- Time step: 10 s
- Expected discharge: ~468.84 L/s

## Files in This Directory

- `app.R` - Main Shiny application
- `Q_measurement_salt_inj.xlsx` - Original Excel file with measurements
- `with_salt_data.csv` - Extracted salt measurement data
- `with_rhodamine_data.csv` - Extracted rhodamine measurement data
- `README.md` - This file
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

## Contact

For questions or issues, please refer to the original Excel file methodology or consult with your field measurement team.
