import pandas as pd
import numpy as np

# Read the CSV
df = pd.read_csv('with_salt_data.csv')

# Extract key parameters
mass_salt = 3500  # g
background_cond = 359  # uS/cm
dt = 10  # seconds
calculated_Q = 468.84366789022783  # L/s

# Calibration coefficients
b = 0.0005219489557304609  # (g/L) / (mS/cm)
a = -0.012659339533307482  # g/L

# Extract conductivity data (column 4, starting from row 40)
conductivity_data = df.iloc[39:, 4].dropna().astype(float).values
print("Conductivity timeseries:")
print(conductivity_data)
print(f"\nNumber of measurements: {len(conductivity_data)}")

# Convert conductivity to concentration using calibration
# spCOND is in uS/cm, need to convert to mS/cm for the formula
# Conc = a + b * spCOND (where spCOND is in mS/cm)
conductivity_mS = conductivity_data / 1000  # Convert uS/cm to mS/cm
background_mS = background_cond / 1000

concentration = a + b * conductivity_mS
background_conc = a + b * background_mS

print(f"\nBackground concentration: {background_conc:.6f} g/L")
print(f"\nConcentration timeseries (first 10):")
print(concentration[:10])

# Calculate excess concentration (above background)
excess_conc = concentration - background_conc
print(f"\nExcess concentration (first 10):")
print(excess_conc[:10])

# Salt dilution method: Q = M / integral(C(t) dt)
# Where M is mass of salt injected, C(t) is excess concentration
# Integral approximated as sum(C * dt)

integral_C_dt = np.sum(excess_conc) * dt  # g/L * s
print(f"\nIntegral of C(t) dt: {integral_C_dt:.6f} g*s/L")

# Discharge calculation
Q_calculated = mass_salt / integral_C_dt  # g / (g*s/L) = L/s
print(f"\nCalculated discharge Q: {Q_calculated:.6f} L/s")
print(f"Expected discharge Q: {calculated_Q:.6f} L/s")
print(f"Match: {np.isclose(Q_calculated, calculated_Q)}")

print("\n" + "="*80)
print("DISCHARGE CALCULATION METHOD - SALT DILUTION")
print("="*80)
print("""
The discharge is calculated using the salt dilution method:

1. Inject a known mass of salt (M) into the stream
2. Measure conductivity over time downstream
3. Convert conductivity to concentration using calibration:
   Conc [g/L] = a + b * spCOND [mS/cm]
   
4. Calculate excess concentration above background:
   C_excess(t) = Conc(t) - Conc_background
   
5. Integrate excess concentration over time:
   Integral = Σ(C_excess * Δt)
   
6. Calculate discharge:
   Q [L/s] = M [g] / Integral [g*s/L]

Parameters:
- Mass of salt injected (M): {:.1f} g
- Background conductivity: {:.1f} µS/cm
- Time step (Δt): {} s
- Calibration coefficients:
  - a = {:.6f} g/L
  - b = {:.10f} (g/L)/(mS/cm)
  
Result: Q = {:.2f} L/s
""".format(mass_salt, background_cond, dt, a, b, Q_calculated))
