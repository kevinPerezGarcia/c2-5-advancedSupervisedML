![logo](https://github.com/kevinPerezGarcia/kevinPerezGarcia/blob/main/logo.png)

> Año 2024 <br>
Universidad Nacional de Ingeniería <br>
Facultad de Ingeniería Económica, Estadística y Ciencias Sociales <br>
Maestría en Data Science <br>
Ciclo 2 <br>
Advanced Machine Learning <br>
Trabajo Inicial

# Deserción de Clientes en una Institución Bancaria

## 👥 Alumno

[@Kevin Perez Garcia](https://www.linkedin.com/in/kevinperezgarcia)

🤝 ¡Las observaciones, las recomendaciones y las contribuciones son bienvenidas!

📞 Para más consultas o colaboraciones, comuníquese a `econ.perez.garcia.k@gmail.com`.

## 📌 Tabla de contenido
- [Deserción de Clientes en una Institución Bancaria](#deserción-de-clientes-en-una-institución-bancaria)
  - [👥 Alumno](#-alumno)
  - [📌 Tabla de contenido](#-tabla-de-contenido)
  - [Información del trabajo](#información-del-trabajo)
  - [Información del proyecto](#información-del-proyecto)
  - [Diccionario de variables](#diccionario-de-variables)

## Información del trabajo

* Fecha de entrega: 24 de abril
* ¿Individual o grupal? Grupal
* Exposición: 1 integrante
* Objetivo: Comparar el rendimiento de generalización de al menos un modelo boosting vs un modelo GAM o un modelo GAMLSS
* [Trabajo referencial](/trabajoInicial/references/trabajoReferencial/)
* [Datos](/trabajoInicial/data/raw/): está referida a una entidad financiera, se cuenta con [diccionario de variables](/trabajoInicial/references/)
* Softwares a usar: R (con más paquetes sobre GAM) o Python
* Entregrables: Scripts R ó notebooks de Python

## Información del proyecto

* Proyecto: Deserción de clientes
* Machine learning: Supervisado
* Categoría: Clasificación binaria
* Target: `ATTRITION`
* Medida de desempeño: AUC-ROC
* Algoritmos:
  * AdaBoost (Computacional)
  * LightGBM (Computacional)
  * GAM (Estadístico)

## Diccionario de variables

| ROL | NOMBRE DE VARIABLE | DESCRIPCIÓN | CORTE |
|---|---|---|---|
| ID | ID_CORRELATIVO | ID Cliente correlativo | mes 0 = mes de   referencia |
| Partición | CODMES | Mes de referencia | mes 0 |
| Predictora | FLG_BANCARIZADO | Flag Bancarizado (1) / no bancarizado (0) | mes 0 |
| Predictora | RANG_INGRESO | Ingreso estimado: rangos de menor hasta mayor ingreso (rang_ingreso_01, rang_ingreso_02, etc) | mes 0 |
| Predictora | FLAG_LIMA_PROVINCIA | Lugar de residencia: Lima (1), provincia (0) | mes 0 |
| Predictora | EDAD | Edad | mes 0 |
| Predictora | ANTIGÜEDAD | Antigüedad | mes 0 |
| Target | ATTRITION | Flag Attrition / deserción de clientes: attrition (1), No cae en attrition (0) | variable target |
| Predictora | RANG_SDO_PASIVO_MENOS0 | Saldo ahorros: rangos de menor a mayor monto (cero, rango_sdo_01, rango_sdo_02, etc) | mes 0 |
| Predictora | SDO_ACTIVO | Saldo / deuda en créditos | mes -5 hasta 0 =   últimos 6 meses |
| Predictora | FLG_SEGURO | Flag tiene algún seguro: tiene seguro (1), no tiene seguro (0) | mes -5 hasta 0 |
| Predictora | RANG_NRO_PRODUCTOS_MENOS0 | Número de productos con la entidad: rangos de menor a mayor cantidad de productos (rango_01,   rango_02, etc) | mes 0 |
| Predictora | FLG_NOMINA | Flag nómina: si (1), no (0) | mes 0 |
| Predictora | NRO_ACCES_CANAL1 | Nro de operaciones por el canal 1 | mes -5 hasta 0 |
| Predictora | NRO_ACCES_CANAL2 | Nro de operaciones por el canal 2 | mes -5 hasta 0 |
| Predictora | NRO_ACCES_CANAL3 | Nro de operaciones por el canal 3 | mes -5 hasta 0 |
| Predictora | NRO_ENTID_SSFF | Nro de entidades en el sistema financiero | mes -5 hasta 0 |
| Predictora | FLG_SDO_OTSSFF | Flag tiene saldo en otras entidades del sistema financiero: tiene saldo (1), no tiene saldo (0) | mes -5 hasta 0 |

Significado de los sufijos en los nombres de las variables:	
* _menos0:	mes de referencia (201208)
* _menos1:	mes referencia menos 1 (201207)
* _menos2:	mes referencia menos 2 (201206)
* _menos3:	mes referencia menos 3 (201205)
* _menos4:	mes referencia menos 4 (201204)
* _menos5:	mes referencia menos 5 (201203)