%{
Create 1024 test cases
• 16-bit data, signed
• Use the randi function to generate
uniformly distributed random
inputs
• Two columns for input A and B data
• Write to a text file
• Note we have to transpose the data
matrix to get the data into the proper
columns
%}

% generate multiplier test inputs
ntests=1024;
nbits=16; % maval: 32767 
minval=-1*(2^(nbits-1)-1);
maxval=(2^(nbits-1)-1); 

% data has cols for a and b data i
data = randi([minval maxval],ntests,2)
display(data)

% write to a file
fid=fopen("mult_input.txt","wt");
fprintf(fid,"%d %d\n",data');
fclose(fid);


% generate mult expected outputs
x=load("mult_input.txt");

% perform the multiply between cols
y=x(:,1).*x(:,2);

% write output file
fid=fopen("mult_output.txt","wt");
fprintf(fid,"%d\n",y);
fclose(fid);



