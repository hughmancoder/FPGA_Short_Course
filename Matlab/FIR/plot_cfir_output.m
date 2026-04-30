Fs = 100e6;
x = load("cfir_output.txt");
x = x * [1; j];
X = 20 * log10(abs(fft(x)));
f = linspace(-50, 50, length(x));
plot(f, fftshift(X));