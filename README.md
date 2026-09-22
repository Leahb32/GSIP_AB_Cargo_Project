# us_cargo_theft
To programmatically isolate, analyze, and visualize high-value cargo theft incidents occurring across critical U.S. transportation corridors. This tactical threat assessment pinpoints geographic and structural vulnerabilities to assist logistics security forces in risk mitigation and resource deployment.



Cargo Theft Analysis Project Report
Author: Aliyah Brown

1. Operational Scenario & Objective
Target Audience: Intelligence Agency
Objective: To programmatically isolate, analyze, and visualize high-value cargo theft incidents occurring across critical U.S. transportation corridors. This tactical threat assessment pinpoints geographic and structural vulnerabilities to assist logistics security forces in risk mitigation and resource deployment.

2. The Technical Stack & Data Ingestion Pipeline
This project bridges the gap between data analytics and geospatial intelligence (GEOINT) by employing an end-to-end local pipeline using completely free resources:
•	Raw Data Source: FBI Crime Data Explorer (CDE). Dataset conforms to the Federal National Incident-Based Reporting System (NIBRS) standard.
•	Data Hygiene & Filtering: Python 3 (Pandas Library).
•	Relational Storage & Querying: MySQL Server 8.0 & MySQL Workbench.
•	Geospatial Visualization: QGIS Desktop 3.44 LTR (Long-Term Release).
•	Spatial Base Vectors: U.S. Census Bureau TIGER/Line Shapefiles (State Boundaries).

3. Phase 1: Data Wrangling (Python)
Filename: clean_cargo.py
Purpose: This script uses federal crime dumps and executes repeatable data hygiene by programmatically filtering for incidents that directly impact the commercial shipping network.

Methodology:
    1. Loads the raw national dataset (fbi_cde_cargo_theft_raw.csv).
    2. Filters the ‘location_name’ column to isolate location nodes (e.g., *Docks, Wharves, Highways, Freight Terminals, Industrial Sites, Parking Lots*).
    3. Filters for theft valued at $5,000 or more. This removes minor neighborhood crimes and focuses the analysis entirely on organized crime rings. 
    4. Outputs a refined spreadsheet: `clean_supply_chain_theft.csv`.

Result: Programmatically filtered the dataset down to 27,026 structural supply chain threat records.

4. Phase 2: Relational Database Storage & Analytics (MySQL)
File Name: analysis_queries.sql  
Purpose: Structures the refined operational data into a local relational database to execute rapid intelligence queries.

Database Ingestion: Configured local connection environments (`OPT_LOCAL_INFILE=1`) to stream the 27,026 records directly into a target schema in under two seconds.

Analytical Queries Executed:
1.	Target Profiling (step 4 in file): Aggregated criminal volume and total financial losses grouped by product types ‘commodity_type’ to see what items crime rings target most.
 
2.	Node Vulnerability (step 5 in file): Grouped data by ‘location_type’ to locate the exact infrastructure layers where security breaches occur.

 
    3. Regional Hotspots (step 6 in file): Isolated the top 10 state jurisdictions suffering from the highest frequency of cargo heists to feed the mapping pipeline.
 
---

5. Phase 3: Geospatial Visualization (QGIS)
File Name: cargo_theft_hotspot_map.png  
Purpose: Converts row calculations into actionable spatial intelligence.

Methodology:
    1. Imported the U.S. Census Bureau state vector shapefile layer into QGIS.
    2. Executed an alphanumeric **Attribute Table Join**, linking the MySQL regional summary table (state_name) to the shapefile map attributes (NAME).
    3. Applied **Rule-Based Symbology**. The top 10 highest-theft states were segmented into 5 distinct Red/Orange graduated risk brackets.
    4. Implemented an **"Else" Rule** to automatically color the remaining 40 states solid green, establishing a stable, low-risk baseline layout.

Key Analytical Findings:
The spatial output reveals massive national threat clusters centered heavily around primary shipping vulnerabilities and coastal trade entry points—with **California, Texas, and Florida** emerging as the highest-risk red zones for supply chain disruption.

6. Analyst Profile & Core Competencies
Name: Aliyah Brown
Technical Focus: SQL Scripting, Python Data Science, and Multi-Platform GIS environments.
