function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;
%yval=[1;0;0;1;1];
%pval=[0.1;0.2;0.3;0.4;0.5];
stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

m=size(yval,1);
%display(size(yval));
vec=zeros(m,1);
%display(size(vec));
%display("yval");
%display(yval(:));
%%display(vec);

vec=(pval < epsilon);
  
tp=sum((vec==1) & (yval==1));
fp=sum((vec==1) & (yval==0));
tn=sum((vec==0) & (yval==1));
fn=sum((vec==0) & (yval==0));
%display(tp);
%display(fp);
%display(fn);
prec=tp/(tp+fp);
rec=tp/(tp+tn);
den=(prec+rec);
num=(2*prec*rec);
F1=num/den;







    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end
%display("vec");
%display(vec);
display("bestEpsilon");
display(bestEpsilon);
display(bestF1);

end
