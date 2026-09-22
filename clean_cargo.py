import pandas as pd



# 1. Load the raw data file (ignoring mixed data type warnings)

print("--> Step 1: Loading raw FBI dataset...")
df = pd.read_csv("fbi_cde_cargo_theft_raw.csv", low_memory=False)
print(f"--> Success! Total raw records loaded: {len(df)}")

# 2. Define supply chain location filters matching FBI standards

supply_chain_locations = [
    "Dock/Wharf/Freight/Modal Terminal",
    "Highway/Road/Alley/Street/Sidewalk",
    "Commercial/Office Building",
    "Industrial Site",
    "Parking/Drop Lot/Garage",
    "Service/Gas Station",
    "Rental Storage Facility"
]

# 3. Apply the location filter

print("--> Step 2: Filtering records by supply chain location types...")
df_filtered = df[df['location_name'].isin(supply_chain_locations)].copy()

# 4. Filter out low-value petty thefts (keeping structural heists >= $5,000)

print("--> Step 3: Isolating high-value losses (>= $5,000) for organized crime analysis...")
df_cargo_intel = df_filtered[df_filtered['stolen_value'] >= 5000].copy()

# 5. Select only the columns critical for our MySQL database and ArcMap visualization

columns_to_keep = [
    'data_year', 'pub_agency_name', 'state_name', 'county_name', 
    'offense_name', 'location_name', 'prop_desc_name', 'stolen_value'
]
df_final = df_cargo_intel[columns_to_keep]

# 6. Export to a brand new, clean CSV file

print("--> Step 4: Exporting processed intelligence data to a clean spreadsheet...")
df_final.to_csv("clean_supply_chain_theft.csv", index=False)

print(f"\n[!] DATA WRANGLING COMPLETE!")
print(f"Isolated {len(df_final)} structural supply chain theft records.")
print("The file 'clean_supply_chain_theft.csv' has been generated in your folder!")
