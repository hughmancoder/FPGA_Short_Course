


%% 3. Load Results from VHDL Simulation
% After running the Vivado TB, it should produce 'hilbert_output.txt' 
% with two columns: In-phase (I) and Quadrature (Q)
if isfile('hilbert\hilbert_output.txt')
    data_out = load('hilbert\hilbert_output.txt');
    i_vhdl = data_out(:,1);
    q_vhdl = data_out(:,2);
    
    % Reconstruct the complex signal for baseband analysis
    z_vhdl = i_vhdl + 1j*q_vhdl;
else
    warning('hilbert_output.txt not found! Ensure your testbench writes the output file.');
    return;
end

%% 4. Plotting & Verification
figure(1);

% Time Domain Plot
subplot(3,1,1);
plot(t*1e6, x_adc, 'b'); hold on;
plot(t*1e6, i_vhdl, 'r--');
title('Time Domain: ADC Input vs. VHDL I-Output');
legend('ADC Input', 'VHDL I-Output');
xlabel('Time (\mus)'); ylabel('Amplitude');

% Frequency Domain: Input (Real Signal)
subplot(3,1,2);
X_in = 20*log10(abs(fft(x_adc)));
% Frequency axis for real signal (0 to Fs)
f_axis_real = linspace(0, Fs/1e6, length(x_adc));
plot(f_axis_real, X_in);
title('Input Spectrum (Centered at 75MHz)');
xlabel('Frequency (MHz)'); ylabel('Magnitude (dB)');
grid on;

% Frequency Domain: VHDL Output (Complex/Baseband)
subplot(3,1,3);
X_out = 20*log10(abs(fft(z_vhdl)));
% Frequency axis for complex signal (-Fs/2 to Fs/2)
f_axis_complex = linspace(-Fs/2, Fs/2, length(z_vhdl)) / 1e6;
plot(f_axis_complex, fftshift(X_out));
title('VHDL Hilbert Output Spectrum (Baseband)');
xlabel('Frequency (MHz)'); ylabel('Magnitude (dB)');
grid on;