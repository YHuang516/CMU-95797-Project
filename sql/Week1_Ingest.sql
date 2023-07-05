--By Yuli Huang, Start 06/29/2023

--Read data from /bike folder
--Use all_varchar=1 to load all columns as varchar
--Use union_by_name because data before and after 202102 has different format (13 and 15 columns).
CREATE TABLE bike_data AS SELECT * FROM read_csv_auto('.\data\bike\*-citibike-tripdata.csv.gz', all_varchar=1, union_by_name=True, filename=True);

--Read data from central_park_weather file
CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto('.\data\central_park_weather.csv', all_varchar=1, filename=True);

--Read data from daily_citi_bike_trip_counts_and_weather File
CREATE TABLE daily_citi_bike_trip_counts_and_weather AS SELECT * FROM read_csv_auto('.\data\daily_citi_bike_trip_counts_and_weather.csv', all_varchar=1, filename=True);

--Read data from fhv_bases file
CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto('.\data\fhv_bases.csv', all_varchar=1, filename=True, header=True);

--Read data from fhv_tripdata files, fhvhv_tripdata files, green_tripdata files, yellow_tripdata files in /taxi folder
--Use union_by_name in case there's data format inconsistency
CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('.\data\taxi\fhv_tripdata_*.parquet', union_by_name=True, filename=True);
CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('.\data\taxi\fhvhv_tripdata_*.parquet', union_by_name=True, filename=True);
CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('.\data\taxi\green_tripdata_*.parquet', union_by_name=True, filename=True);
CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('.\data\taxi\yellow_tripdata_*.parquet', union_by_name=True, filename=True);




