% generate mult expected outputs
x=load("accum_input.txt");

% perform accumulation
y=cumsum(x);

% plot output
plot(y,'b');

% write output file
fid=fopen("accum_output.txt","wt");
fprintf(fid,"%d\n",y);
fclose(fid);
