% demonstrate window function
clear;
Fs=100e6;
dt=1/Fs;
N=1024;
t=dt*(0:N-1);
Fc=20e6;
A=1000;

x=round(A*sin(2*pi*Fc.*t));
subplot(2,2,1);
plot(x);
xfft=20*log10(abs(fft(x)));
xfft=xfft-max(xfft);
f=linspace(0,Fs/1e6,N);
subplot(2,2,2);
plot(f,xfft);
title('No Window');
xlabel('F(MHz)');ylabel('Mag(dBc)');

subplot(2,2,3);
h=blackmanharris(N)';
y=h.*x;
plot(y)
subplot(2,2,4);
yfft=20*log10(abs(fft(y)));
yfft=yfft-max(yfft);
plot(f,yfft);
title('Window');
xlabel('F(MHz)');ylabel('Mag(dBc)');
