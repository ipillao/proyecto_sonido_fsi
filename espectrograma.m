%Generar espectrograma de la canción

[audio, fs] = audioread("./Songs/000_mono.mp3");

spectrogram(audio, hann(8192), 4096, 8192, fs, 'yaxis');

%[S, W, T] = spectrogram(audio, hann(2048), 1536, 2048, fs, 'yaxis');
%colorbar;

%S: matriz que contiene los niveles de energía en cada ventana, 
% W: matriz que contiene las frecuencias que corresponden en la tabla S 
% T: matriz que contiene los tiempos en los que suceden las ventanas de la
% matriz S.

% Nfft = 64;
% Nsolape=Nfft/2;
% windowType = 'hann';
% %f_s = 19e3;
% [welchOutput, welchMatrix] = FramePeriodogram(audio, Nfft, Nsolape, windowType, fs);
% MySpectrogram(welchMatrix,Nfft,Nsolape,f_s);

%disp(W);

[S, F, T] = spectrogram(audio, hann(2048), 1024, 2048, fs, 'yaxis');

% Matriz S es la matriz de amplitud compleja del espectrograma. S son números complejos

S_mag = abs(S); % Pasamos S a magnitud, haciendo el módulo.

S_log = 20*log10(S_mag); %+eps

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

        [max_val, idx] = max(bloque(:));

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


%[filaPicos, colPicos] = find(S_log > nivel_truncado);

imagesc(T, F, S_log);
axis xy;
colormap jet;
hold on;
clim([min(S_log(:)) max(S_log(:))]);  % fija los colores

plot(T(picos_t), F(picos_f), '.', 'Color', [1 1 1], 'MarkerSize', 7);

title("Espectrograma con puntos por encima del umbral");
xlabel("Tiempo (s)");
ylabel("Frecuencia (Hz)");