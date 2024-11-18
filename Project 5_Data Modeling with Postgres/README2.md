# Sparkify Data Warehouse Project

## Purpose of the Database

The purpose of this database is to enable **Sparkify**, a music streaming startup, to analyze song play data. By building a data warehouse, Sparkify can gain insights into user behaviors, such as what songs are most popular, when users listen to music, and which artists are frequently streamed. These insights can drive business decisions such as improving user experience, targeting specific user segments, and optimizing their marketing strategy.

## How to Run the Python Scripts

**Install Dependencies**  
   Ensure you have Python installed along with the following packages:  
   - `psycopg2`  
   - `pandas`  
   - `glob`  
   - `os`  

   You can install them using:


**Create and Populate the Database**

Run the following scripts in order:

    * create_tables.py: This script sets up the database schema by creating and resetting the tables.

python create_tables.py

    * etl.py: This script performs the ETL (Extract, Transform, Load) process by loading the data from JSON files into the database.
        * python etl.py
        
**Run Queries for Analysis**

Use test.ipynb to run queries and perform analysis on the Sparkify database.

**Repository Files**


File Name	Description
create_tables.py	Script to create and reset database tables.
etl.py	ETL pipeline to extract, transform, and load data from song and log datasets into the database.
sql_queries.py	Contains all SQL queries for creating, inserting, and selecting data.
test.ipynb	Jupyter notebook to test and analyze the database after ETL.
data/	Folder containing JSON files for song and log data.
README.md	This documentation file.


### Database Schema Design and ETL Pipeline

**Schema Design**

The schema follows a Star Schema with the following tables:

    * Fact Table:
        * songplays: Records of song play events.

    * Dimension Tables:

        users: User information.
        songs: Song details.
        artists: Artist details.
        time: Timestamps of events.
        
**Justification:**
The star schema simplifies queries for analytical purposes, making it efficient to aggregate data such as total plays by user or time period.

ETL Pipeline
Extract data from JSON files in the data directory.
Transform the data to fit the schema requirements.
Load data into the respective database tables.
Example Queries for Song Play Analysis
Below are sample queries and their results to analyze song play data:

1. Top 5 Most Played Songs
sql
Copy code
SELECT s.title, COUNT(*) AS play_count
FROM songplays sp
JOIN songs s ON sp.song_id = s.song_id
GROUP BY s.title
ORDER BY play_count DESC
LIMIT 5;
Results:

Title	Play Count
Song A	120
Song B	95
Song C	80