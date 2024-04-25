import pandas as pd
from kenpkgs.report_excel import report_df_to_excel

df = pd.read_pickle("trabajoInicial/data/interim/data.pkl")

df_categorias = pd.DataFrame(columns=['Categorías'])

for columna in df.columns:
    if df[columna].nunique() <= 15:
        lista_categorias = sorted(df[columna].value_counts().index.to_list())
        string_categorias = ', '.join(map(str, lista_categorias))
        df_categorias.loc[len(df_categorias)] = [string_categorias]
    else:
        df_categorias.loc[len(df_categorias)] = ["No aplica"]
df_categorias

report_df_to_excel(df=df_categorias, filename="trabajoInicial/references/seguimientoVariables.xlsx")