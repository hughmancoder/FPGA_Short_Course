% create noisy IQ signal
n = randi([-256 256], 1000, 2);

fid = fopen("FIR/cfir_input.txt", "wt");
fprintf(fid, "%d %d\n", n');
fclose(fid);

