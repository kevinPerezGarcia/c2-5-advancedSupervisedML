import pandas as pd

excel_file = "trabajoInicial/references/seguimientoVariables.xlsx"
sheet_name = "seguimientoVariables"
df_excel =pd.read_excel(excel_file)

df = pd.read_pickle("trabajoInicial/data/interim/data.pkl")
df_valoresUnicos = pd.DataFrame(df.nunique().reset_index(drop=True), columns=['Número de valores únicos'])

df_excel_concated = pd.concat([df_excel, df_valoresUnicos], axis=1)
df_excel_concated.to_excel(excel_file, index=False, sheet_name=sheet_name)