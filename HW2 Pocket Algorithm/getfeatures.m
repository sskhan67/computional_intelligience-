function [ x,y ] = getfeatures( data )
%getfeatures Computes intensity and symmetry features for digits data
%   INPUT: "Raw" data from usps_modified.mat file
%   OUTPUT: x - matrix of features, y - digit classification (0-9)
%       x(~,1) - Intensity feature
%       x(~,2) - Symmetry feature

[p,e,d]=size(data);         %get data size
data = double(data)/255;    %input data is uint8, convert to double, normalize 
n = e*d;                    %calculate total number of data points

grayscale = zeros(n,p);     %initialize
x = zeros(n,2);
y = zeros(n,1);
c = 0;
for i = 1:d
    for j = 1:e             %loop through all digits
        c = c+1;            %update count
        if i < d            
            y(c)=i;         %classify digits 1-9
        else
            y(c)=0;         %classify digits 0
        end  
        x(c,1)=2*mean(data(:,j,i))-1;   %calc average intensity, set between -1 and 1
        grayscale(c,:)=data(:,j,i)';    %create array of pixel values 
    end
end

w = floor(sqrt(p));
sym = zeros(n,2);
for i=1:n							%calculate symmetry
	full=grayscale(i,:);
	for j=1:w/2
		jsym=w+1-j;
		idxH=(j-1)*w+1:j*w;
		idxV=j:w:(w-1)*w+j;
		idxHsym=(jsym-1)*w+1:jsym*w;
		idxVsym=jsym:w:(w-1)*w+jsym;
		H=full(idxH);Hsym=full(idxHsym);
		V=full(idxV);Vsym=full(idxVsym);
		sym(i,1)=sym(i,1)+mean(abs(H-Hsym));
		sym(i,2)=sym(i,2)+mean(abs(V-Vsym));
	end
end
totsym=mean(sym,2);
x(:,2)=-totsym/2+1;			%Because we actually computed asymmetry

end

