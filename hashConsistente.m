function h64 = hashConsistente(data)
%Hash determinista

    % 1. Convertir a string para evitar variaciones de bits en decimales
    msg = sprintf('%.10f', data); 
    
    % 2. Algoritmo estándar
    md = java.security.MessageDigest.getInstance('SHA-256');
    hashBytes = md.digest(uint8(msg));
    
    % 3. Extraer los primeros 8 bytes para formar un uint64. Aunque
    % trunquemos el hash a 8 bytes es muy poco improbable que coincidan 2
    % hashes
    % Convertimos de int8 (Java) a uint8 (MATLAB) y luego a uint64
    primeros8Bytes = uint8(hashBytes(1:8));
    h64 = typecast(primeros8Bytes, 'uint64');
end
