# Sparkify Data Warehouse Project

### Introduction

A startup called Sparkify wants to analyze the data they've been collecting on songs and user activity on their new music streaming app. The analytics team is particularly interested in understanding what songs users are listening to. Currently, they don't have an easy way to query their data, which resides in a directory of JSON logs on user activity on the app, as well as a directory with JSON metadata on the songs in their app.

They'd like a data engineer to create a Postgres database with tables designed to optimize queries on song play analysis, and bring you on the project. Your role is to create a database schema and ETL pipeline for this analysis. You'll be able to test your database and ETL pipeline by running queries given to you by the analytics team from Sparkify and compare your results with their expected results.

### Project Description


In this project, you'll apply what you've learned on data modeling with Postgres and build an ETL pipeline using Python. To complete the project, you will need to define fact and dimension tables for a star schema for a particular analytic focus, and write an ETL pipeline that transfers data from files in two local directories into these tables in Postgres using Python and SQL.


### Purpose of the Database

The purpose of this database is to enable **Sparkify**, a music streaming startup, to analyze song play data. By building a data warehouse, Sparkify can gain insights into user behaviors, such as what songs are most popular, when users listen to music, and which artists are frequently streamed. These insights can drive business decisions such as improving user experience, targeting specific user segments, and optimizing their marketing strategy.

### How to Run the Python Scripts

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

**ETL Pipeline**

    1. Extract data from JSON files in the data directory.
    2. Transform the data to fit the schema requirements.
    3. Load data into the respective database tables.
    
    
### Example Queries for Song Play Analysis


Below are sample queries and their results to analyze song play data:

**Top 5 Most Played Songs**

SELECT s.title, COUNT(*) AS play_count
FROM songplays sp
JOIN songs s ON sp.song_id = s.song_id
GROUP BY s.title
ORDER BY play_count DESC
LIMIT 5;


**Results:**

Title	Play Count
Song A	120
Song B	95
Song C	80

**Most Active Users**

SELECT u.first_name, u.last_name, COUNT(*) AS total_plays
FROM songplays sp
JOIN users u ON sp.user_id = u.user_id
GROUP BY u.first_name, u.last_name
ORDER BY total_plays DESC
LIMIT 5;

### Docstrings

Each function in the scripts includes a docstring that explains its purpose. Examples:

**create_database (in create_tables.py)**
    
    def create_database():
    """
    - Creates and connects to the sparkifydb
    - Returns the connection and cursor to sparkifydb
    """
    
**process_song_file (in etl.py)**

    def main():
    """
    - Establishes database connection and processes all song and log files.
    - Inserts data into the respective database tables.
    """
    
 **main (in etl.py)**
 
     def main():
    """
    - Establishes database connection and processes all song and log files.
    - Inserts data into the respective database tables.
    """
    

