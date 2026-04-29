% clear;
% ai=randi([-32768,32767],1000,1);
% aq=randi([-32768,32767],1000,1);
% bi=randi([-32768,32767],1000,1);
% bq=randi([-32768,32767],1000,1);
% 
% fid=fopen("cmult_in_data.txt","wt");
% fprintf(fid,"%d %d %d %d\n",[ai aq bi bq]')
% fclose(fid);
% 


clear;
x=load("cmult_in_data.txt");

a=x(:,1)+j*x(:,2); 
b=x(:,3)+j*x(:,4); 

c=a.*b;

fid=fopen("cmult_out_data.txt","wt");
fprintf(fid,"%d %d\n",[real(c) imag(c)]');
fclose(fid);
