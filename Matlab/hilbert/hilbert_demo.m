% hilbert transform demo
Fs=100e6;
dt=1/Fs;
N=2048;
t=dt.*(0:N-1);
A=1000;

% create a chirp signal from 70-80MHz
% this is in the 2nd Nyquist Zone
f1=70e6;
f2=80e6;
x=round(A*chirp(t,f1,t(end),f2,'linear'));

% plot results
figure(1);

% Time Domain Plot
subplot(2,1,1);
plot(t*1e6, x); % Multiplied by 1e6 to show microseconds
title('ADC Data');
xlabel('Time (\mus)');
ylabel('Amplitude');

% Frequency Domain Plot
subplot(2,1,2);
X=20*log10(abs(fft(x)));
f=linspace(0,Fs/1e6,length(x));
plot(f,X);
title('Spectrum');
xlabel('Frequency (MHz)');
ylabel('Magnitude (dB)');
