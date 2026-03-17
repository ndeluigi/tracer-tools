import pandas as pd
import numpy as np

# Read the CSV
df = pd.read_csv('with_salt_data.csv')

# Extract key parameters
M = 3500  # g - Mass of salt
background = 359  # µS/cm - Background conductivity
dt = 10  # seconds - Time step
b = 1/1915.89616  # (g/L) / (µS/cm) - Calibration coefficient

print(f"Calibration coefficient b = {b:.10f} (g/L)/(µS/cm)")

# Extract conductivity data (column 4, starting from row 40)
conductivity_data = df.iloc[39:, 4].dropna().astype(float).values
print(f"\nNumber of measurements: {len(conductivity_data)}")
print(f"Conductivity data (first 10): {conductivity_data[:10]}")
print(f"Conductivity data (last 10): {conductivity_data[-10:]}")

# Calculate using the Excel formula
sum_conductivity = np.sum(conductivity_data)
count_conductivity = len(conductivity_data)

print(f"\nSUM(conductivity) = {sum_conductivity:.2f} µS/cm")
print(f"COUNT(conductivity) = {count_conductivity}")
print(f"Background * COUNT = {background * count_conductivity:.2f} µS/cm")

total_excess_conductivity = sum_conductivity - background * count_conductivity
print(f"\nTotal excess conductivity = {total_excess_conductivity:.2f} µS/cm")

integral = total_excess_conductivity * b * dt
print(f"Integral = {integral:.6f} g*s/L")

Q = M / integral
print(f"\n{'='*80}")
print(f"CALCULATED DISCHARGE Q = {Q:.2f} L/s")
print(f"{'='*80}")

# Compare with expected value
expected_Q = 468.84366789022783
print(f"\nExpected Q from Excel: {expected_Q:.2f} L/s")
print(f"Difference: {abs(Q - expected_Q):.6f} L/s")
print(f"Match: {np.isclose(Q, expected_Q, rtol=1e-6)}")
