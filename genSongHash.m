function genSongHash(fileSong,database)
%genSongHash
%   Guarda los hashes de las relaciones de la canción que se le pase por
%   parámetro en la colección clave-valor que se le pase por parámetro.


%Generar espectrograma de la canción
[~, nombre, ~] = fileparts(fileSong);   % nombre = "003_mono"
partes = split(nombre, "_");
codigo_cancion = partes{1};   % "003"

id_cancion = codigo_cancion;

[audio, fs] = audioread(fileSong); %"./Songs/003_mono.mp3"

if isfile(database)
    load(database, "db");
else
    db = dictionary();
end

claves = analizadorPicos(audio,fs);

db(claves)=id_cancion;

save(database, "db");
disp("Guardado correctamente: "+id_cancion);


% imagesc(T, F, S_log);
% axis xy;
% colormap jet;
% hold on;
% clim([min(S_log(:)) max(S_log(:))]);  % fija los colores
% 
% plot(T(picos_t), F(picos_f), '.', 'Color', [1 1 1], 'MarkerSize', 7);
% 
% title("Espectrograma con puntos por encima del umbral");
% xlabel("Tiempo (s)");
% ylabel("Frecuencia (Hz)");

end