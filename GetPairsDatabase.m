load('database.mat', "db");

claves = keys(db);

for k = 1:20%length(claves)
    %clave = claves{k};
    valor = db(claves(k));
    disp("Clave: ");
    disp(clave);

    disp("Valor:");
    disp(valor);
    disp("-----------------------------");
end