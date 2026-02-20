%Script que recorre toda la carpeta Songs y pasa las canciones a mono

carpeta = './Songs';

archivos = dir(fullfile(carpeta, "*.mp3"));

if isempty(archivos)
    fprintf('No se encontraron archivos .mp3 en %s\n', carpeta);
    return
end

%Procesar cada archivo


for k = 1:length(archivos)
    inFile = fullfile(archivos(k).folder, archivos(k).name);

    fprintf('Procesando: %s\n', archivos(k).name);

    %Llamar a la función

    stereo_a_mono(inFile);
end

fprintf('Conversión completada\n')

%stereo_a_mono("./Songs/000.mp3", "./Songs/000mono.mp3");