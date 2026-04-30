% generate virtual ADC data
Fs=100e6;
dt=1/Fs;
N=1024;
t=dt.*(0:N-1);
Fc=5e6;
A=1000;

x=round(A*sin(2*pi*Fc.*t));

subplot(2,1,1);
plot(x);
xlabel('sample');ylabel('ADC code');

f=linspace(0,Fs/1e6,N);
subplot(2,1,2);
X=20*log10(abs(fft(x,N)));
plot(f,X);
xlabel('F(MHz)');ylabel('Mag(dB)');


