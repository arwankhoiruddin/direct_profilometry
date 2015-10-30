close all
clear
clc

nc = 255;
d = 100;
l = 80;
obj_height = 20;

std_noise = 4.5;
filtered = 1;

showfig = 1;

az = -49; % azimuth
el = 28; % elevation

nave = 3;

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

def = zeros(nc, nc);
for i=1:nc
    for j=1:nc
        u(i,j) = (d*z(i,j)) / (l - z(i,j));
        def(i,j) = j + u(i,j);
    end
end

ref = zeros(nc,nc);
x = 1:255;
for i=1:nc
    ref(i,:) = x;
end

ref = ref + std_noise*randn(nc, nc);
def = def + std_noise*randn(nc, nc);

% filter first
if filtered
    h = fspecial('average', [nave nave]);

    def = imfilter(def, h, 'replicate');
    ref = imfilter(ref, h, 'replicate');

    def = medfilt2(def, [nave nave]);
    ref = medfilt2(ref, [nave nave]);
end

h = zeros(nc,nc);

tic
for j=1:nc
    sigref = ref(j,:);
    sigdef = def(j,:);
    ext_ref = [1 findextrema(sigref) nc];
    u = zeros(nc, 1);

    for i=1:size(ext_ref,2)-1
        x = ext_ref(i):ext_ref(i+1);
        y = sigref(ext_ref(i):ext_ref(i+1));
        pp = spline(x,y);
        xx = sigdef(ext_ref(i):ext_ref(i+1));
        u(ext_ref(i):ext_ref(i+1)) = ppval(pp, xx) - x;
    end
    h(j,:) = (l*u) ./ (d + u);
end
toc
dif = h-z;

mx = max(max(dif(:)), max(h(:)));
mn = min(min(dif(:)), min(h(:)));

disp(['standard deviation of error: ' num2str(std(dif(:)))]);

if showfig
    figure, surf(h); shading interp
    set(gca, 'FontSize', 14, 'XTick', 0:50:250, 'YTick', 0:50:250, 'ZTick', linspace(mn, mx, 5));
    axis([0 255 0 255 mn mx]);
    view(az, el);
    colormap(gray);
    xlabel('x');
    ylabel('y');
    zlabel('height (mm)');
    
    figure, surf(dif); shading interp
    set(gca, 'FontSize', 14, 'XTick', 0:50:250, 'YTick', 0:50:250, 'ZTick', linspace(mn, mx, 5));
    axis([0 255 0 255 mn mx]);
    view(az, el);
    colormap(gray);
    xlabel('x');
    ylabel('y');
    zlabel('height (mm)');
end