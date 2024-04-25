import pandas as pd

df = pd.read_pickle("trabajoInicial/data/interim/data.pkl")
df_valoresUnicos = pd.DataFrame(df.nunique().reset_index(drop=True), columns=['Número de valores únicos'])

from kenpkgs.report_excel import report_df_to_excel
report_df_to_excel(df=df_valoresUnicos, filename='trabajoInicial/references/seguimientoVariables.xlsx')