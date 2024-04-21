import pandas as pd

df = pd.read_pickle("trabajoInicial/data/interim/data.pkl")
df_tipoDato = df.dtypes.reset_index()
df_tipoDato.columns = ['Variable', 'Tipo de dato original']

excel_file = "trabajoInicial/references/seguimientoVariables.xlsx"
sheet_name = "seguimientoVariables"
df_tipoDato.to_excel(excel_file, index=False, sheet_name=sheet_name)