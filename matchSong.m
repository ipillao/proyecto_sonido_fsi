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

% Analizar el fragmento

[S, F, T] = spectrogram(fragmento, hann(2048), 1024, 2048, fs, 'yaxis');

S_mag = abs(S); % Pasamos S a magnitud, haciendo el módulo.

S_log = 20*log10(S_mag);

nivel_truncado = max(S_log(:)) - 40; % Calcula el nivel mínimo de amplitud para truncar

S_truncado = S_log;

S_truncado(S_truncado < nivel_truncado) = -Inf;

size_celda = 30; % Tamaño de la celda con que se se compara para sacar picos máximos

picos_f = []; % Inicializar el vector para almacenar índices de frecuencia
picos_t = []; % Inicializar el vector para almacenar índices de tiempo

for i = 1:size_celda:size(S_log,1)
    for j = 1:size_celda:size(S_log,2)

        f_fin = min(i+size_celda-1, size(S_log,1));
        t_fin = min(j+size_celda-1, size(S_log, 2));

        bloque = S_truncado(i:f_fin, j:t_fin);

        [~, idx] = max(bloque(:));

        if all(isinf(bloque(:)))
            continue
        end

        %idx es el índice LINEAL del máximo del bloque 

        [bi, bj] = ind2sub(size(bloque), idx);

        %bi y bj son los índices x y del máximo en ese bloque. Hay que
        %pasarlos a coordenadas globales de S

        %Pasar a coordenadas globales

        picos_f(end+1) = i + bi - 1;
        picos_t(end+1) = j + bj - 1;

    end
end

% Crear las relaciones entre los picos picos

delta_t_min = 0.1; % segundos
delta_t_max = 1.0; % segundos

coincidencias = [];

if isfile("database.mat")
    load(database, "db");
else
    disp("No existe la base de datos "+ database);
    return
end

for k = 1:length(picos_f)

    f_anchor = picos_f(k);
    t_anchor = picos_t(k);
    f1 = floor(F(f_anchor)/30)*30;
    % Buscar picos en la zona objetivo

    for m = k+1:length(picos_f)

        f_target = picos_f(m);
        t_target = picos_t(m);
        f2 = floor(F(f_target)/30)*30;
        dt = T(t_target) - T(t_anchor);
        dt_q = floor(dt*10)/10;
        if dt_q > delta_t_min && dt < delta_t_max
            % Crear hash
            clave = keyHash([f1, f2, dt_q]);

            
            if isKey(db, clave)
                coincidencias = [coincidencias,db(clave)]; % Se guardan los id de canciones que coinciden con los hashes generados

                %t_anchor_match = T(t_anchor); 
                
                % for i = 1:size(apariciones,1)
                %     song_id_db = apariciones(i,1);
                %     t_anchor_db = apariciones(i,2);
                %     %coincidencias = [coincidencias; song_id_db, t_anchor_db];

                % end

            end
        end
    end
end

% Votar por la canción que más se matchea

if isempty(coincidencias)
    disp("No se encontraron coincidencias");
    return;
end
% Contar las coincidencias y determinar la canción más probable

songs_ids = coincidencias(:);
[unique_ids, ~, idx] = unique(songs_ids);
counts = accumarray(idx,1);

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

end



