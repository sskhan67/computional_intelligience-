function [ output ] = RunForwardProp( layers, dataPoint)
%RUNFORWARDPROP Summary of this function goes here
%   Detailed explanation goes here

[L,~]=size(layers);
input = dataPoint;

    input=(layers(2,1).w())'*input;

    b=(layers(3,1).w())';
    b=b(1:1:5);
    
   output = round(b*input);

if isnan(output)
    fprintf('here!');
end

end

