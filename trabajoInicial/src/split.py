import pandas as pd
from sklearn.model_selection import train_test_split

df = pd.read_csv("trabajoInicial/data/raw/data.csv", sep=';')

df.drop(['ATTRITION', 'CODMES'], axis=1, inplace=True)

# Lista de columnas específicas a colocar al principio
columnas_al_inicio = [ 'ATTRITION']

# Obtener una lista de todas las columnas en el DataFrame
todas_las_columnas = df.columns.tolist()

# Obtener una lista de las columnas que no están en la lista de columnas específicas
columnas_restantes = [col for col in todas_las_columnas if col not in columnas_al_inicio]

# Ordenar alfabéticamente las columnas restantes
columnas_restantes.sort()

# Concatenar la lista de columnas específicas al principio con las columnas restantes ordenadas alfabéticamente
nuevo_orden_columnas = columnas_al_inicio + columnas_restantes

# Reorganizar las columnas del DataFrame en el nuevo orden
df = df.reindex(columns=nuevo_orden_columnas)

target = 'ATTRITION'
X = df.drop(target, axis=1)
y = df[[target]]

X_train, X_temp, y_train, y_temp = train_test_split(X, y, test_size=0.3, stratify=y, random_state=2024)
X_val, X_test, y_val, y_test = train_test_split(X_temp, y_temp, test_size=0.5, stratify=y_temp, random_state=2024)

X_train.to_pickle("trabajoInicial/data/interim/X_train.pkl")
X_val.to_pickle("trabajoInicial/data/interim/X_val.pkl")
X_test.to_pickle("trabajoInicial/data/interim/X_test.pkl")
y_train.to_pickle("trabajoInicial/data/interim/y_train.pkl")
y_val.to_pickle("trabajoInicial/data/interim/y_val.pkl")
y_test.to_pickle("trabajoInicial/data/interim/y_test.pkl")