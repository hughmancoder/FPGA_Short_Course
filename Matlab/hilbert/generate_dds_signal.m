Fs=100e6;
dt=1/Fs;
N=2048;
t=dt.*(0:N-1);

% generate DDS signal at 25MHz
Fc=25e6; % 25 MHz carreir frequency
A=32767; % max value for 16 bitw = 2^15 - 1
dds=round(A*exp(1j*2*pi*Fc.*t)); % complex exponentional has real and imaginary part

% create a chirp signal from 70-80MHz
% this is in the 2nd Nyquist Zone
f1=70e6;
f2=80e6;
x=round(A*chirp(t,f1,t(end),f2,'linear'));


% plot DDS signal
figure(2);
dds_spect=10*log10(abs(fft(dds)));
dds_spect(dds_spect<0)=0;

% length(x) to N so it doesn't error out
f=linspace(0, Fs/1e6, N); 

plot(f, dds_spect);
title('DDS Signal Spectrum');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');

% Mixing code
y=dds.*x;

% plot mixer output
figure(3);
mix_spect=10*log10(abs(fft(y)));
mix_spect(mix_spect<0)=0;
f=linspace(0,Fs/1e6,length(x));
plot(f,mix_spect);
title('Mixer Signal Spectrum');

% filter the output
h=[0.25 0.25 0.25 0.25];
z=filter(h,1,y);
figure(4);
subplot(2,1,1);
plot(real(z),'r');
hold on;
plot(imag(z),'b');
hold off;
xlabel('Sample #');ylabel('IQ');
title('Time Domain');
subplot(2,1,2);
Z=20*log10(abs(fft(z)));
f=linspace(-Fs/2/1e6,Fs/2/1e6,length(z));
plot(f,fftshift(Z));
xlabel('F(MHz)');ylabel('Mag(dB)');
title('Frequency Domain');
