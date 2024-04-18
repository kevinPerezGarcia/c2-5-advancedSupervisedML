import pandas as pd
from sklearn.model_selection import train_test_split

df = pd.read_csv("trabajoInicial/data/raw/data.csv", sep=';')

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