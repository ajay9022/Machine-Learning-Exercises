function [J, grad] = costFunction(theta, X, y)

m = length(y);
J = 0;
grad = zeros(size(theta));
h=1./(1+exp(-1*(X*theta)));
J=sum((y.*log(h)+ (1-y).*log(1-h)))/(-m);
for i=1:max(size(theta))
grad(i)=(1/m)*(X(:,i))'*(h-y);
end;






% =============================================================

end

