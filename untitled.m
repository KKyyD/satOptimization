clear
clc

kingstonRain2 = readmatrix("kingstionRain2.csv");
data = kingstonRain2;
% zeroindex = (kingstonRain2 == 0);
%  data(zeroindex) = 1e-6;
% data = data + 10;

% Step 2: Fit a Gamma Distribution to the data
pd = fitdist(data, 'Exponential');

% Step 3: Plot the histogram of the data
figure;
histogram(data, 'Normalization', 'pdf'); % Plot normalized histogram
hold on; % Keep the histogram on the plot for the next plot

% Step 4: Plot the Gamma PDF
x_values = 0:0.1:max(data); % Generate x values for the PDF plot, adjust range as needed
pdf_values = pdf(pd, x_values); % Calculate the PDF values using the fitted distribution
plot(x_values, pdf_values, 'LineWidth', 2); % Plot the PDF

legend('Data Histogram', 'exponential PDF Fit'); % Add a legend
title('Exponential Distribution Fit to Data'); % Add a title
xlabel('Rain Rate over 2021 [mm/hr]'); % Label the x-axis
ylabel('Probability Density'); % Label the y-axis

hold off; % Release the plot
