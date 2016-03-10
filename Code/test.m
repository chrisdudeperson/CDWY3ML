close all;
clear all;

sampleRate=44100;
sweepLength=4;
noOfSweeps=2;

% Generate input sweeps and plot 3d graph
for i=1:noOfSweeps
    input(:,i) = generateSweep(sampleRate,sweepLength,(i*(1/noOfSweeps)));
    fftInput(:,i) = fft(input(:,i));
    [inputMatrix(:,i),f] = plotFFT(fftInput(:,i),sampleRate);
end

mesh(inputMatrix);

% Play through each sweep and record response
for i=1:noOfSweeps
    player = audioplayer(input(:,i), 44100);
    play(player);
    beep;
    currentLength = length(input)/sampleRate;
    outputObj(i) = recordAudio(44100,24, currentLength);
end

% for i=1:noOfSweeps
%     play(outputObj(i));
%     pause(sweepLength);
% end

% Obtain audio data from recording and plot 3D graph
for i=1:noOfSweeps
    output(:,i) = getaudiodata(outputObj(i));
    fftOutput(:,i) = fft(output(:,i));
    [outputMatrix(:,i),f] = plotFFT(fftOutput(:,i),sampleRate);
end

figure 
mesh(outputMatrix);

% Calculate transfer function and plot 3D graph
for i=1:noOfSweeps
    tfFFT(:,i) = transferFunction(input(:,i),output(:,i));
    [tfMatrix(:,i),f] = plotFFT(tfFFT(:,i),sampleRate);
end

figure 
mesh(tfMatrix);