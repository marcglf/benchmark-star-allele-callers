import pypgx # type: ignore
import os
import pandas as pd # type: ignore

l = [i for i in os.listdir() if ".zip" in i and "control-statistics_" in i]

data = pd.DataFrame()
for i in l:
    t = pypgx.sdk.Archive.from_file(i)
    data = pd.concat([data, t.data], axis=0)

metadata = t.metadata
result = pypgx.sdk.Archive(metadata, data)
result.to_file('1KG-control-statistics.zip')
