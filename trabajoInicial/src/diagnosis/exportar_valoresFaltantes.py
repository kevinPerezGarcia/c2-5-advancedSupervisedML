import pandas as pd
from kenpkgs.report_excel import report_df_to_excel

df = pd.read_pickle('trabajoInicial/data/interim/data.pkl')

total_registros = len(df)
num_nans_por_columna = df.isnull().sum()

fraccion_nans_por_columna = []
porcentaje_nans_por_columna = []

for columna, num_nans in num_nans_por_columna.items():
    if num_nans > 0:
        fraccion = f"{num_nans}/{total_registros}"
        porcentaje = f"{(num_nans / total_registros * 100):.2f}%"
    else:
        fraccion = "No aplica"
        porcentaje = "No aplica"
    
    fraccion_nans_por_columna.append(fraccion)
    porcentaje_nans_por_columna.append(porcentaje)

df_nans = pd.DataFrame({
    '# NaNs': fraccion_nans_por_columna,
    '% NaNs': porcentaje_nans_por_columna
})

report_df_to_excel(df=df_nans, filename='trabajoInicial/references/seguimientoVariables.xlsx')
report_df_to_excel(df=df_nans, filename='trabajoInicial/references/seguimientoVariables.xlsx', num_col=1)