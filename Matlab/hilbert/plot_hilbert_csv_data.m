x = csvread("iladata.csv", 2, 3);
xi = x(:, 2);
xq = x(:, 3);
x_valid = x(:, 4);

xc = xi(x_valid == 1) + j*xq(x_valid == 1);

subplot(2, 1, 1);
plot(real(xc), 'r');
hold on;
plot(imag(xc), 'b');
hold off;

subplot(2, 1, 2);
fftsize = 2048;
XC = 20*log10(abs(fft(xc, fftsize)));
Fs = 50e6;
f = linspace(-Fs/2/1e6, Fs/2/1e6, fftsize);
plot(f, fftshift(XC));
