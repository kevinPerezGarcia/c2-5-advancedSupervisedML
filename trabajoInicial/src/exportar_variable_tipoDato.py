import pandas as pd

df = pd.read_pickle("trabajoInicial/data/interim/data.pkl")
df_tipoDato = df.dtypes.reset_index()
df_tipoDato.columns = ['Variable', 'Tipo de dato original']

df_tipoDato.to_excel("trabajoInicial/references/seguimientoVariables.xlsx", index=False, sheet_name="seguimientoVariables")