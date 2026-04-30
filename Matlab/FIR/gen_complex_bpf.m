h = firpm(16, [0 0.1 0.25 1], [1 1 0 0], [1 10]);
fftsize = 1024;
H = 20*log10(abs(fft(h, fftsize)));
f = linspace(-50, 50, fftsize);
subplot(2,1,1);
plot(f, fftshift(H));
title('Lowpass');

subplot(2,1,2);
hmod = h.*exp(j*0.5*pi*(0:length(h)-1));
HMOD = 20*log10(abs(fft(hmod, fftsize)));
plot(f, fftshift(HMOD));
title('Bandpass');
xlabel('F(MHz)'); ylabel('Mag(dB)');

hreal = round(16384*real(hmod));
himag = round(16384*imag(hmod));
hcplx = hreal + j.*himag;
figure;
plot(hreal, 'rx-');
hold on;
plot(himag, 'bo-');
hold off;
title('Complex Coefficients');
legend('real', 'imag');

% write_coe_file(hreal, "hreal.coe");
% write_coe_file(himag, "himag.coe");

figure;
n = randi([-32767 32767], 1, 1000);
y = filter(hcplx, 1, n);
Y = 20*log10(abs(fft(y, fftsize)));
Y = Y - max(Y);
plot(f, fftshift(Y));
xlabel('F(MHz)'); ylabel('Mag(dB)');
