¡ATENCIÓN!
¡El proyecto incluye en la memoria un manual de uso de las funciones!

El repositorio incluye un archivo "database.mat" que contiene el diccionario con los hashes de las canciones incluídas en ./Songs.
Si se desea crear una base de datos nueva con las canciones contenidas en Songs, puede hacerse ejecutando el script GenerarDb.m, que procesa todos los
archivos de audio presentes en la carpeta Songs y genera un nuevo "database.mat".

Solo se deben de reconocer canciones en mono, por tanto, la ruta al archivo debe ser siempre './Songs/[num_cancion]_mono.mp3'.
Empezando num_cancion en "000" y terminando en "050".


1. RECONOCER UN FRAGMENTO DE TIEMPO FTIME E INICIO ALEATORIO
    matchSong(fileSong,database, Ftime)

Ejemplo de uso: matchSong('./Songs/006_mono.mp3','database.mat' ,10);

Ver ejemplo1.m

2. RECONOCER UN FRAGMENTO DE TIEMPO FTIME, INICIO ALEATORIO Y AÑADIENDO RUIDO
    matchSongRuido(fileSong,database, Ftime)

Ejemplo de uso: matchSongRuido('./Songs/010_mono.mp3','database.mat' ,20);

Ver ejemplo2.m

3. RECONOCER UN FRAGMENTO DE TIEMPO FTIME E INICIO DETERMINADO
    matchSongNoRandom(fileSong,database,inicio, Ftime)

Ejemplo de uso: matchSongNoRandom('./Songs/010_mono.mp3','database.mat' ,3, 12);

Ver ejemplo3.m