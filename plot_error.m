close all
clear
clc

x = 0:0.5:4.5;
ersifa = [3.116e-15 461.8337 10340.5398 9715.0799 5027.923 1722.8831 9040.7281 16525.1079 2067.357 31523.5495];
erlp = [3.116e-15 0.50363 1.0162 1.5125 2.0369 2.5423 3.0533 3.5654 4.0986 4.6133];

% figure, hold on
% plot(x, log10(ersifa), '-o', 'LineWidth', 1.5);
% plot(x, log10(erlp), '-*', 'LineWidth', 1.5);
% xlabel('standard deviation of noise');
% ylabel('log of the standard deviation of error');
% legend('error in SIFA','error in LP');

ersifa2 = [3.116e-15 0.15435 0.15435 0.85758 0.92288 25.7399 949.6272 400.2898 11959.2609 235.7852];
erlp2 = [3.116e-15 0.15435 0.29874 0.44621 0.55931 0.69254 0.7897 0.9224 1.10437 1.156];

% figure, hold on
% plot(x, log10(ersifa2), '-o', 'LineWidth', 1.5);
% plot(x, log10(erlp2), '-*', 'LineWidth', 1.5);
% xlabel('standard deviation of noise');
% ylabel('log of the standard deviation of error');
% legend('error in SIFA','error in LP');

lwid = 2;

figure, hold on
set(gca, 'FontSize', 14);
xlabel('standard deviation of noise (pixels)');
ylabel('log of the standard deviation of error (mm)');
plot(x, log10(ersifa), '-o', 'LineWidth', lwid);
plot(x, log10(erlp), '-*', 'LineWidth', lwid);
plot(x, log10(ersifa2), ':s', 'LineWidth', lwid);
plot(x, log10(erlp2), '--d', 'LineWidth', lwid);
legend('error in SIFA (filtered)', 'error in LP (filtered)', 'error in SIFA (unfiltered)', 'error in LP (unfiltered)');