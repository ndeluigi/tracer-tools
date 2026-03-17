# Tracer Mass Calculation - Implementation Guide

## Overview

The R Shiny app now calculates the required mass of arabinose and glucose tracers based on the salt slug breakthrough curve, using the **effective width method**.

## Method

### Step 1: Salt Slug Test
Perform a salt dilution test to:
1. Calculate discharge (Q)
2. Characterize the breakthrough curve shape

### Step 2: Calculate Effective Width

The **effective width (W_eff)** represents the actual spreading of the slug and is calculated as:

```
W_eff = A / ΔS_peak
```

Where:
- **A** = Area under the excess conductivity curve [µS·s/cm]
  - `A = SUM(excess_conductivity) × dt`
- **ΔS_peak** = Peak excess conductivity above background [µS/cm]
  - `ΔS_peak = MAX(conductivity - background)`
- **W_eff** = Effective width [seconds]

### Step 3: Calculate Required Tracer Mass

For each tracer (arabinose and glucose), the required mass is:

```
M = Q × C_target × W_eff
```

Where:
- **M** = Required mass [µg, then converted to mg and g]
- **Q** = Discharge [L/s]
- **C_target** = Target peak concentration [µg/L = ppb]
- **W_eff** = Effective width [s]

**Unit check:**
```
L/s × µg/L × s = µg ✓
```

## Why This Works

1. **Shape Independence**: The ratio A/ΔS_peak is a time scale that captures the curve shape, independent of calibration factors (they cancel out)

2. **Linear Scaling**: For conservative tracers, concentration scales linearly with injected mass under the same hydraulic conditions

3. **Same Hydraulics**: If you inject arabinose/glucose using the same method and location as the salt slug, the breakthrough curve shape will be similar

## Example Calculation

Using the default data in the app:

### Salt Slug Results
- Discharge Q = 468.84 L/s
- Area under curve = 1,430.25 µS·s/cm
- Peak excess conductivity = 200.4 µS/cm
- **W_eff = 1,430.25 / 200.4 = 7.14 seconds**

### Arabinose (Target: 100 ppb)
```
M = 468.84 L/s × 100 µg/L × 7.14 s
M = 334,752 µg = 334.75 mg = 0.335 g
```

### Glucose (Target: 100 ppb)
```
M = 468.84 L/s × 100 µg/L × 7.14 s
M = 334,752 µg = 334.75 mg = 0.335 g
```

## App Features

### New Input Fields
1. **Target Arabinose Increase (ppb)** - Default: 100 ppb
2. **Target Glucose Increase (ppb)** - Default: 100 ppb

### New Output Section
**Tracer Mass Requirements** displays:
- Effective width calculation details
- Required mass for arabinose (in g, mg, and µg)
- Required mass for glucose (in g, mg, and µg)
- Important notes about assumptions

### Removed
- **Point Description** field (removed as requested)

## Important Assumptions

1. **Same injection method**: Use the same dumping technique as the salt slug
2. **Same location**: Inject at the same point as the salt slug
3. **Similar hydraulics**: Stream conditions (flow, mixing) should be similar
4. **Conservative tracers**: Arabinose and glucose behave conservatively (no reaction, sorption, or degradation during transport)
5. **Complete mixing**: Tracers are fully mixed at the measurement point

## Practical Notes

### If You Want Both Tracers at 100 ppb Each
- Use the calculated mass for arabinose
- Use the calculated mass for glucose
- Mix them together and inject as one slug

### If You Want 100 ppb Total Combined
- Calculate mass using C_target = 100 ppb
- Split the mass between arabinose and glucose as desired (e.g., 50/50)

### Verification
After injection, the measured peak concentration should match your target if:
- Hydraulic conditions are similar
- Injection method is consistent
- Tracers behave conservatively

## References

This method is based on the principle that the breakthrough curve shape is determined by hydraulics, not tracer type. The effective width W_eff = A/ΔS_peak is a dimensionless time scale that characterizes the dispersion.

For more details on tracer dilution methods, see:
- Moore, R.D. (2005). "Slug injection using salt in solution."
- Standard hydrological tracer technique literature
