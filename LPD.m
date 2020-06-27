function [v,h]=LPD(phase,M,fs)
% Copyright@ vastera@163.com
% General introduction:Local polynomial differentiator
%% ====================== INPUT ========================
% phase:      Type: vector
%                           description: input instantanous phases from encoder
% M:          Type:An integer
%                           M description:the half length of the desigend filter L=2*M+1
% fs:          Type:an integer
%                        fs description: sampling frequency
% ---------------------OPTIONAL:
% optional arg:              Type:
%                            description:
%% ====================== OUTPUT =======================
% v:          Type:vector with the same length of input signal
%                           v description:estimated instantaneous speed £¨unit=Hz£©
%% =====================================================
N=5;% order of local polynomial
L=2*M+1;% total filter length
dt=1/fs;% time interval
T=zeros(L,N+1);% the matrix of polynomial coefficients
for n=0:1:N
    for l=-M:M
        T(M+1+l,n+1)=(l*dt)^n;
    end
end
T1=pinv(T);% the pseudo inverse of matrix T
h=flip(T1(2,:));% the filter is the second column of the matrix
v=conv(phase,h,'valid')/2/pi;
% v=conv(phase,h,'same')/2/pi;
end