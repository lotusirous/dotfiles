import pandas as pd
from urllib.parse import quote_plus
from sqlalchemy import create_engine


engine = create_engine('mysql+mysqldb://root:%s@206.189.32.123/shc1' % quote_plus("infini@2019"))
df = pd.read_sql("SELECT * FROM shinhan_chi_tiet_giao_dich_the", engine)
df.head()
