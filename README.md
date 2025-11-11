### Introducción

Esta segunda tarea de programación requiere que escribas una función en R
que pueda almacenar en caché cálculos que pueden consumir mucho tiempo.

Por ejemplo, calcular la media de un vector numérico suele ser una operación rápida.
Sin embargo, para un vector muy largo, calcular la media puede tardar demasiado,
especialmente si se debe calcular repetidamente (por ejemplo,
en un bucle). Si el contenido de un vector no cambia, puede ser conveniente
almacenar en caché el valor de la media para que, cuando la necesitemos de 
nuevo, podamos consultarla en la caché en lugar de recalcularla. 
En esta tarea de programación, aprovecharás las reglas de ámbito del lenguaje R 
y cómo se pueden manipular para preservar el estado dentro de un objeto de R.

### Ejemplo: Almacenar en caché la media de un vector

En este ejemplo, presentamos el operador `<<-`, que se puede usar para
asignar un valor a un objeto en un entorno distinto del
entorno actual. A continuación, se muestran dos funciones que se utilizan para crear un
objeto especial que almacena un vector numérico y guarda en caché su media.

La primera función, `makeVector`, crea un "vector" especial, que en realidad es 
una lista que contiene una función para

1. Asignar el valor al vector
2. Obtener el valor del vector
3. Asignar el valor a la media
4. Obtener el valor de la media

<!---->
```r
    makeVector <- function(x = numeric()) {
            m <- NULL
            set <- function(y) {
                    x <<- y
                    m <<- NULL
            }
            get <- function() x
            setmean <- function(mean) m <<- mean
            getmean <- function() m
            list(set = set, get = get,
                 setmean = setmean,
                 getmean = getmean)
    }
```
La siguiente función calcula la media del vector especial
creado con la función anterior. Sin embargo, primero comprueba si la 
media ya se ha calculado. Si es así, obtiene la media de la caché y 
omite el cálculo. De lo contrario, calcula la media de los datos y 
establece su valor en la caché mediante la función `setmean`.

```r
    cachemean <- function(x, ...) {
            m <- x$getmean()
            if(!is.null(m)) {
                    message("getting cached data")
                    return(m)
            }
            data <- x$get()
            m <- mean(data, ...)
            x$setmean(m)
            m
    }
```

### Assignment: Caching the Inverse of a Matrix

La inversión de matrices suele ser un cálculo costoso, por lo que podría ser más 
ventajoso almacenar en caché la inversa de una matriz en lugar de calcularla 
repetidamente (existen alternativas a la inversión de matrices que no abordaremos 
aquí). Su tarea consiste en escribir un par de funciones que almacenen en caché la 
inversa de una matriz.

Escriba las siguientes funciones:

1. `makeCacheMatrix`: Esta función crea un objeto "matriz" especial
    que puede almacenar en caché su inversa.

2. `cacheSolve`: Esta función calcula la inversa de la matriz especial
    devuelta por `makeCacheMatrix`. Si la inversa ya se ha calculado 
    (y la matriz no ha cambiado), entonces `cacheSolve` debe recuperarla
    de la caché.

Calcular la inversa de una matriz cuadrada se puede hacer con la función `solve`
en R. Por ejemplo, si `X` es una matriz cuadrada invertible, entonces
`solve(X)` devuelve su inversa.

Para esta tarea, asuma que la matriz proporcionada es siempre invertible.

Para completar esta tarea, debe hacer lo siguiente:

1. Crea una bifurcación del repositorio de GitHub que contiene los archivos R de ejemplo en
  [https://github.com/rdpeng/ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2)
  para crear una copia en tu propia cuenta.

2. Clona tu bifurcación del repositorio de GitHub en tu ordenador para poder
  editar los archivos localmente en tu máquina.

3. Edita el archivo R que se encuentra en el repositorio de Git e incluye tu
  solución en ese archivo (no lo renombres).

4. Confirma los cambios en tu archivo R completo en TU repositorio de Git y sube tu
  rama de Git al repositorio de GitHub de tu cuenta.

5. Envía a Coursera la URL de tu repositorio de GitHub que contiene
  el código R completo para la tarea.

### Calificación

Esta tarea se calificará mediante evaluación entre pares.
