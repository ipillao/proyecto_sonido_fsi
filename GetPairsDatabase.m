load('database.mat', "db");

claves = keys(db);

for k = 1:20%length(claves)
    %clave = claves{k};
    valor = db(claves(k));
    disp("Clave: ");
    disp(claves(k));

    disp("Valor:");
    disp(valor);
    disp("-----------------------------");
end