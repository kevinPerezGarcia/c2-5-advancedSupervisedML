import pandas as pd

df = pd.read_pickle("trabajoInicial/data/interim/data.pkl")

# Crear DataFrame con los nombres originales de las variables
df_columns = pd.DataFrame(df.columns, columns=['Variable original'])

df_columns.to_excel('trabajoInicial/references/seguimientoVariables.xlsx', index=False, sheet_name='seguimientoVariables')