close all
clear
clc

nc = 255;
y = 1:nc;
for i=1:nc
    I(i,:) = y;
end

% figure, imshow(I,[]);
imwrite(uint8(I), 'pattern.png', 'png');