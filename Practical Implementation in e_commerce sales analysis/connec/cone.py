# import pandas as pd
# import os
# files=os.listdir("C:/code_fun/sql/e_commerce slaes analysis/datasets")
# print(files)
# for file in files:
#     dataset=pd.read_csv(f"C:/code_fun/sql/e_commerce slaes analysis/datasets/{file}")
#     print(dataset.columns)


import pandas as pd
# dataset=pd.read_csv("C:/code_fun/sql/e_commerce slaes analysis/datasets/products.csv")

# dataset.rename(columns={"product category":"product_category"}, inplace = True)
# # print(dataset.columns)

# import pandas as pd
from sqlalchemy import create_engine
import os
username="root"
password="1234"
host="localhost"
database="e_commerce"

link= f"mysql+mysqlconnector://{username}:{password}@{host}/{database}"
connection= create_engine(link)
dataset=pd.read_csv("C:/code_fun/sql/e_commerce slaes analysis/datasets/geolocation.csv")
dataset.to_sql(name="geolocation",con=connection, index=False, if_exists="append")
print("1 file successfully pushed")


