Fs=100e6;
dt=1/Fs;

% load file
x=load("text_files/dds_output.txt");

% convert to complex data
x=x*[1;j];

% plot time domain
subplot(2,1,1);
t=dt*(0:length(x)-1);
t_us=t*1e6;
plot(t_us,real(x),'r');
hold on;
plot(t_us,imag(x),'b');
hold off;
xlabel('T(us)');ylabel('IQ');

% plot freq domain
subplot(2,1,2);
f=linspace(-Fs/2/1e6,Fs/2/1e6,length(x));
X=20*log10(abs(fft(x)));
plot(f,fftshift(X));
xlabel('F(MHz)');ylabel('Mag(dB)');
