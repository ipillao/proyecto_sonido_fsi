%Script que recorre todas las canciones y genera la base de datos con todas
%las canciones

archivos = dir("./Songs/*_mono.mp3");

for k = 1:length(archivos)

    fileSong = fullfile(archivos(k).folder, archivos(k).name);

    genSongHash(fileSong, "database.mat");

end