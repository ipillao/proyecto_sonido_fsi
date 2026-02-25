function [inFile,outFile] = stereo_a_mono(inFile,outFile)

% stereoToMono Convert a stereo .mp3 to mono .mp3
%   stereoToMono(inFile) writes mono file next to input with suffix "_mono.mp3"
%   stereoToMono(inFile, outFile) writes mono to specified outFile.
%
%   Example:
%     stereoToMono('song_stereo.mp3')
%     stereoToMono('song_stereo.mp3','song_mono.mp3')

if nargin < 1 || isempty(inFile)
    error('Input filename required.');
end

% Default output name
if nargin < 2 || isempty(outFile)
    [p,n,~] = fileparts(inFile);    %fileparts devuelve la ruta(p), el nombre del archivo sin extensión(n) y  extensión (~). 
    outFile = fullfile(p, [n '_mono.mp3']);
end

[p,n,~] = fileparts(inFile);

if contains(n, '_mono', 'IgnoreCase', true)
    fprintf('Saltando %s porque ya ha sido pasada a mono\n', inFile);
    return;
end


% Read audio
[audio, fs] = audioread(inFile);

%disp(audio);
disp(size(audio,2));
% audio es matriz

% If already mono, just copy (or rewrite)
if size(audio,2) == 1
    audiowrite(outFile, audio, fs);
    return
end

% Convert to mono by averaging channels (simple mix)
mono = mean(audio, 2);

disp(mono);

% Optional: avoid clipping by normalizing if needed
% maxAbs = max(abs(mono));
% if maxAbs > 1
%     mono = mono / maxAbs;
% end

% Write mono mp3 (use default settings; add 'BitRate' if desired)
audiowrite(outFile, mono, fs);

end