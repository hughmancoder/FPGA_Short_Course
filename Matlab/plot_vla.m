
x = csvread("csv/hw_ila_vadc.csv", 2, 3);

% --- Configuration ---
Fs = 100e6;           % Replace with your actual sampling frequency (e.g., 100MHz)
L = length(x);        % Length of signal
t = (0:L-1)/Fs;       % Time vector

% 2. Time Domain Plot
figure;
subplot(2,1,1);
plot(t, x);
title('ILA Data: Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% 3. Frequency Domain Plot (FFT)
Y = fft(x);
P2 = abs(Y/L);           % Two-sided spectrum
P1 = P2(1:floor(L/2)+1); % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;      % Frequency vector

subplot(2,1,2);
plot(f, P1); 
title('ILA Data: Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');
grid on;
