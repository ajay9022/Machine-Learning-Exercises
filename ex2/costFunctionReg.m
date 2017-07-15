function [J, grad] = costFunctionReg(theta, X, y, lambda)
m = length(y); 
J = 0;
grad = zeros(size(theta));
h=1./(1+exp(-1*(X*theta)));
J= sum(y.*log(h)+ (1-y).*log(1-h))/(-m)+ (lambda/(2*m)) *sum(theta([2: length(theta)],:).^2);
grad(1)= (1/m)*sum(h-y);
for i=2:max(size(theta))
grad(i)=(1/m)*(X(:,i))'*(h-y)+(lambda/m)*(theta(i));
end;

end

