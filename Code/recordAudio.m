function r = recordAudio(sampleRate, bitRate, recordLength)
r = audiorecorder(sampleRate,bitRate, 1);
disp('Recording');
recordblocking(r, recordLength);
end


