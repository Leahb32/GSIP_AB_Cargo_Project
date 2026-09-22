-- ==============================================================================
-- Project: GSIP Aliyah Brown Cargo Projectcargo_incidents
-- OBJECTIVE: Structure and store filtered federal transit crime datasets
--            to enable rapid operational threat intelligence queries.
-- ==============================================================================

-- 1. Create a clean workspace database
CREATE DATABASE IF NOT EXISTS supply_chain_intel;
USE supply_chain_intel;

-- 2. Drop the table if you are re-running this script later
DROP TABLE IF EXISTS cargo_incidents;

-- 3. Create the optimized target schema mapping to your Python output attributes
CREATE TABLE cargo_incidents (
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    data_year INT,
    agency_name VARCHAR(255),
    state_name VARCHAR(100),
    county_name VARCHAR(100),
    offense_name VARCHAR(255),
    location_type VARCHAR(255),
    commodity_type VARCHAR(255),
    stolen_value DECIMAL(12, 2)
);

-- Ingestion
SET GLOBAL local_infile = 1;

USE supply_chain_intel;

LOAD DATA LOCAL INFILE 'C:/Users/abr3709/Desktop/GSIP_AB_Cargo_Project/clean_supply_chain_theft.csv'
INTO TABLE cargo_incidents
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(data_year, agency_name, state_name, county_name, offense_name, location_type, commodity_type, stolen_value);


-- using FORMAT() to make numbers readable for presentation


-- 4. TARGET PROFILING
-- OBJECTIVE: Identify which product categories suffer the highest economic disruption, and possible
--             theft rings (e.g., fencing high-value electronics vs. liquidating clothing).
-- METHOD: Aggregates total incidents, calculates cumulative losses, 
--                  and averages individual heist values, sorted by financial impact.

USE supply_chain_intel;

SELECT commodity_type, 
       COUNT(*) as total_heists, 
       FORMAT(SUM(stolen_value), 2) as aggregate_loss_USD,
       FORMAT(ROUND(AVG(stolen_value), 2), 2) as average_heist_value_USD
FROM cargo_incidents
GROUP BY commodity_type
ORDER BY SUM(stolen_value) DESC;




-- 5. VULNERABILITY ASSESSMENT
-- OBJECTIVE: Isolate the exact operational environments where supply networks are failing.
-- METHOD: Groups criminal count and financial losses by NIBRS location type.

SELECT location_type, 
       COUNT(*) as incident_count,
       FORMAT(SUM(stolen_value), 2) as total_losses_USD
FROM cargo_incidents
GROUP BY location_type
ORDER BY incident_count DESC;




-- 6. HOTSPOT IDENTIFICATION

-- OBJECTIVE: Determine which state jurisdictions carry the highest risk profile.
-- ANALYSIS METHOD: Extracts count and volume totals by state, isolating the top 10 outliers.

SELECT state_name, 
       COUNT(*) as total_thefts,
       FORMAT(SUM(stolen_value), 2) as total_financial_impact_USD
FROM cargo_incidents
GROUP BY state_name
ORDER BY total_thefts DESC
LIMIT 10;





