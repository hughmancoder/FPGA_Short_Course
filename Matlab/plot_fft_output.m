% plot fft simulation output
clear;

% Load the data from the text file
% Assuming fft_output.txt has two columns: [Real, Imag]
data = load("fft_output.txt");
x = data(:,1) + 1j*data(:,2); 

% Truncate to the first 1024 points
x = x(1:1024);

% Frequency axis (0 to 100 MHz)
f = linspace(0, 100, 1024);

% --- Subplot 1: IQ Components ---
subplot(3,1,1);
plot(f, real(x), 'r');
hold on;
plot(f, imag(x), 'b');
hold off;
title('FFT IQ Outputs');
xlabel('F(MHz)'); ylabel('IQ');
grid on;

% --- Subplot 2: Linear Magnitude ---
subplot(3,1,2);
plot(f, abs(x), 'b');
title('FFT IQ Magnitude (Linear)');
xlabel('F(MHz)'); ylabel('Mag');
grid on;

% --- Subplot 3: Logarithmic Magnitude (dB) ---
subplot(3,1,3);
plot(f, 20*log10(abs(x)), 'b');
title('FFT IQ Magnitude (dB)');
xlabel('F(MHz)'); ylabel('Mag(dB)');
grid on;
