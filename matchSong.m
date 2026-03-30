function cancion_encontrada = matchSong(fileSong,database, Ftime)
%matchSong: Hace el shazam de la canción por parámetro comparado con la
%base de datos. Se hace empezando en un t al azar durante Ftime.
% Ftime = duración del fragmento


% archivo = dir(fileSong);
% fileSong = fullfile(archivo.folder, archivo.name);


[audio, fs] = audioread(fileSong);

%Elegir el fragmento a comparar aleatoriamente

maxRand = length(audio) - Ftime*fs; %el valor máximo de inicio que puede tocar es el inicio del último fragmento completo que puede haber
inicio = randi([1, maxRand]);

fragmento = audio(inicio: inicio+(Ftime*fs)-1,1);


if isfile("database.mat")
    load(database, "db");
else
    disp("No existe la base de datos "+ database);
    return
end

tic;

claves = analizadorPicos(fragmento,fs);

mascara = isKey(db,claves);
claves = claves(mascara);
coincidencias = db(claves);



% Votar por la canción que más se matchea

if isempty(coincidencias)
    disp("No se encontraron coincidencias");
    return;
end
% Contar las coincidencias y determinar la canción más probable

songs_ids = coincidencias(:);
[unique_ids, ~, idx] = unique(songs_ids);
counts = accumarray(idx,1);

tiempoTranscurrido = toc;

%Coincidencias agrupadas por canción

disp("-- Coincidencias por canción --");
for i = 1:length(unique_ids)
    fprintf('ID: %s --> %0.f\n', unique_ids(i), counts(i)); 
end

% Determinar la canción con más coincidencias (ganadora)

[~, pos] = max(counts);
song_ganadora = unique_ids(pos);
cancion_encontrada = song_ganadora;

disp("Canción identificada: "+ string(song_ganadora));

fprintf('Tiempo transcurrido en analizar el fragmento y buscar coincidencias: %.4f s\n', tiempoTranscurrido);

end



