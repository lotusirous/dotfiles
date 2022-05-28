import pandas as pd
from urllib.parse import quote_plus
from sqlalchemy import create_engine


engine = create_engine('mysql+mysqldb://root:%s@your.ip.server/databasename' % quote_plus("your_db_password"))
df = pd.read_sql("SELECT 1 FROM DUAL", engine)
df.head()
