-- Create a new database
CREATE DATABASE template_postgis;

-- Make it a template database
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';

-- Connect to new database and install the pl/pgsql language
\c template_postgis

CREATE LANGUAGE plpgsql;

-- Install PostGIS (your file paths may vary)
\i /usr/share/postgresql/contrib/postgis-1.5/postgis.sql 
\i /usr/share/postgresql/contrib/postgis-1.5/spatial_ref_sys.sql
GRANT ALL ON geometry_columns TO PUBLIC;
GRANT ALL ON geography_columns TO PUBLIC;
GRANT ALL ON spatial_ref_sys TO PUBLIC;

-- vacuum freeze: it will guarantee that all rows in the database are
-- "frozen" and will not be subject to transaction ID wraparound
-- problems.
VACUUM FREEZE;

