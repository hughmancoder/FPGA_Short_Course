clear;
Fs=100e6;
dt=1/Fs;
N=1024;
t=dt.*(0:8*N-1); % multiply by 8
Fc=20e6;

% real fft
x=sin(2*pi*Fc.*t);
X=fft(x);
Xmag_dB=20*log10(abs(X));
% f=linspace(0,Fs/1e6,N);
f = linspace(0, Fs/1e6, length(Xmag_dB)); 
plot(f,Xmag_dB);
title('Real Spectrum, Fs=100MHz, Fc=20MHz');
xlabel('f(MHz)');ylabel('Mag(dB)');

% optionally plotting sin
figure;
plot(t(1:100)*1e6, x(1:100)); % Time in microseconds
title('Sine Wave Time Domain (Zoomed)');
xlabel('Time (\mus)');
ylabel('Amplitude');
grid on;


A = 1000; 
x_vadc = round(A * x);

fid = fopen("fft_input.txt", "wt");
    fprintf(fid, "%d\n", x_vadc);
fclose(fid);

% write to input fft file
gen_vadc_pkg(x_vadc)