clear;

% Define the filename
filename = "cordic_iladata.csv";

% Set up import options to handle the mix of types and the header
opts = detectImportOptions(filename);
opts.VariableNamingRule = 'preserve';
% The data starts on row 3 (after the labels and radix rows)
opts.DataLines = [3, Inf]; 

% Read the file as a table
data_table = readtable(filename, opts);

% 1. Convert w_fft_data_q from Hex to Numeric
% It is currently column 5 based on your header
q_hex = data_table{:, 5};
w_fft_data_q = cellfun(@(x) double(typecast(uint32(hex2dec(x)), 'int32')), q_hex);

% 2. Extract w_mag (Column 6) which is already signed/numeric
w_mag = data_table{:, 6};

% 3. Extract w_fft_data_i (Column 7) which is signed/numeric
w_fft_data_i = data_table{:, 7};

% Handle the data windowing
% Based on image_831283.png logic: start at sample 33 for 1024 samples
% If your current CSV is shorter, we'll just take the whole range available
if height(data_table) >= 1056
    plot_mag = w_mag(33:33+1023);
else
    plot_mag = w_mag;
end

% Create frequency/sample axis
f = linspace(0, 100, length(plot_mag));

% Plot Linear Magnitude
subplot(2, 1, 1);
plot(f, plot_mag, 'b');
title('CORDIC Output (Linear)');
xlabel('Sample #'); ylabel('Mag');

% Plot Decibel Magnitude
subplot(2, 1, 2);
mag_db = 20 * log10(abs(plot_mag) + 1e-12); 
plot(f, mag_db, 'b');
title('CORDIC Output (dB)');
xlabel('Sample #'); ylabel('Mag(dB)');

% clear;
% 
% x = csvread("cordic_iladata.csv", 2, 1);
% w_mag = x(:, 5);
% w_mag = w_mag(33 : 33 + 1023);
% f = linspace(0, 100, 1024);
% 
% subplot(2, 1, 1);
% plot(f, w_mag, 'b');
% title('CORDIC Output');
% xlabel('Sample #'); ylabel('Mag');
% 
% subplot(2, 1, 2);
% mag_db = 20 * log10(w_mag);
% plot(f, mag_db, 'b');
% title('CORDIC Output');
% xlabel('Sample #'); ylabel('Mag(dB)');