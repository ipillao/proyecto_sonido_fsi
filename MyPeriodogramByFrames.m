function outputPeriodogram = MyPeriodogramByFrames(signal,Nfft,f_s,windowType)
 % Window
    windowSignal = window(windowType,Nfft);
    windowedSignal = signal(1:Nfft) .* windowSignal;    
% Cropped signal
    %x = signal(1:Nfft);
    X = fft(windowedSignal, Nfft);
    outputPeriodogram = (1/(Nfft*f_s)) * abs(X(1:Nfft/2+1)).^2;
end 