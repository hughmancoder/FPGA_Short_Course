clear
Fs=100e6

x = load('win_output.txt')

f=linspace(0,Fs/1e6, length(x));
xfft=20*log10(abs(fft(x)));
xfft=xfft-max(xfft);
plot(f,xfft);
xlabel('F(MHz)');ylabel('Mag(dBc)')