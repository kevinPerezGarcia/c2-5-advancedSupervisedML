import pandas as pd

df = pd.read_csv("trabajoInicial/data/raw/data.csv", sep=';')

# Lista de columnas específicas a colocar al principio
columnas_al_inicio = [ 'ATTRITION']

# Lista de columnas específicas a colocar al final
columnas_al_final = ['ID_CORRELATIVO', 'CODMES']

# Obtener una lista de todas las columnas en el DataFrame
todas_las_columnas = df.columns.tolist()

# Obtener una lista de las columnas que no están en la lista de columnas específicas
columnas_restantes = [col for col in todas_las_columnas if col not in (columnas_al_inicio + columnas_al_final)]

# Ordenar alfabéticamente las columnas restantes
columnas_restantes.sort()

# Concatenar la lista de columnas específicas al principio con las columnas restantes ordenadas alfabéticamente
nuevo_orden_columnas = columnas_al_inicio + columnas_restantes + columnas_al_final

# Reorganizar las columnas del DataFrame en el nuevo orden
df = df.reindex(columns=nuevo_orden_columnas)

df.to_pickle("trabajoInicial/data/interim/data.pkl")
