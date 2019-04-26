function [Rmat, Dmat] = Recurrence2(Xmat, eps)

%the euclidean distance matrix "D", and thresholds this matrix by "epsilon" to obtain the recurrence matrix (R)

Dmat = zeros(size(Xmat,2),size(Xmat,2));
Rmat = zeros(size(Xmat,2),size(Xmat,2));
for i=1:size(Xmat,2)
    for j=1:size(Xmat,2)
        Dmat(i,j) = norm(Xmat(:,i)-Xmat(:,j)) ;
        Rmat(i,j) = Dmat(i,j) < eps;
    end
end
