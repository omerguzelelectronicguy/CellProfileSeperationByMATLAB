clear; close all; clc;
load('FeaturesandLabels.mat');
X=features(:,[1 2]);
y=features(:,3);
valvalue=100;% this and three od lower lines are updated to see test and training error.
Xval=X(1:valvalue,:);       yval=y(1:valvalue,:);
X=X(valvalue+1:end,:);      y=y(valvalue+1:end,:);
input_layer_size  = 2;  
hidden_layer_size = 2;   
num_labels = 2;          

m = size(X, 1);
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

options = optimset('MaxIter', 2000);
lambda = 1;
costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, num_labels, X, y, lambda);
[nn_params, ttt] = fmincg(costFunction, initial_nn_params, options);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));
 
pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == (y+1))) * 100);


pred = predict(Theta1, Theta2, Xval);
fprintf('\nValidation Set Accuracy: %f\n', mean(double(pred == (yval+1))) * 100);
