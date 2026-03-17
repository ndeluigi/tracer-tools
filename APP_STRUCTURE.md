# App Structure - Discharge Calculator

## Overview

The app now has a **tabbed sidebar** with 4 main sections for different calculation methods and settings.

## Sidebar Tabs (Left Column)

### 1. **Q_salt** - Salt Dilution Discharge
Calculate discharge using salt slug tracer test.

**Inputs:**
- Mass of Salt Added (g)
- Background Conductivity (µS/cm)
- Time Step for Logging (s)
- Conductivity Timeseries data (paste values)

**Action:**
- Button: "Calculate Q from Salt"

**Purpose:**
- Primary method for discharge calculation
- Uses conductivity breakthrough curve
- Provides Q for tracer mass calculations

---

### 2. **Q_rhoWT** - Rhodamine WT Discharge
Calculate discharge using Rhodamine WT fluorescent tracer.

**Inputs:**
- Mass of Rhodamine WT Injected (g)
- Background Fluorescence (RFU or ppb)
- Time Step for Logging (s)
- Water Temperature (°C)
- Fluorescence Timeseries data (paste values)

**Action:**
- Button: "Calculate Q from Rhodamine"

**Purpose:**
- Alternative discharge calculation method
- Uses fluorescence breakthrough curve
- Temperature-corrected calculations

**Status:** Framework ready (calculation logic to be implemented)

---

### 3. **Injections** - Tracer Mass Calculator
Calculate required masses for arabinose, glucose, and rhodamine WT based on salt slug test results.

**Inputs:**
- Water Temperature (°C)
- Target Arabinose Increase (ppb)
- Target Glucose Increase (ppb)
- Target Rhodamine WT Increase (ppb)

**Workflow:**
1. First calculate Q using the **Q_salt** tab
2. Switch to **Injections** tab
3. View calculated tracer masses based on:
   - Discharge (Q) from salt test
   - Effective width (W_eff) from breakthrough curve
   - Target concentrations
   - Temperature correction (for rhodamine)

**Purpose:**
- Plan follow-up tracer experiments
- Determine exact masses to inject
- Ensure target concentrations are achieved

---

### 4. **Settings** - Global Configuration
Configure parameters used across all calculations.

**Calibration Parameters:**
- Calibration Value (1/b)
- Used for conductivity → concentration conversion

**Rhodamine WT Parameters:**
- Solution Concentration (%)
- Temperature Coefficient (°C⁻¹)
- Controls rhodamine mass calculations and temperature corrections

**Sampling Strategy:**
- Samples During Breakthrough Curve (default: 13)
- Calculates optimal sampling times
- Shows red bars on plots

**Purpose:**
- Set global parameters once
- Used by all calculation methods
- Configure sampling recommendations

---

## Main Panel Tabs (Right Side)

### 1. **Results**
Displays calculation results:
- **Discharge calculation results**: Q in L/s and L/min
- **Tracer mass requirements**: Arabinose, Glucose, Rhodamine WT
- **Calculation details**: Step-by-step breakdown

### 2. **Data Table**
Shows the full conductivity/concentration timeseries in table format.

### 3. **Plot**
Visual representation:
- **Conductivity vs time**: Shows breakthrough curve
- **Concentration vs time**: Shows excess concentration
- **Red vertical bars**: Recommended sampling times

### 4. **Sampling**
Sampling frequency calculator output:
- Breakthrough curve duration
- Sampling interval
- Exact timing for each sample
- Configure in Settings tab

### 5. **Method**
Explanation of the salt dilution method:
- Formula
- Parameters
- Physical interpretation

---

## Typical Workflows

### Workflow 1: Salt Slug Test → Tracer Planning

1. **Q_salt tab**: 
   - Enter salt mass and background conductivity
   - Paste conductivity data
   - Click "Calculate Q from Salt"

2. **Results tab**:
   - View discharge (Q)
   - Note the calculated values

3. **Injections tab**:
   - Enter target concentrations for tracers
   - View required masses for arabinose, glucose, rhodamine

4. **Sampling tab**:
   - Check recommended sampling times
   - Plan field sampling strategy

5. **Download**:
   - Click "Download Report (CSV)" for all results

### Workflow 2: Rhodamine WT Test

1. **Settings tab**:
   - Configure rhodamine parameters
   - Set temperature coefficient

2. **Q_rhoWT tab**:
   - Enter rhodamine mass injected
   - Paste fluorescence data
   - Set water temperature
   - Click "Calculate Q from Rhodamine"

3. **Results tab**:
   - View discharge from rhodamine test
   - Compare with salt-based Q if available

### Workflow 3: Sampling Planning

1. **Q_salt tab**:
   - Run salt slug calculation

2. **Settings tab**:
   - Adjust "Samples During Breakthrough Curve"
   - Try different values (e.g., 10, 13, 20)

3. **Plot tab**:
   - View red bars showing sampling times
   - Ensure peak is captured

4. **Sampling tab**:
   - Note exact sampling times
   - Print or save for field use

---

## Key Features

### ✅ Tabbed Sidebar
- Clean organization
- Easy navigation
- Context-specific inputs

### ✅ Multiple Calculation Methods
- Salt dilution (primary)
- Rhodamine WT (alternative)
- Tracer mass planning

### ✅ Integrated Settings
- Global parameters
- Consistent across methods
- Easy to configure

### ✅ Visual Feedback
- Real-time plots
- Sampling time indicators
- Interactive updates

### ✅ Comprehensive Output
- Detailed results
- Data tables
- Downloadable reports

---

## Navigation Tips

1. **Start with Q_salt** for most applications
2. **Use Settings** to configure parameters before calculations
3. **Switch to Injections** after calculating Q to plan tracers
4. **Check Sampling tab** to optimize field sampling
5. **Download results** before closing the app

---

## Comparison: Old vs New Structure

| Feature | Old Structure | New Structure |
|---------|--------------|---------------|
| **Settings location** | Main panel tab | Sidebar tab |
| **Calculation methods** | 1 (salt only) | 2 (salt + rhodamine) |
| **Navigation** | Vertical scrolling | Tabbed sidebar |
| **Workflow** | Linear | Flexible |
| **Input organization** | Mixed | Method-specific |

---

## Future Enhancements

Potential additions:
- **Q_rhoWT calculation logic** (currently framework only)
- **Comparison tab** (compare Q from different methods)
- **Export to field sheet** (printable sampling schedule)
- **Data import** (read from CSV/Excel directly)
- **Multi-tracer analysis** (combined breakthrough curves)

---

## Summary

The new structure provides:
- ✅ **Clearer workflow** - Separate tabs for different tasks
- ✅ **Better organization** - Settings in one place
- ✅ **More flexibility** - Multiple calculation methods
- ✅ **Easier navigation** - Tabbed interface
- ✅ **Scalability** - Easy to add new methods

The app is now organized around **what you want to do** (calculate Q, plan injections, configure settings) rather than **what type of output** you want to see.
