function [ w ] = linreg( x,y,lamda )
%linreg linear regression with uniform regularizer
%   INPUTS:
%   x - input data vector matrix (no leading ones)
%   y - classification tags
%   lambda - regularization parameter
%
%   OUTPUTS:
%   w - weight vector
%
%   Notes: lambda = 0 no regularization
%   larger lambda = more regularization

[n,d] = size(x);            %get number of data and dimensionality

x = [ones(n,1),x];          %add x0 of 1's
t = x'*x + lamda*eye(d+1);  %calculate invertable matrix
w = (t\x')*y;               %perform linear regression

end