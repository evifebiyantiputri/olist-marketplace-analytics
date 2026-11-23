import sqlite3
import pandas as pd
from pathlib import Path

#project path
folderdata = Path("data/raw")
dbpath = "data/olist.db"

#connect ke sqlite
connection = sqlite3.connect(dbpath)

#import
for file in folderdata.glob("*.csv"):
    data = pd.read_csv(file)
    table_name = file.stem.replace("-","_")
    data.to_sql(
        table_name,
        connection,
        if_exists="replace",
        index = False
    )
    print(f"Imported {table_name}: {len(data)} rows")

#tutup connection
connection.close()
