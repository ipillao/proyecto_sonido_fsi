function MySpectrogram(processedMatrix,Nframe,Noverlap,f_s)

%Spectrogram
time_axis = 1/f_s * ( Nframe/2 : (Nframe-Noverlap) : length(processedMatrix(1,:))*(Nframe-Noverlap) )';
freq_axis = (0: f_s/Nframe: f_s/Nframe*(Nframe/2))';
figure; imagesc(time_axis,freq_axis,10*log10(processedMatrix)); colormap(flipud(gray));colorbar; set(gca,'YDir','normal')
figure; imagesc(time_axis,freq_axis,10*log10(processedMatrix)); colormap(jet);colorbar; set(gca,'YDir','normal')
xlabel('time [s]')
ylabel('freq [Hz]')
shg