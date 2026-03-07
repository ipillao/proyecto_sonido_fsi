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