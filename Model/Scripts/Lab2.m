wn = 2;
zeta = 0.54;
num_a = wn^2;
den_a = [1 2*zeta*wn wn^2];
sys_a = tf(num_a, den_a);

figure;
step(sys_a);
title('Step Response - Case (a)');
grid on;

% Time domain specifications
S = stepinfo(sys_a)

% Case (b): Higher-order system
num_b = 25 * [1 0.4];
den_b = conv([1 16], [1 0.16 256]);
sys_b = tf(num_b, den_b);

figure;
step(sys_b);
title('Step Response - Case (b)');
grid on;

S_b = stepinfo(sys_b)