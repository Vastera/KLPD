[phase,speed]=simulated_encoder_sig;
fs=2e4;t=1/fs:1/fs:1;
figure('Name','Generated Speed')
plot(t,speed);ylim([270,330]);
figure('Name','Generated phase')
plot(t,phase);
%%%% test KLPD %%%%%%%%%%%
M=1:400;
[M_opt,kurt]=KLPD(phase,fs,max(M));
figure('Name','Kurtosis for different filter length')
plot(M*2+1,kurt);

%%%%%%%%%%% use the optimal length %%%%%%%%%%%%%
figure('Name','fltered speed')
v=LPD(phase,M_opt,fs);
plot(v);