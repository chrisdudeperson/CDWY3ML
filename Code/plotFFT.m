function [x,f] =plotFFT(fftInput, sampleRate)

   % N = length(input);
N=40000;
X_mags = abs(fftInput);
bin_vals = [20 : N-1];
fax_Hz = bin_vals*sampleRate/N;
N_2 = ceil(N/2);

f = fax_Hz(1:N_2)
x = 10*log10(X_mags(1:N_2));
% plot(fax_Hz(1:N_2), 10*log10(X_mags(1:N_2)))
% xlabel('Frequency (Hz)')
% ylabel('Magnitude (dB)');
% title('Transfer Function Frequency Plot');
% axis tight
% X_mags = abs(fftInput);

end