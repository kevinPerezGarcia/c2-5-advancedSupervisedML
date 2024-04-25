import pandas as pd
from kenpkgs.report_excel import report_df_to_excel
from utils.importar_tipoVariable import dict_tipoVariable
dict_tipoVariable = dict_tipoVariable()

df = pd.read_pickle('trabajoInicial/data/interim/data.pkl')

list_minmax = []

for column in df.columns:
    if dict_tipoVariable[column].startswith('cnt'):
        min_value = df[column].min()
        max_value = df[column].max()
        list_minmax.append(f'{min_value}-{max_value}')
    else:
        list_minmax.append('No aplica')
        
df_minmax = pd.DataFrame(list_minmax, columns=['Min-Max'])

report_df_to_excel(df_minmax, 'trabajoInicial/references/seguimientoVariables.xlsx')