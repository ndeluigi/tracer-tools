# Sampling Strategy Calculator

## Overview

The app now includes an intelligent sampling strategy calculator that helps you plan how to collect water samples during a salt slug tracer test. This ensures you capture the full breakthrough curve with optimal temporal resolution.

## Location

The sampling calculator is in the **Settings** tab, under "Sampling strategy".

## How It Works

### Input Parameter

**Samples During Breakthrough Curve** (default: 13)
- Number of water samples to collect during the breakthrough curve
- Does NOT include background samples (before and after the slug)
- Minimum: 3 samples
- Maximum: 100 samples
- Typical range: 10-20 samples

### Calculation Method

The app automatically:

1. **Detects breakthrough start and end**
   - Identifies when conductivity rises above background (threshold: background + 0.5 µS/cm)
   - Finds the first and last points of elevated conductivity

2. **Calculates optimal sampling times**
   - Distributes samples evenly across the breakthrough duration
   - Ensures one sample captures the peak
   - Spreads remaining samples to represent the full curve shape

3. **Reports sampling frequency**
   - Time interval between samples (in seconds and minutes)
   - Exact timing for each sample
   - Total breakthrough duration

### Visual Indicators

**Red vertical bars** on both plots show recommended sampling times:
- **Conductivity vs time plot**: Shows when to collect samples relative to the conductivity curve
- **Concentration vs time plot**: Shows sampling times relative to the concentration curve

## Example Output

```
═══════════════════════════════════════════════════════════════
SAMPLING STRATEGY FOR BREAKTHROUGH CURVE
═══════════════════════════════════════════════════════════════

Breakthrough curve duration:
  Start at                  : 3.0 min (180 s)
  End at                    : 7.5 min (450 s)
  Total duration            : 4.5 min (270 s)

Sampling frequency:
  Number of samples         : 13
  Interval between samples  : 0.4 min (22 s)

Recommended sampling times (13 samples):
  Sample  1:    3.0 min (  180 s)
  Sample  2:    3.4 min (  203 s)
  Sample  3:    3.7 min (  225 s)
  Sample  4:    4.1 min (  248 s)
  Sample  5:    4.5 min (  270 s)
  Sample  6:    4.9 min (  293 s)
  Sample  7:    5.2 min (  315 s)  ← Peak likely here
  Sample  8:    5.6 min (  338 s)
  Sample  9:    6.0 min (  360 s)
  Sample 10:    6.4 min (  383 s)
  Sample 11:    6.7 min (  405 s)
  Sample 12:    7.1 min (  428 s)
  Sample 13:    7.5 min (  450 s)
```

## Practical Workflow

### Before the Field Experiment

1. **Run a preliminary test** (optional but recommended)
   - Do a quick salt slug with continuous logging
   - Import data into the app
   - Use the sampling calculator to plan your actual experiment

2. **Determine sample number**
   - More samples = better curve resolution
   - Fewer samples = faster analysis, lower cost
   - Typical: 10-15 samples for most streams

### During the Field Experiment

#### Phase 1: Background Sampling
- Collect 2-3 samples BEFORE injecting salt
- These establish baseline conditions
- Not included in the "13 samples" count

#### Phase 2: Breakthrough Sampling
- Start timer when you inject the salt
- Follow the sampling times from the calculator
- **Sample 1**: A few seconds after conductivity starts rising
  - Watch your logger/probe
  - When you see the first increase, start sampling
- **Middle samples**: Evenly spaced through the curve
  - One sample MUST capture the peak
  - Others represent rising and falling limbs
- **Last sample**: A few seconds before returning to background
  - Captures the tail of the curve

#### Phase 3: Post-Breakthrough Background
- Collect 2-3 samples AFTER conductivity returns to background
- Confirms return to baseline

### Example Timeline

For a 270-second breakthrough with 13 samples:

```
Time    Action
────────────────────────────────────────
-5 min  Background sample 1
-2 min  Background sample 2
 0 min  INJECT SALT SLUG
 3 min  Sample 1 (first rise)
 3.4    Sample 2
 3.7    Sample 3
 4.1    Sample 4
 4.5    Sample 5
 4.9    Sample 6
 5.2    Sample 7 (PEAK)
 5.6    Sample 8
 6.0    Sample 9
 6.4    Sample 10
 6.7    Sample 11
 7.1    Sample 12
 7.5    Sample 13 (tail end)
10 min  Background sample 3
12 min  Background sample 4
```

## Settings Tab Organization

The Settings tab now contains:

### 1. Calibration Parameters
- Calibration Value (1/b)
- Used for converting conductivity to concentration

### 2. Rhodamine WT Parameters
- Solution Concentration (%)
- Temperature Coefficient (°C⁻¹)
- Controls rhodamine mass calculations

### 3. Sampling Strategy
- **Samples During Breakthrough Curve**
- **Sampling Frequency Calculator** (output)
- Shows recommended sampling times

## Best Practices

### Sample Number Selection

| Stream Type | Recommended Samples | Rationale |
|-------------|-------------------|-----------|
| Small, fast | 8-10 | Short breakthrough, quick peak |
| Medium | 13-15 | Standard resolution |
| Large, slow | 15-20 | Long breakthrough, gradual peak |
| Research | 20-30 | Maximum detail for analysis |

### Timing Considerations

1. **Be flexible**
   - Calculator gives ideal times
   - Adjust based on actual breakthrough observation
   - Priority: capture the peak!

2. **Watch the logger**
   - If peak comes earlier/later than expected, adjust
   - Better to capture peak than stick to schedule

3. **Sample quickly**
   - Minimize time to fill bottle
   - Label immediately
   - Note exact time on bottle

4. **Account for travel time**
   - If sampling downstream from logger, account for lag
   - Water takes time to travel from injection to sampling point

## Integration with Discharge Calculation

The sampling times are calculated based on:
- Your actual conductivity data
- Time step between measurements
- Background conductivity level

This ensures the recommendations are specific to YOUR stream conditions.

## Visual Guide

### Plot Interpretation

**Red vertical bars** indicate:
- ✅ When to collect each sample
- ✅ Evenly distributed across breakthrough
- ✅ One bar should align with peak
- ✅ First bar: start of breakthrough
- ✅ Last bar: end of breakthrough

**Background line** (gray dashed):
- Shows baseline conductivity
- Samples should be collected when curve is ABOVE this line

## Adjusting Sample Number

You can change the number of samples and immediately see:
- Updated sampling interval
- New sampling times
- Updated red bars on plots

Try different values to find the best balance between:
- **More samples**: Better resolution, more work
- **Fewer samples**: Less work, risk missing peak

## Common Questions

### Q: What if I miss a sampling time?
**A:** Don't worry! The times are guidelines. If you miss one, continue with the next. It's more important to capture the peak than to hit exact times.

### Q: Should I sample at exactly these times?
**A:** These are optimal times based on your data. In the field, adjust based on what you observe. If the peak comes earlier, sample then!

### Q: How many background samples do I need?
**A:** Typically 2-3 before and 2-3 after. These are NOT included in the breakthrough sample count.

### Q: What if my breakthrough is shorter/longer than expected?
**A:** The calculator uses your actual data, so it should be accurate. But conditions can change. Always bring extra bottles!

### Q: Can I use this for other tracers?
**A:** Yes! The sampling strategy works for any tracer (salt, rhodamine, arabinose, glucose). The timing is based on the breakthrough curve shape, not the tracer type.

## Technical Notes

### Breakthrough Detection Algorithm

```r
# Threshold for detecting breakthrough
threshold <- background + 0.5  # µS/cm

# Find indices where conductivity exceeds threshold
excess_indices <- which(conductivity > threshold)

# Breakthrough start and end
start_idx <- min(excess_indices)
end_idx <- max(excess_indices)

# Calculate evenly spaced sampling times
sample_indices <- seq(start_idx, end_idx, length.out = n_samples)
sample_times <- (sample_indices - 1) × time_step
```

### Why 0.5 µS/cm Threshold?

- Small enough to detect early rise
- Large enough to avoid noise
- Works well for typical salt slugs (3-5 kg salt)
- Adjustable in code if needed for your conditions

## Summary

The sampling strategy calculator:
- ✅ Automatically detects breakthrough curve
- ✅ Calculates optimal sampling times
- ✅ Shows visual indicators on plots
- ✅ Reports frequency in seconds and minutes
- ✅ Helps plan field experiments
- ✅ Ensures you capture the full curve
- ✅ Minimizes risk of missing the peak

Use this tool to plan your sampling before going to the field, and you'll have confidence that you're collecting the right samples at the right times!
