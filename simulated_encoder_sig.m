function [sig,speed]=simulated_encoder_sig
% Copyright@ vastera@163.com
% General introduction:generate a simulated encoder signal (intantaneous phase) according to the ZhaoMing's paper: 
%% ====================== INPUT ========================
% :          Type:
%                            description:
% ---------------------OPTIONAL:
% optional arg:              Type:
%                            description:
%% ====================== OUTPUT =======================
% sig:          Type:a double vector
%                           sig description:The generated signal
%% =====================================================
%%%%%%%%%%%%%%%%%%%%%% Initial parameters %%%%%%%%%%%%%%%%%%
f0=5;% rotation frequency of gear shaft
v0=300;% rotation speed in rpm 60f0
A0=20;% amplitude of speed jitter in rpm
Ng=20;% number of gear teeth
sigma0=0.05;
%%%%%%%%%%%%%%%%%%%%%% time-varying phases %%%%%%%%%%%%%%%%%
Duration=1;% signal duration
fs=2e4;t=1/fs:1/fs:Duration;
jitter0=A0*sin(2*pi*Ng*f0*t);
delay=round(0.1*Ng*f0)/(Ng*f0);% the shifted initial phases
current_p=delay;% the current pointer denoting the location of pointer
T=1/f0;% the whole period of rotation
Td=false(1,length(t));% defination domain of the instantaneous jitter
while current_p<=Duration% the next pointer doesn't exceed the end of duration
    Td(t>=current_p & t<=min(current_p+1/f0/Ng,Duration))=true;% the rectangle piecewise location
    current_p=current_p+T;
end
jitter=jitter0.*Td;
speed=jitter+v0;
sig0=cumtrapz(speed)/fs*2*pi;
%%%%%%%%%%%%%%%%%%%%%% Add noise %%%%%%%%%%%%%%%%%%%%%%%%%%%
sig=sig0+randn(size(t))*sigma0;
end