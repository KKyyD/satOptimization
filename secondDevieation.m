clear
clc
 % Given parameters
    F = [5, 10, 15]; % Replace F1, F2, F3 with actual values
    b = 0.01; % Replace b_value with the actual value

    % Initial guess (ensure they are feasible w.r.t. the individual constraints)
    x0 = [0.1, 0.1, 0.1]; 

    % Objective function
    objective = @(x) sum((F - log(1 + x)).^2);

    % Linear inequality constraint for sum(xi) < b
    A = [1, 1, 1];
    B = b;

    % No equality constraints
    Aeq = [];
    Beq = [];

    % Lower bound - no specific lower bounds are mentioned, so we'll use 0 assuming xi >= 0
    lb = [0, 0, 0];

    % Upper bound - each xi < Fi
    ub = F; % Directly use F as the upper bound for x

    % No nonlinear constraints
    nonlincon = [];

    % Solve the problem
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
    [x_opt, fval] = fmincon(objective, x0, A, B, Aeq, Beq, lb, ub, nonlincon, options);

    % Display the optimal values
    fprintf('The optimal values are:\n');
    disp(x_opt);
    fprintf('The minimum value of the objective function is: %f\n', fval);