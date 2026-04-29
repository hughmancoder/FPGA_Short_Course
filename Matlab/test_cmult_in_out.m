clear;
clc;

% 1. Load the input data (ai aq bi bq)
if ~exist('cmult_in_data.txt', 'file')
    error('Input file cmult_in_data.txt not found.');
end
in_data = load("cmult_in_data.txt");

% 2. Load the output data produced by VHDL (real_out imag_out)
if ~exist('cmult_out_data.txt', 'file')
    error('Output file cmult_out_data.txt not found. Run VHDL simulation first.');
end
vhdl_out = readmatrix("cmult_out_data.txt");

% 3. Extract components and perform golden multiplication
ai = in_data(:,1);
aq = in_data(:,2);
bi = in_data(:,3);
bq = in_data(:,4);

% intermediate products (for internal hardware tracing)
p1 = ai .* bi; % ac
p2 = aq .* bq; % bd
p3 = ai .* bq; % ad
p4 = aq .* bi; % bc

% Calculate Golden Results
golden_real = p1 - p2;
golden_imag = p3 + p4;

% 4. Compare VHDL results against Golden model
vhdl_real = vhdl_out(:,1);
vhdl_imag = vhdl_out(:,2);

% Check for differences
diff_real = golden_real - vhdl_real;
diff_imag = golden_imag - vhdl_imag;

% 5. Reporting
total_errors = sum(diff_real ~= 0) + sum(diff_imag ~= 0);

if total_errors == 0
    fprintf('✅ SUCCESS: VHDL output matches MATLAB golden model perfectly.\n');
else
    fprintf('❌ FAILURE: Found %d mismatches between VHDL and MATLAB.\n', total_errors);
    
    % Find the first mismatch index
    error_idx = find(diff_real ~= 0 | diff_imag ~= 0, 1);
    fprintf('First error at sample index: %d\n', error_idx);
    fprintf('Expected: %d + j%d\n', golden_real(error_idx), golden_imag(error_idx));
    fprintf('Received: %d + j%d\n', vhdl_real(error_idx), vhdl_imag(error_idx));
end