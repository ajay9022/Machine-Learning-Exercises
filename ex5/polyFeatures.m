function [X_poly] = polyFeatures(X, p)
X_poly = zeros(numel(X), p);
Y=X;
for i=2:p
X=[X Y.^i]
end;
X_poly=X;
end

