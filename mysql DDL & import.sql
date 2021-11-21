/* table london_bike_share*/

DROP TABLE test.london_bike_share;

CREATE TABLE test.london_bike_share (
rental_id INT,
duration float(10),
bike_id INT,
end_rental_date_time datetime,
end_station_id INT,
end_station_name varchar(200),
start_rental_date_time datetime,
start_station_id INT,
start_station_name varchar(200),
INDEX ind_rental_id (rental_id)
)
;
/* problem s zpracovanim null values  https://dba.stackexchange.com/questions/97891/mysql-error-when-importing-csv-with-empty-fields*/

LOAD DATA  INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/london.csv' 
INTO TABLE test.london_bike_share 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'	
LINES TERMINATED BY '\n'
IGNORE 1 ROWS

(rental_id, @duration, @bike_id, @end_rental_date_time, @end_station_id, end_station_name, @start_rental_date_time, start_station_id, start_station_name)
SET 
duration = NULLIF(@duration,''),
end_station_id = NULLIF(@end_station_id,''),
bike_id = NULLIF(@bike_id,''),
end_rental_date_time = NULLIF(@end_rental_date_time,''),
start_rental_date_time = NULLIF(@start_rental_date_time,'')
;
/*je potreba osetrit null values + upravit connection time*/
/* full load za 1167 sec (ale bez indexu), 38 mil rows */
# https://stackoverflow.com/questions/32737478/how-should-i-tackle-secure-file-priv-in-mysql


CREATE INDEX ind_rental_id
ON test.london_bike_share (rental_id);

/* table london stations */

drop tables test.london_stations;

CREATE TABLE test.london_stations (
station_id INT,
station_name varchar(200),
longitude float(11),
latitude float(11))
;

CREATE INDEX ind_station_id
ON test.london_stations (station_id);

LOAD DATA  INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/london_stations.csv' 
INTO TABLE test.london_stations 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/*size of table */

SELECT
  TABLE_NAME AS `Table`,
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024) AS `Size (MB)`,
  table_rows
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA = 'TEST'
ORDER BY
  (DATA_LENGTH + INDEX_LENGTH)
DESC;
