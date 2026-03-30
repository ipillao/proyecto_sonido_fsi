
canciones = ["000","001" ,"010", "025", "045"];
%canciones = string(num2str((0:50)', "%03d"));
probabilidad_acierto = dictionary();

n=20;

for i=1:length(canciones)
    aciertos_ronda=zeros(1, n);
    for k=1:n
    resultado= matchSongRuidoNoDisp('./Songs/'+canciones(i)+'_mono.mp3','database.mat' ,5);
    disp(i);
    disp(k);
    if(resultado == canciones(i))
    aciertos_ronda(k) = 1;
    disp('Acierto');
    end
    end
    prob = mean(aciertos_ronda);
    probabilidad_acierto(canciones(i)) = prob;
end

% Convertir diccionario a vectores
ids = keys(probabilidad_acierto);
probs = values(probabilidad_acierto);



% Gráfica
figure;
bar(probs * 100);   % porcentaje
xticks(1:length(ids));
xticklabels(ids);
xtickangle(90);

ylabel('Porcentaje de acierto (%)');
xlabel('Canción');
title('Probabilidad de acierto por canción');

ylim([0 100]);

grid on;