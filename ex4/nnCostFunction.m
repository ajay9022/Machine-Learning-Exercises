function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
A2=zeros(m,hidden_layer_size);
A2=[ones(m,1) A2];
A3=zeros(m, num_labels);
X=[ones(m,1) X];
for i=2:(hidden_layer_size+1),
A2(:,i)=1./(1+exp(-X*(Theta1((i-1),:))'));
end;


for i=1: num_labels,
  A3(:,i)=1./(1+exp(-A2*(Theta2(i,:))'));
end;

y_matrix=eye(num_labels)(y,:);
Jsum=zeros(1, num_labels);

for k=1:num_labels,
Jsum(:,k)=sum(y_matrix(:,k).*log(A3(:,k))+(1-y_matrix(:,k)).*log(1-A3(:,k)))/(-m);
end;
theta1=Theta1.^2;
theta2=Theta2.^2;
theta1sum=sum(sum(theta1,1),2)-sum(theta1,1)(1,1);
theta2sum=sum(sum(theta2,1),2)-sum(theta2)(1,1);
J=sum(Jsum,2)+ (lambda/(2*m))*( theta1sum  +  theta2sum );
%disp(J);

delta3=zeros(m,num_labels);
delta3=A3-y_matrix;
delta2=zeros(m,hidden_layer_size);
delta2=(delta3*Theta2(:,2:end)).*(A2(:,2:size(A2,2)).*(1-A2)(:,2:size(A2,2)));
Bigdelta1=zeros(hidden_layer_size,size(X,2));
Bigdelta2=zeros(num_labels,(hidden_layer_size+1));
Bigdelta1=(delta2)'*X;		%disp(Bigdelta1);
Bigdelta2=(delta3)'*A2;	% disp(Bigdelta2);
Theta1_grad=zeros(size(Bigdelta1));
Theta2_grad=zeros(size(Bigdelta2));
Theta1_grad=Bigdelta1/m;
Theta2_grad=Bigdelta2/m;

Theta1_grad(:,2:size(X,2))= Theta1_grad(:,2:size(X,2))+(lambda/m)*Theta1(:,2:size(X,2)); 
Theta2_grad(:,2:(hidden_layer_size+1))= Theta2_grad(:,2:(hidden_layer_size+1))+(lambda/m)*Theta2(:,2:(hidden_layer_size+1));














% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];
%disp(grad);

end

