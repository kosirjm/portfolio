% Jonathan Kosir
% ECE 425/525
% Homework 8
% This records your voice, 
%--------------------------------------------------------------

% Variables
Hz = 11025;
time = 1;

% Record voice
disp('Start Speaking');
myVoice = audiorecorder(Hz,16,1);
recordblocking(myVoice,1);
disp('end');
myVoice = getaudiodata(myVoice);

% Make a zero mean signal 
myVoice = myVoice - mean(myVoice);

% Find max and multiply entire value to get .95 max x[k]
multiplier=.45/max(abs(myVoice));
myVoice = multiplier * myVoice(:);

% Play voice then pause 
sound(myVoice,Hz);
pause(5);

% Set impulse response response sequence h[k]
impulseResponse =[0.85 zeros(1,5100) 0.55 zeros(1,1600) 0.4 zeros(1,3000) 0.3 zeros(1,2200) 0.2];

% Convolve Signal y[k]
convVoice = conv(myVoice, impulseResponse);

% Get Length
lengthConvVoice = size(convVoice);

% Create zero-mean noise vector
rndNoiseArray = rand(1,lengthConvVoice(1));
multiplier=.1/max(abs(rndNoiseArray));
rndNoiseArray = multiplier * rndNoiseArray(:);
curruptVoice = rndNoiseArray + convVoice;

% Play Currupt then pause
sound(curruptVoice,Hz);
pause(5);

% Find the normalized cross correlation
normalizedVoice = myVoice / std(myVoice);
curruptVoice = curruptVoice / std(curruptVoice);
newVoice = xcorr(curruptVoice,myVoice)/(norm(curruptVoice)*norm(myVoice));

% Plot 
period = 1/Hz;
thisSize = size(newVoice);
xAxis=(length(thisSize)-1)/-2:1:(length(thisSize)-1)/2;
xAxis=xAxis/Hz;
figure
plot(newVoice),ylabel('Amplitude'),xlabel('Period');
title('cross-correlation');

% Write to wav
audiowrite('myVoice.wav',myVoice,Hz);

