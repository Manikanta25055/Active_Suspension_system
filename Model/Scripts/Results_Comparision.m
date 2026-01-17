%% Bode Plot Comparison: Passive vs Active

clc; clear; close all;

% Load parameters
suspension_parameters;

%% Build Transfer Functions
s = tf('s');

% Passive System
num_passive = conv([cs, ks], [ct, kt]);
den_passive = [ms*mus, (ms*ct + mus*cs), (ms*kt + mus*ks + cs*ct), ...
               (cs*kt + ct*ks), ks*kt];
H_passive = tf(num_passive, den_passive);

% PID Controller
N = 100;
C_PID = Kp + Ki/s + (Kd*N*s)/(s + N);

% Active System
H_velocity = s;
H_active = feedback(H_passive, C_PID * H_velocity);

%% Bode Plot Comparison
figure('Position', [100, 100, 1200, 800]);

% Frequency range
w = logspace(-2, 3, 1000);

% Get frequency responses
[mag_p, phase_p] = bode(H_passive, w);
[mag_a, phase_a] = bode(H_active, w);

mag_p = squeeze(mag_p);
phase_p = squeeze(phase_p);
mag_a = squeeze(mag_a);
phase_a = squeeze(phase_a);

% Magnitude plot
subplot(2,1,1);
semilogx(w, 20*log10(mag_p), 'b-', 'LineWidth', 2.5);
hold on;
semilogx(w, 20*log10(mag_a), 'r-', 'LineWidth', 2.5);
grid on;
ylabel('Magnitude (dB)', 'FontSize', 13);
title('Bode Diagram - Magnitude', 'FontSize', 14, 'FontWeight', 'bold');
legend('Passive System', 'Active System', 'Location', 'best', 'FontSize', 12);
xlim([w(1) w(end)]);

% Phase plot
subplot(2,1,2);
semilogx(w, phase_p, 'b-', 'LineWidth', 2.5);
hold on;
semilogx(w, phase_a, 'r-', 'LineWidth', 2.5);
grid on;
xlabel('Frequency (rad/s)', 'FontSize', 13);
ylabel('Phase (degrees)', 'FontSize', 13);
title('Bode Diagram - Phase', 'FontSize', 14, 'FontWeight', 'bold');
legend('Passive System', 'Active System', 'Location', 'best', 'FontSize', 12);
xlim([w(1) w(end)]);

sgtitle('Passive vs Active Suspension System - Bode Plot Comparison', ...
        'FontSize', 16, 'FontWeight', 'bold');

%% Display Results
[peak_p, idx_p] = max(mag_p);
[peak_a, idx_a] = max(mag_a);

fprintf('\n========== BODE PLOT COMPARISON ==========\n\n');
fprintf('PASSIVE SYSTEM:\n');
fprintf('  Peak Magnitude: %.2f dB at %.2f Hz\n', ...
        20*log10(peak_p), w(idx_p)/(2*pi));

fprintf('\nACTIVE SYSTEM:\n');
fprintf('  Peak Magnitude: %.2f dB at %.2f Hz\n', ...
        20*log10(peak_a), w(idx_a)/(2*pi));

fprintf('\nIMPROVEMENT:\n');
fprintf('  Peak Reduction: %.2f dB\n', ...
        20*log10(peak_p) - 20*log10(peak_a));

fprintf('\n==========================================\n');