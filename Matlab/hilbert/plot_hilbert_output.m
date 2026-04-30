x=load("hilbert_output.txt");
x=x*[1;j];
Fs=100e6;

subplot(2,1,1);
plot(real(x),'r');
hold on;
plot(imag(x),'b');
hold off;
title("Hilbert Output");
xlabel('Sample #');ylabel('IQ');

subplot(2,1,2);
X=20*log10(abs(fft(x)));
f=linspace(-Fs/4/1e6,Fs/4/1e6,length(x));
plot(f,fftshift(X));
title("Hilbert Spectrum");
xlabel('F(MHz)');ylabel('Mag(dB)');
