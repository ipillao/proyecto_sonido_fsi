function claves = analizadorPicos(audio,fs)
%Función que analiza los picos y crea el hash. Devuelve el diccionario con
%los hashes de la canción


%S: matriz que contiene los niveles de energía en cada ventana, 
% W: matriz que contiene las frecuencias que corresponden en la tabla S 
% T: matriz que contiene los tiempos en los que suceden las ventanas de la

[S, F, T] = spectrogram(audio, hann(2048), 1024, 2048, fs, 'yaxis');

% Matriz S es la matriz de amplitud compleja del espectrograma. S son números complejos

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

claves=[];


for k = 1:length(picos_f)

    f_anchor = picos_f(k);
    t_anchor = picos_t(k);

    % Buscar picos en la zona objetivo

    for m = k+1:length(picos_f)

        f_target = picos_f(m);
        t_target = picos_t(m);

        dt = T(t_target) - T(t_anchor);

        if dt > delta_t_min && dt < delta_t_max
            % Crear hash
            claves = [claves,hashConsistente([round(F(f_anchor)), round(F(f_target)), round(dt,2)])]; %SHA-256

        end
    end
end
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