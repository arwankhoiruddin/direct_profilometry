close all
clear
clc

x = linspace(0, pi, 9);
y = sin(x);
n_noise = round(length(x)/2);
y(n_noise) = y(n_noise) - 1.5;

xx = linspace(0, pi, length(x)*10);

pp = spline(x, y);
yy = ppval(pp, xx);

figure, hold on
set(gca, 'LineWidth', 1.5, 'FontSize', 14);
plot(x, y, '--', 'LineWidth', 1);
plot(xx, yy, '-*', 'LineWidth', 1);
xlabel('x');
ylabel('y');
legend('original signal','spline fitted function');