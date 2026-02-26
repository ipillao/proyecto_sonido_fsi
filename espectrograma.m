%Generar espectrograma de la canción

[audio, fs] = audioread("./Songs/000_mono.mp3");

spectrogram(audio, 256, 200, 256, fs, 'yaxis');

[S, W, T] = spectrogram(audio, 256, 200, 256, fs, 'yaxis');
colorbar;

%S: matriz que contiene los niveles de energía en cada ventana, 
% W: matriz que contiene las frecuencias que corresponden en la tabla S 
% T: matriz que contiene los tiempos en los que suceden las ventanas de la
% matriz S.

disp(W);