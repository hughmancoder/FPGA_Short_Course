% constants
Fs=100e6;

% four point moving average filter
% • y[n]=0.25*(x[n]+x[n-1]+x[n-2]+x[n-3]

h=[0.25 0.25 0.25 0.25];

% spectral analysis
fftsize=1024;
H=20*log10(abs(fft(h,fftsize)));
f=linspace(-Fs/2/1e6,Fs/2/1e6,fftsize);
plot(f,fftshift(H));
grid on;grid minor;
xlabel('F(MHz)');ylabel('Mag(dB)');
title('Simple Filter');
