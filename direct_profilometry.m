close all
clear
clc

nc = 255;
d = 100;
l = 80;
obj_height = 20;

std_noise = 4.5;
filtered = 1;
nave = 3;

az = -49; % azimuth
el = 28; % elevation

showfig = 1;

x = linspace(-nc/2, nc/2, nc);

% generate parabola surface
z = zeros(nc, nc);
for i=1:nc
    for j=1:nc
        z(i,j) = -((x(i)^2) + (x(j)^2));
    end
end

mid = (max(max(z)) - min(min(z))) / 3;
z = z + mid;
z = (z / max(max(z))) * obj_height;

for i=1:nc
    for j=1:nc
        if z(i,j) < 0
            z(i,j) = 0;
        end
    end
end

if showfig
    figure, surf(z); shading interp; colormap(gray)
    set(gca, 'FontSize', 14, 'XTick', 0:50:250, 'YTick', 0:50:250, 'ZTick', -20:10:20);
    axis([0 255 0 255 -10 30]);
    view(az, el);
    xlabel('x');
    ylabel('y');
    zlabel('height (mm)');
end

% generate reference pattern
ref = zeros(nc,nc);
for i=1:nc
    for j=1:nc
        ref(i,j) = j;
    end
end

% add AWGN
ref = ref + std_noise*randn(nc,nc);

if showfig
    figure, imshow(ref,[]); 
end

% generate deformed pattern
def = zeros(nc,nc);
u = zeros(nc, nc);

for i=1:nc
    for j=1:nc
        u(i,j) = (d*z(i,j)) / (l - z(i,j));
        def(i,j) = j + u(i,j);
    end
end

% add AWGN
def = def + std_noise*randn(nc,nc);

if showfig
    figure, imshow(def, []); 
end

% filter first
if filtered
    h = fspecial('average', [nave nave]);

    def = imfilter(def, h, 'replicate');
    ref = imfilter(ref, h, 'replicate');

    def = medfilt2(def, [nave nave]);
    ref = medfilt2(ref, [nave nave]);
end

% reconstruct using linear profilometry
tic
fx = def - ref;
toc
rec = (fx * l) ./ (d + fx);

dif = rec - z;

disp(['standard deviation of error: ' num2str(std(dif(:)))]);

if showfig
    figure, surf(rec); shading interp; colormap(gray);
    set(gca, 'FontSize', 14, 'XTick', 0:50:250, 'YTick', 0:50:250, 'ZTick', -20:10:20);
    axis([0 255 0 255 -10 30]);
    view(az, el);
    xlabel('x');
    ylabel('y');
    zlabel('height (mm)');

    figure, surf(rec - z); shading interp; colormap(gray);
    set(gca, 'FontSize', 14, 'XTick', 0:50:250, 'YTick', 0:50:250, 'ZTick', -20:10:20);
    axis([0 255 0 255 -10 30]);
    view(az, el);
    xlabel('x');
    ylabel('y');
    zlabel('height (mm)');
end