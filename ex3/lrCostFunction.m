function [J, grad] = lrCostFunction(theta, X, y, lambda)
m = length(y); 
J = 0;
grad = zeros(size(theta));
h=1./(1+exp(-1*X*theta));
fun=y.*log(h)+(1-y).*log(1-h);
J=(sum(fun))/(-m)+(lambda/(2*m))*sum(theta([2:length(theta)],:).^2);
theta=[0;theta([2:end],:)];
%regterminrad = zeros(min(size(X)),1);
%regterminrad(1:end)=(lambda/m)*sum(theta);
%regterminrad(1)=0;
grad= (1/m)*((X)'*(h-y))+ (lambda/m)*theta; 
grad = grad(:);

end

