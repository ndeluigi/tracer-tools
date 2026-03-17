import pandas as pd
import openpyxl

# Read the Excel file
file_path = 'Q_measurement_salt_inj.xlsx'

# First, check all sheets
xl_file = pd.ExcelFile(file_path)
print("=" * 80)
print(f"File: {file_path}")
print("=" * 80)
print(f"\nAvailable sheets: {xl_file.sheet_names}")

# Read each sheet
for sheet_name in xl_file.sheet_names:
    print(f"\n{'=' * 80}")
    print(f"Sheet: {sheet_name}")
    print("=" * 80)
    
    # Try reading with header=None to see raw data
    df = pd.read_excel(file_path, sheet_name=sheet_name, header=None)
    
    print(f"\nShape: {df.shape[0]} rows × {df.shape[1]} columns")
    print(f"\nAll data:")
    print(df.to_string())
