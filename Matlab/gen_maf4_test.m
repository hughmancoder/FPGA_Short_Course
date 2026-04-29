x = randi([-32768, 32767], 1, 1000);

% Write the signal to the text file
fid = fopen('text_files/maf4_input.txt', 'wt');
fprintf(fid, '%d\n', x);
fclose(fid);

fprintf('File "maf4_input.txt" has been created.\n');

% filter coefficients
h=[0.25 0.25 0.25 0.25];

% generate 1000 random 16b integers
x=randi([-32768, 32767],1,1000);

% write to a file
fid=fopen("text_files/maf4_input.txt","wt");
fprintf(fid,"%d\n",x);
fclose(fid);

% apply the filter
y=floor(filter(h,1,x));

% write output file
fid=fopen("text_files/maf4_output.txt","wt");
fprintf(fid,"%d\n",y);
fclose(fid);
