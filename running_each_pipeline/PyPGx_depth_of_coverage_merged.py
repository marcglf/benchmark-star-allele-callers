import pypgx # type: ignore
import os
import pandas as pd # type: ignore
import fuc #type: ignore

l = [i for i in os.listdir() if ".zip" in i and "depth-of-coverage_" in i]

data = pd.DataFrame()
for i in l:
    t = pypgx.sdk.Archive.from_file(i)
    if i == l[0]:
        data = t.data.df
    else :
        data = pd.merge(data, t.data.df, on=['Chromosome', 'Position'])

data = fuc.api.pycov.CovFrame(data)
metadata = t.metadata
result = pypgx.sdk.Archive(metadata, data)
result.to_file('/path/to/data/depth_of_coverage/all-depth-of-coverage.zip')
