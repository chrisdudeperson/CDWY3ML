input_filename='white';
output_filename='white_hp_double';

tf_filename=strcat(input_filename,'_refiltered');

% Read in audio files
[input,Fs] = audioread(strcat(input_filename,'.wav'));
[output,Fs] = audioread(strcat(output_filename,'.wav'));
[new_input,Fs] = audioread(strcat(input_filename,'.wav'));

% Converting file to mono
input(:,1) = [];
output(:,1) = [];
new_input(:,1) = [];


% FFTs
input_fft = fft(input);
output_fft = fft(output);
new_input_fft = fft(new_input);


% Removing 0's to avoid divison by 0 errors
for i = 1:length(input_fft)
    if real(input_fft(i))==0       
        input_fft(i)=complex(0.00001,imag(input_fft(i)));
    end
    if imag(input_fft(i))==0
        input_fft(i)=complex(real(input_fft(i)),0.00001);
    end
end
for i = 1:length(output_fft)
    if real(output_fft(i))==0       
        output_fft(i)=complex(0.00001,imag(output_fft(i)));
    end
    if imag(output_fft(i))==0
        output_fft(i)=complex(real(output_fft(i)),0.00001);
    end
end

% Transfer function FFT calculation
transfer_fft = output_fft./input_fft


% N = length(input);
N=40000;
X_mags = abs(transfer_fft);
bin_vals = [20 : N-1];
fax_Hz = bin_vals*Fs/N;
N_2 = ceil(N/2);



refiltered_fft = transfer_fft.*new_input_fft
refiltered = ifft(refiltered_fft);

% transferFunction = ifft(transfer_fft);
% refiltered = convn(new_input, transferFunction);
% refiltered_fft = fft(refiltered);

% transfer_fft = medfilt1(abs(transfer_fft));
% input_fft = medfilt1(abs(input_fft));
% output_fft = medfilt1(abs(output_fft));
% refiltered_fft = medfilt1(abs(refiltered_fft));



subplot(2,2,3)
plot(fax_Hz(1:N_2), 10*log10(X_mags(1:N_2)))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)');
title('Transfer Function Frequency Plot');
axis tight

X_mags = abs(input_fft);
subplot(2,2,1)
plot(fax_Hz(1:N_2), 10*log10(X_mags(1:N_2)))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)');
title('Input Frequency Plot');
axis tight

X_mags = abs(output_fft);
subplot(2,2,2)
plot(fax_Hz(1:N_2), 10*log10(X_mags(1:N_2)))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)');
title('Output Frequency Plot');
axis tight

X_mags = abs(refiltered_fft);
subplot(2,2,4)
plot(fax_Hz(1:N_2), 10*log10(X_mags(1:N_2)))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)');
title('New Input Frequency Plot');
axis tight



% Save new file to wav
audiowrite(strcat(tf_filename,'.wav'),refiltered,Fs);

% Playing audio
disp('Playing Audio');
% pl0 = audioplayer(input, Fs);
% play(pl0)
% pause(20);
% pl1 = audioplayer(output, Fs);
% play(pl1);
% pause(20);
% pl3 = audioplayer(new_input, Fs);
% play(pl3);
% pause(8);
% pl2 = audioplayer(refiltered, Fs);
% play(pl2)
% pause(20);