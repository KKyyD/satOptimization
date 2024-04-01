clear
clc
 % Given parameters
F = [900, 1024, 850].*1000000; %%%%%%TRAFFIC DEMANDS
p = 0:0.1:500; 
att = [ 0.555, 0.535, 0.53];
w = 50000000;
N0 = 1e-12;
c1 = zeros(1, length(p));
c2 = zeros(1, length(p));
c3 = zeros(1, length(p));
counter = 1;
for b = 0:0.1:500

% Initial guess (ensure they are feasible w.r.t. the individual constraints)
x0 = [0.1, 0.1, 0.1]; 
% Objective function
objective = @(x) sum((F - w.*log(1 + (x)/(N0*w))).^2);
% Linear inequality constraint for sum(xi) < b
A = [1, 1, 1];
B = b;
% No equality constraints
Aeq = [];
Beq = [];
% Lower bound - no specific lower bounds are mentioned, so we'll use 0 assuming xi >= 0
lb = [0, 0, 0];
% Upper bound - each xi < Fi
ub = w.*N0.*(2.^(F./w) - 1); % Directly use F as the upper bound for x
% No nonlinear constraints
nonlincon = [];
% Solve the problem
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[x_opt, fval] = fmincon(objective, x0, A, B, Aeq, Beq, lb, ub, nonlincon, options);
% Display the optimal values
fprintf('The optimal values are:\n');
disp(x_opt);
fprintf('The minimum value of the objective function is: %f\n', fval);
c1(1, counter) = 1.79*x_opt(1, 1);
c2(1, counter) = 1.8*x_opt(1, 2);
c3(1, counter) = 1.87*x_opt(1, 3);
counter = counter + 1;
end

figure();
plot(p, c1); % Plot for the first beam
hold on;
plot(p, c2); % Plot for the second beam
plot(p, c3); % Plot for the third beam

% Adding title
title('power allocated to each beam vs. total power');

% Adding legend
legend('Beam 1 power', 'Beam 2 power', 'Beam 3 power');

% Adding x and y axis labels
xlabel('total Power');
ylabel('power');



p1 = w.*log(1 + c1/(N0*w));
p2 = w.*log(1 + c2/(N0*w));
p3 = w.*log(1 + c3/(N0*w));



figure();
plot(p, p1); % Plot for the first beam
hold on;
plot(p, p2); % Plot for the second beam
plot(p, p3); % Plot for the third beam

title('capacity of each beam vs. total power');

% Adding legend
legend('Beam 1', 'Beam 2', 'Beam 3');

% Adding x and y axis labels
xlabel('total Power');
ylabel('capacity');


%%%% hand overs for leo satellites