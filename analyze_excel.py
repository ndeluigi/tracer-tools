import pandas as pd

# Read the Excel file
file_path = 'Q_measurement_salt_inj.xlsx'

# Check all sheets
xl_file = pd.ExcelFile(file_path)
print("=" * 80)
print(f"File: {file_path}")
print("=" * 80)
print(f"Available sheets: {xl_file.sheet_names}\n")

# Read each sheet
for sheet_name in xl_file.sheet_names:
    print(f"{'=' * 80}")
    print(f"Sheet: {sheet_name}")
    print("=" * 80)
    
    # Try reading with header=None to see raw data
    df = pd.read_excel(file_path, sheet_name=sheet_name, header=None)
    
    print(f"Shape: {df.shape[0]} rows × {df.shape[1]} columns\n")
    
    # Show first 20 rows
    print("First 20 rows:")
    print(df.head(20))
    
    # Show last 10 rows
    print("\nLast 10 rows:")
    print(df.tail(10))
    
    # Save to CSV for easier viewing
    csv_filename = f'{sheet_name.replace(" ", "_")}_data.csv'
    df.to_csv(csv_filename, index=False)
    print(f"\n✓ Saved to: {csv_filename}")
    
    # Show non-null value counts
    print(f"\nNon-null values per column:")
    print(df.count())
