import pandas as pd

# Read the Excel file
file_path = 'Q_measurement_salt_inj.xlsx'
df = pd.read_excel(file_path)

# Display basic information
print("=" * 80)
print(f"File: {file_path}")
print("=" * 80)
print(f"\nShape: {df.shape[0]} rows × {df.shape[1]} columns")
print(f"\nColumn names:")
for i, col in enumerate(df.columns, 1):
    print(f"  {i}. {col}")

print(f"\nData types:")
print(df.dtypes)

print(f"\n{'=' * 80}")
print("First 10 rows:")
print("=" * 80)
print(df.head(10))

print(f"\n{'=' * 80}")
print("Basic statistics:")
print("=" * 80)
print(df.describe())
