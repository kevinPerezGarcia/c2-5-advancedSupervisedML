import pandas as pd

def dict_tipoVariable():
    df = pd.read_excel('trabajoInicial/references/seguimientoVariables.xlsx',
                    sheet_name='seguimientoVariables',
                    usecols=['Variable', 'Tipo de variable'],
                    index_col=0)

    return df['Tipo de variable'].to_dict()