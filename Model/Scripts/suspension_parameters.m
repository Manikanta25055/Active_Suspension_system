%% Suspension System Parameters
% Masses
ms = 300;      % Sprung mass (kg) - vehicle body
mus = 40;      % Unsprung mass (kg) - wheel assembly

% Suspension parameters
ks = 18000;    % Suspension spring stiffness (N/m)
cs = 1200;     % Suspension damping coefficient (N*s/m)

% Tire parameters
kt = 195000;   % Tire stiffness (N/m)
ct = 75;       % Tire damping coefficient (N*s/m)

% Controller gains (initial values, you'll tune these)
Kp = 5000;     % Proportional gain
Ki = 100;      % Integral gain
Kd = 2000;     % Derivative gain

% Simulation parameters
Ts = 0.001;    % Sample time for discrete blocks (if needed)