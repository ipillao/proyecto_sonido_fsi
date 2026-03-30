function [inFile,outFile] = stereo_a_mono(inFile,outFile)

% stereo_a_mo Convierte de estéreo .mp3 a mono .mp3
%   stereo_a_mono(inFile) la salida va a ser [archivo_estéreo]+"_mono.mp3"
%   stereo_a_mono(inFile, outFile) saca la salida mono en la ruta outFile especificada.
%
%   Ejemplo:
%     stereo_a_mono('000.mp3')
%     stereo_a_mono('000.mp3','000_mono.mp3')

if nargin < 1 || isempty(inFile)
    error('Input filename required.');
end

% Nombre de salida de archivo por defecto
if nargin < 2 || isempty(outFile)
    [p,n,~] = fileparts(inFile);    %fileparts devuelve la ruta(p), el nombre del archivo sin extensión(n) y  extensión (~). 
    outFile = fullfile(p, [n '_mono.mp3']);
end

[p,n,~] = fileparts(inFile);

if contains(n, '_mono', 'IgnoreCase', true)
    fprintf('Saltando %s porque ya ha sido pasada a mono\n', inFile);
    return;
end


% Lee el audio
[audio, fs] = audioread(inFile);

%disp(audio);
disp(size(audio,2));
% audio es matriz

% Si el original está en mono, se copia
if size(audio,2) == 1
    audiowrite(outFile, audio, fs);
    return
end

% Convierte a mono mezclando los dos canales (media de los dos canales)
mono = mean(audio, 2);

disp(mono);



% Escribe el audio mono
audiowrite(outFile, mono, fs);

end