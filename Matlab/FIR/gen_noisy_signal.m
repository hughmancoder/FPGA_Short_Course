% create noisy IQ signal
clear;
Fs=100e6;
dt=1/Fs;
Ps=1000;
SNRdB=10;
SNR=10^(SNRdB/10);
Pn=Ps/SNR;
Fc=2e6;
N=1000;
t=dt.*(0:N-1);
x=Ps*exp(j*2*pi*Fc.*t);
ni=Pn*randn(1,length(x));
nq=Pn*randn(1,length(x));
x=round(x+ni+j*nq);

% plot noisy signals
figure(1);
subplot(2,1,1);
plot(real(x(1:100)),'r');
hold on;
plot(imag(x(1:100)),'b');
hold off;
title('Noisy Signal');
xlabel('Sample #');ylabel('IQ');

subplot(2,1,2);
X=20*log10(abs(fft(x)));
X=X-max(X);
f=linspace(-Fs/2/1e6,Fs/2/1e6,length(x));
plot(f,fftshift(X));
title('Noisy Signal Spectrum');
xlabel('F(MHz)');ylabel('Mag(dB)');

% apply filter and plot results
figure(2);
hint=gen_lpf();
x_filt=filter(hint,1,x);
subplot(2,1,1);
plot(real(x_filt(1:100)),'r');
hold on;
plot(imag(x_filt(1:100)),'b');
hold off;
title('Filtered Signal');
xlabel('Sample #');ylabel('IQ');
subplot(2,1,2);
Xfilt=20*log10(abs(fft(x_filt)));
Xfilt=Xfilt-max(Xfilt);
f=linspace(-Fs/2/1e6,Fs/2/1e6,length(x_filt));
plot(f,fftshift(Xfilt));
title('Filtered Signal Spectrum');
xlabel('F(MHz)');ylabel('Mag(dB)');
