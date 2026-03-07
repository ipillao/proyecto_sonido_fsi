function [processedSignal, processedMatrix] = FramePeriodogram(signal,Nframe, Noverlap, windowType, f_s)
% Length of signal to be processed
Nsignal = length(signal);
% Processed signal buffer
processedSignal = [];
% Number of frames to be processed (rough estimation)
salto = Nframe - Noverlap;
%totalNframes = floor(Nsignal/ Nframe);
totalNframes = floor((Nsignal - Nframe)/ salto) + 1;
 % Iterate all frames
for frameNumber = 1:totalNframes
        % Frame starts here
        frameBegin = (frameNumber-1)*salto + 1;
         % Frame ends here
        frameEnd = frameBegin + Nframe - 1;
        % Signal contained in frame
        frameSignal = signal(frameBegin : frameEnd);
         % Here comes the frame processing
        %processedFrame = frameSignal;
        processedFrame = MyPeriodogramByFrames(frameSignal,Nframe,f_s,windowType);
        % Processed frame is added to the processed signal buffer
        processedSignal = [processedSignal processedFrame];        
        %disp(['Frame number ' num2str(frameNumber) '.....   ' num2str(frameSignal')]);
end
processedMatrix = processedSignal;
% Welch's method
processedSignal = sum(processedSignal, 2) / totalNframes;
end