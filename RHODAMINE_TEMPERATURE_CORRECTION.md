# Rhodamine WT Temperature Correction

## Overview

Rhodamine WT fluorescence is temperature-dependent, decreasing by approximately 2-3% per °C. The app now includes automatic temperature correction to ensure accurate tracer mass calculations.

## The Problem

When water temperature differs from the reference temperature (25°C):
- **Warmer water (>25°C)**: Fluorescence decreases → measured signal is lower than true concentration
- **Cooler water (<25°C)**: Fluorescence increases → measured signal is higher than true concentration

Without correction, you would inject the wrong amount of rhodamine to achieve your target concentration.

## The Solution

The app applies the standard temperature correction formula:

```
C₂₅ = Cₜ × exp(n × (T - T_ref))
```

Where:
- **C₂₅** = Concentration at reference temperature (25°C)
- **Cₜ** = Concentration at measured temperature T
- **n** = Temperature coefficient (typically 0.023 - 0.030 °C⁻¹, default 0.026)
- **T** = Water temperature (°C)
- **T_ref** = Reference temperature (25°C)

## How It Works in the App

### Input Fields

1. **Water Temperature (°C)** - Default: 25°C
   - Enter the actual water temperature where you'll inject the tracer
   - Range: 0-40°C

2. **Rhodamine Temperature Coefficient (°C⁻¹)** - Default: 0.026
   - Empirical coefficient from literature
   - Typical range: 0.020 - 0.030
   - Can be adjusted based on your specific rhodamine formulation

### Calculation

The app automatically:
1. Calculates the base mass needed: `M_base = Q × C_target × W_eff`
2. Applies temperature correction: `M_corrected = M_base × exp(n × (T - 25))`
3. Accounts for solution concentration: `M_solution = M_corrected / (concentration%/100)`

### Example Calculations

#### Example 1: Warm Water (30°C)
```
Target: 100 ppb at 25°C reference
Temperature: 30°C
Coefficient: 0.026 °C⁻¹

Correction factor = exp(0.026 × (30 - 25)) = exp(0.13) = 1.139

You need to inject 13.9% MORE rhodamine because:
- At 30°C, fluorescence is lower
- To achieve the same signal as 100 ppb at 25°C
- You must inject more tracer
```

#### Example 2: Cool Water (15°C)
```
Target: 100 ppb at 25°C reference
Temperature: 15°C
Coefficient: 0.026 °C⁻¹

Correction factor = exp(0.026 × (15 - 25)) = exp(-0.26) = 0.771

You need to inject 22.9% LESS rhodamine because:
- At 15°C, fluorescence is higher
- To achieve the same signal as 100 ppb at 25°C
- You must inject less tracer
```

#### Example 3: Reference Temperature (25°C)
```
Target: 100 ppb at 25°C reference
Temperature: 25°C

Correction factor = exp(0.026 × (25 - 25)) = exp(0) = 1.000

No correction needed - inject the base calculated mass
```

## Output Display

The app shows:

```
RHODAMINE WT (Target: 100 ppb at 25°C reference):
  Water temperature       : 30.0 °C
  Temperature coefficient : 0.026 °C⁻¹
  Correction factor       : 1.1388 (warmer → inject more)
  Solution concentration  : 23.83%
  Pure rhodamine needed   = 0.3810 g
  → SOLUTION to add       = 1.5990 g
```

## Physical Interpretation

### Why Temperature Matters

Rhodamine WT fluorescence is caused by electronic transitions in the molecule. Higher temperatures:
1. Increase molecular collisions
2. Promote non-radiative energy dissipation
3. Reduce fluorescence quantum yield
4. Result in lower measured signal

### The Exponential Relationship

The exponential form `exp(n × ΔT)` ensures:
- Smooth, continuous correction
- Multiplicative scaling (appropriate for fluorescence)
- Symmetry around reference temperature
- Consistency with physical principles

### Typical Coefficient Values

| Source | Coefficient (°C⁻¹) | % Change per °C |
|--------|-------------------|-----------------|
| Wilson et al. (1986) | 0.027 | 2.7% |
| Smart & Laidlaw (1977) | 0.025 | 2.5% |
| Turner Designs | 0.026 | 2.6% |
| **App default** | **0.026** | **2.6%** |

## Best Practices

### 1. Measure Water Temperature Accurately
- Use a calibrated thermometer
- Measure at the injection point
- If temperature varies, use the average expected temperature

### 2. Use Appropriate Coefficient
- Default (0.026) works for most applications
- Adjust if you have calibration data for your specific conditions
- Stay within typical range (0.020 - 0.030)

### 3. Consider Temperature Stability
- If temperature changes significantly during the experiment:
  - Use the average temperature
  - Or perform multiple injections at different times
- Large temperature gradients may affect results

### 4. Document Everything
- Record water temperature at time of injection
- Note the coefficient used
- Include in your data report (automatically in CSV download)

## Verification

To verify the correction is working:

1. **At 25°C**: Correction factor should be exactly 1.000
2. **At 30°C (n=0.026)**: Correction factor ≈ 1.139 (13.9% more)
3. **At 20°C (n=0.026)**: Correction factor ≈ 0.877 (12.3% less)

## CSV Export

The downloaded CSV includes:
- Water Temperature (°C)
- Rhodamine Temperature Coefficient (°C⁻¹)
- Temperature Correction Factor
- Required Pure Rhodamine Mass (g) - temperature corrected
- Required Rhodamine SOLUTION Mass (g) - temperature corrected

## References

1. Wilson, J.F., et al. (1986). "Fluorometric procedures for dye tracing." USGS Techniques of Water-Resources Investigations.

2. Smart, P.L., & Laidlaw, I.M.S. (1977). "An evaluation of some fluorescent dyes for water tracing." Water Resources Research, 13(1), 15-33.

3. Turner Designs. "Rhodamine WT Dye Study." Technical Note S-0149.

## Important Notes

- ✅ Correction is applied automatically when you calculate discharge
- ✅ All displayed rhodamine masses are temperature-corrected
- ✅ Target concentration is always referenced to 25°C
- ✅ Arabinose and glucose are NOT temperature-corrected (not fluorescent tracers)
- ⚠️ Correction assumes linear temperature throughout the reach
- ⚠️ For large temperature variations, consider multiple measurements

## Summary

The temperature correction ensures that:
1. Your target concentration (e.g., 100 ppb) is achieved at the standard 25°C reference
2. Measurements at different temperatures are comparable
3. Discharge calculations are accurate regardless of water temperature
4. Results are consistent with published hydrological methods
