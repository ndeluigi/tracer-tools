# Workflow Summary - Updated Structure

## Key Changes

### Q_salt Tab - Discharge Only
- **Purpose**: Calculate discharge from salt slug test
- **Calculates**: Q (L/s, L/min)
- **Does NOT calculate**: Tracer masses, sampling times
- **Output**: Discharge results only

### Q_rhoWT Tab - Discharge Only  
- **Purpose**: Calculate discharge from Rhodamine WT test
- **Calculates**: Q (L/s, L/min)
- **Does NOT calculate**: Tracer masses for arabinose/glucose
- **Output**: Discharge results only

### Injections Tab - Tracer Planning
- **Purpose**: Calculate required masses for arabinose, glucose, and rhodamine WT
- **Requires**: Q must be calculated first (using Q_salt)
- **Button**: "Calculate Tracer Masses"
- **Calculates**: 
  - Arabinose mass
  - Glucose mass
  - Rhodamine WT mass (with temperature correction)
  - Sampling times for breakthrough curve
- **Output**: Tracer mass requirements + sampling strategy

## Workflows

### Workflow 1: Just Calculate Discharge

1. **Q_salt tab**:
   - Enter salt mass, background conductivity, time step
   - Paste conductivity data
   - Click "Calculate Q from Salt"

2. **Results tab**:
   - View discharge (Q)
   - No tracer masses shown

3. **Plot tab**:
   - View conductivity and concentration curves
   - No red sampling bars (not calculated)

### Workflow 2: Calculate Discharge + Plan Tracer Injections

1. **Q_salt tab**:
   - Enter salt mass, background conductivity, time step
   - Paste conductivity data
   - Click "Calculate Q from Salt"

2. **Injections tab**:
   - Enter water temperature
   - Enter target concentrations (arabinose, glucose, rhodamine)
   - Click "Calculate Tracer Masses"

3. **Results tab**:
   - View discharge (Q)
   - View tracer mass requirements
   - View effective width calculations

4. **Plot tab**:
   - View conductivity and concentration curves
   - **Red bars show sampling times** (calculated from Injections)

5. **Sampling tab**:
   - View detailed sampling strategy
   - See exact times for each sample

## What Shows When

### After Q_salt Calculation:
- ✅ Discharge results
- ✅ Plots (no sampling bars)
- ✅ Data table
- ❌ Tracer masses (not calculated)
- ❌ Sampling times (not calculated)

### After Injections Calculation:
- ✅ Discharge results
- ✅ Tracer mass requirements
- ✅ Plots **with red sampling bars**
- ✅ Sampling frequency calculator
- ✅ Data table

## Settings Tab

Global parameters used by all calculations:
- **Calibration parameters**: For conductivity → concentration
- **Rhodamine WT parameters**: Solution concentration, temperature coefficient
- **Sampling strategy**: Number of samples during breakthrough

## Summary

- **Q_salt** and **Q_rhoWT** = Discharge calculation only
- **Injections** = Tracer planning (requires Q first)
- **Sampling** = Only calculated when using Injections workflow
- **Plots** = Show sampling bars only when Injections has been calculated
