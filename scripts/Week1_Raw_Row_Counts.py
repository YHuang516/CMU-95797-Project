# By Yuli Huang from 06/30/2023
# Count row number for each table in the loaded database 'NYC_Transit_Data_Sets.db'
import duckdb

def row_count(db_name, output_file):
    # Connect to the database file
    conn = duckdb.connect(db_name)

    # Execute a query to get all table names in the database, no need to list all the table names, automation not manual!
    raw_tables = conn.execute("SELECT table_name FROM information_schema.tables").fetchall()

    # Open the output file
    with open(output_file, 'w') as f:
        # Loop through each table in the schema and count the rows
        for table in raw_tables:
            table_name = table[0]
            count = conn.execute(f'SELECT COUNT(*) FROM {table_name}').fetchone()[0]
            f.write(f'The table [{table_name}] has {count} rows\n')

if __name__ == "__main__":
    row_count(r'C:\CMU\2023_S2\95797_DataWarehousing\Class_Project\Data_Raw\NYC_Transit_Data_Sets.db', r'C:\CMU\2023_S2\95797_DataWarehousing\Class_Project\CMU-95797-Project\answers\Week1_raw_counts.txt')
