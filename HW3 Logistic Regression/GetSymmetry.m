% Vector with each average symmetry value in the image
function symmetry = GetSymmetry(D)

[r, ~] = size(D); 

% get pixel of example 1
pixel = D; 

% convert pixels with range from -1 to 1
data = 2*(double(pixel)/255)-1; 
Matrix = reshape(data, [16,16]);

FlipV = fliplr(Matrix); % Flip the images vertically.
VS = Matrix - FlipV;    % Original image minus vertically flipped image.
VS = -1.*abs(VS);       % Negative of the difference between the original 
                        % and vertically flipped image.
                        %
sumOfVS = sum(VS(:));   % Sum of vertically symmetry
avgVS = sumOfVS(1)/r;   % Average v. symmetry = sum/256

FlipH = flipud(Matrix); % Flip the images horizontally.
HS = Matrix - FlipH;    % Original image minus horizontally flipped image.
HS = -1.*abs(HS);       % Negative of the difference between the original 
                        % and horizontally flipped image.
                        %
sumOfHS = sum(HS(:));   % Sum of horizontally symmetry.
avgHS = sumOfHS/r;      % Average h. symmetry = sum/256

symmetry = (avgHS+avgVS)/2; % average symmetry = (avg h. symmetry + avg v. symmetry)/2
%         Total_symmetry(j, 1) = symmetry; % put average symmetry into symmetry vector
%     end
    return
end