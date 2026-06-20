# Modelos-de-interacci-n-luz-materia-en-MATLAB (2021)
Simulación de Interacción Luz-Materia en 1D. (2021)

DESCRIPCIÓN: Este proyecto simula la interacción entre un rayo luminoso (onda electromagnética) y un sistema de partículas cargadas unidas por muelles en una superficie unidimensional. El objetivo principal es estudiar el comportamiento de la materia y los patrones de transferencia de energía durante dicha interacción.

CARACTERÍSTICAS
1. Resolución de la Ecuación de Ondas: Generación de un potencial eléctrico sinusoidal variable en el tiempo para formar la onda.
   
2. Dinámica de Partículas: Implementación del algoritmo de Verlet velocidades para resolver numéricamente las ecuaciones de movimiento (posición, velocidad y aceleración).
   
3. Análisis Energético: Cálculo de la energía cinética, potencial elástica y potencial eléctrica de cada partícula.
   
4. Escalabilidad: El sistema permite simular diferentes configuraciones, como 5, 9 u 11 partículas, y variar los modos de propagación de la onda.

ESTRUCTURA
- Ec_ondas.m: Resuelve la ecuación de ondas para obtener el potencial y el campo eléctrico.
- Luz_materia.m: script principal. Define las condiciones iniciales del sistema de partículas, gestiona la interacción y calcula las energías.
- Fuerzas_part.m: Función que calcula las fuerzas totales (elástica y eléctrica) sobre las partículas.
- Verlet_part.m: Función que implementa el método de Verlet para actualizar el estado físico de las partículas en cada instante.

METODOLOGÍA Y HALLAZGOS
1. Simetría de movimiento: Se encontró que las partículas en posiciones simétricas respecto a la central presentan el mismo módulo de energía cinética.

2. Patrones predictivos: La simetría observada en sistemas de 5, 9 y 11 partículas permite predecir el comportamiento de sistemas con un número mayor de elementos.
   
3. Uso de interpolación: Para asegurar la precisión, el código utiliza la función interp1 de MATLAB para que cada partícula experimente la fuerza exacta según su posición en el campo eléctrico.

Software: MATLAB.

Instrucciones: Ejecutar el archivo Luz_materia.m para iniciar la simulación completa. Puedes modificar variables como n (modos de propagación) o N_P (número de partículas) para explorar diferentes escenarios.

Autores: Cecilia Mata Alonso y Ema Holinaty Vaquero (Universidad Autónoma de Madrid).
