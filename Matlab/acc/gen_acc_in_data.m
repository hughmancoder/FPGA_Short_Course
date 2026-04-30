% generate multiplier test inputs
ntests=1024;
nbits=16;
minval=-1*(2^(nbits-1)-1);
maxval=(2^(nbits-1)-1);

% data has cols for a and b data inputs
data = randi([minval maxval],ntests,2);

% write to a file
fid=fopen("accum_input.txt","wt");
fprintf(fid,"%d\n",data');
fclose(fid);
