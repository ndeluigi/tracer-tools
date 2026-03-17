# Discharge Calculation Method - Salt Dilution Technique

## Overview

The salt dilution method is a tracer technique used to measure stream discharge (flow rate). It involves injecting a known mass of salt into the stream and measuring the resulting change in electrical conductivity downstream.

## Theory

When a known mass of tracer (salt) is injected into a stream, it dilutes as it travels downstream. The degree of dilution is inversely proportional to the discharge. By measuring the concentration of the tracer over time at a downstream location, we can calculate the discharge.

## Formula

The discharge **Q** is calculated using:

```
Q = M / ∫C(t)dt
```

Where:
- **Q** = Discharge [L/s]
- **M** = Mass of tracer (salt) injected [g]
- **∫C(t)dt** = Integral of excess concentration over time [g·s/L]

## Implementation in Excel/App

The Excel formula and Shiny app use a discrete approximation:

```
Q = M / ((SUM(conductivity) - background × COUNT(conductivity)) × b × dt)
```

### Parameters

| Parameter | Symbol | Units | Description |
|-----------|--------|-------|-------------|
| Discharge | Q | L/s | Stream flow rate to be calculated |
| Mass of salt | M | g | Known mass of salt injected |
| Conductivity readings | spCOND | µS/cm | Time series of conductivity measurements |
| Background conductivity | background | µS/cm | Baseline conductivity before injection |
| Calibration coefficient | b | (g/L)/(µS/cm) | Converts conductivity to concentration |
| Time step | dt | s | Time interval between measurements |

### Step-by-Step Calculation

#### Step 1: Calculate Total Excess Conductivity

```
Total Excess = SUM(conductivity) - background × COUNT(conductivity)
```

This represents the cumulative excess conductivity above background across all measurements.

**Example:**
- SUM(conductivity) = 17,944.25 µS/cm
- background = 359 µS/cm
- COUNT = 46 measurements
- background × COUNT = 359 × 46 = 16,514 µS/cm
- **Total Excess = 17,944.25 - 16,514 = 1,430.25 µS/cm**

#### Step 2: Calculate Integral of Excess Concentration

```
Integral = Total Excess × b × dt
```

This converts the excess conductivity to an integral of concentration over time.

**Example:**
- Total Excess = 1,430.25 µS/cm
- b = 1/1915.89616 = 0.0005219490 (g/L)/(µS/cm)
- dt = 10 s
- **Integral = 1,430.25 × 0.0005219490 × 10 = 7.465 g·s/L**

#### Step 3: Calculate Discharge

```
Q = M / Integral
```

**Example:**
- M = 3,500 g
- Integral = 7.465 g·s/L
- **Q = 3,500 / 7.465 = 468.84 L/s**

## Calibration Coefficient

The calibration coefficient **b** relates electrical conductivity to salt concentration:

```
Concentration [g/L] = a + b × Conductivity [µS/cm]
```

In the Excel file:
- **b = 1 / 1915.89616 = 0.0005219490** (g/L)/(µS/cm)
- **a = -24.25398 × b = -0.01266** g/L

The coefficient **a** represents the y-intercept (concentration at zero conductivity) and is typically close to zero or slightly negative. For the discharge calculation, we only need **b** because we're working with **excess** conductivity (conductivity minus background), which eliminates the constant term.

## Physical Interpretation

### Why This Works

1. **Conservation of Mass**: The total mass of salt passing through any cross-section equals the injected mass
   ```
   M = Q × ∫C(t)dt
   ```

2. **Conductivity as a Proxy**: Electrical conductivity is directly proportional to salt concentration, allowing us to use conductivity measurements instead of chemical analysis

3. **Background Subtraction**: By subtracting background conductivity, we isolate the signal from the injected salt

4. **Discrete Integration**: Multiplying by the time step (dt) converts the sum into an approximation of the integral

### Assumptions

1. **Complete mixing**: Salt is fully mixed across the stream cross-section at the measurement point
2. **Conservative tracer**: Salt doesn't react, precipitate, or sorb during transport
3. **Steady flow**: Discharge remains constant during the measurement period
4. **Linear calibration**: Conductivity-concentration relationship is linear in the measured range

## Example Calculation

### Given Data
- Mass of salt injected: 3,500 g
- Background conductivity: 359 µS/cm
- Time step: 10 seconds
- Number of measurements: 46
- Calibration: b = 0.0005219490 (g/L)/(µS/cm)

### Conductivity Time Series (excerpt)
```
Time (s)    Conductivity (µS/cm)    Excess (µS/cm)
0           359.0                   0.0
10          359.0                   0.0
20          359.0                   0.0
...
170         359.4                   0.4
180         359.6                   0.6
190         361.6                   2.6
200         375.2                   16.2
210         419.2                   60.2
220         487.4                   128.4
230         530.0                   171.0
240         559.4                   200.4
...
```

### Calculation
1. Sum of all conductivity readings: 17,944.25 µS/cm
2. Background × Count: 359 × 46 = 16,514.00 µS/cm
3. Total excess: 1,430.25 µS/cm
4. Integral: 1,430.25 × 0.0005219490 × 10 = 7.465 g·s/L
5. **Discharge: 3,500 / 7.465 = 468.84 L/s**

### Unit Conversions
- **468.84 L/s** = 28,130 L/min = 0.469 m³/s

## Quality Control

### Checks to Perform

1. **Peak Detection**: Verify that conductivity shows a clear peak above background
2. **Return to Background**: Conductivity should return close to background levels after the peak
3. **Reasonable Discharge**: Compare with expected flow rates for the stream
4. **Mass Balance**: If possible, verify with other flow measurement methods

### Common Issues

| Issue | Possible Cause | Solution |
|-------|---------------|----------|
| No peak observed | Insufficient mixing, measurement too close to injection | Move measurement point downstream |
| Peak doesn't return to background | Measurement period too short | Extend measurement duration |
| Multiple peaks | Incomplete mixing, dead zones | Improve injection technique, measure further downstream |
| Unrealistic discharge | Wrong calibration, incorrect salt mass | Verify calibration and salt mass |

## References

This method is based on standard hydrological tracer techniques. For more information, see:

- Moore, R.D. (2005). "Slug injection using salt in solution." Streamline Watershed Management Bulletin, 8(2), 1-6.
- Day, T.J. (1977). "Observed mixing lengths in mountain streams." Journal of Hydrology, 35(1-2), 125-136.

## Advantages and Limitations

### Advantages
- Simple and inexpensive
- Works in streams where velocity-area methods are difficult
- No permanent installations required
- Good for small to medium streams

### Limitations
- Requires complete mixing (may need long reach)
- Time-consuming for large streams
- Assumes steady flow during measurement
- Requires calibration of conductivity-concentration relationship
