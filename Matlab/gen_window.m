clear

% Block 1: Generate Window
N = 1024;
x_win = blackmanharris(N);
y = round(32767 * x_win); % Scaled for 16-bit signed integer

% Block 2: Generate Input Signal (Keep 'y' in workspace)
Fs = 100e6;
dt = 1/Fs;
t = dt .* (0 : 8*N-1); 
Fc = 20e6;
A = 1000; 

x_sig = sin(2*pi*Fc .* t);
x_vadc = round(A * x_sig);

% Write to file
fid = fopen("win_input.txt", "wt");
if fid ~= -1
    fprintf(fid, "%d\n", x_vadc(:));
    fclose(fid);
end

gen_win_pkg(y);


