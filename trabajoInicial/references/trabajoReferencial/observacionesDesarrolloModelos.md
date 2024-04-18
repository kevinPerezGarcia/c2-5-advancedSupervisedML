    # Observaciones sobre el desarrollo de modelos

    1. Data Leakage: La división de datos no se ejecuta antes del preprocesamiento.
    2. La variable objetivo es una variable binaria desbalanceada, la división de datos no se realizó con estratificación respecto a esta variable.
    3. Teniendo como objetivo comparar varios modelos, la base de datos no se dividió en los conjuntos de entrenamiento, validación y prueba. Al sólo contar con entrenamiento y prueba, la comparación de los rendimientos está siendo de modelos ajustados sólo a estos conjuntos de datos. Se necesita un tercer conjunto de datos que los modelos no hayan visto para comparar sus rendimientos.