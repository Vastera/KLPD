function [M_opt,kurt]=KLPD(phase,fs,varargin)
% Copyright@ vastera@163.com
% General introduction:iterate to get the optimal filter length of local polynomial differentiator (LPD)
%% ====================== INPUT ========================
% phase:          Type:vector
%                           input_args description: input instantaneous phases
% phase:          Type:an integer
%                           input_args description: sampling frequency
% ---------------------OPTIONAL:
% optional arg:  L_max            Type:an odd number (default=401)
%                            description: the max length of iteration
%% ====================== OUTPUT =======================
% M_opt:          Type: an integer
%                           output_arg description: the optimal length of filter:L=2*M+1
% kurt:           Type: vector
%                       kurt description: all kurtosis result from the iteration of LPD for different L
%% =====================================================
M_max=401;% the maximum of iterated filter length
if nargin>=3
    M_max=varargin{1};
end
kurt=zeros(1,M_max);
for m=1:M_max
    kurt(m)=kurtosis(LPD(phase,m,fs));
end
[~,M_opt]=max(kurt);
end