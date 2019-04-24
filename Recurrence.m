function cnt = Recurrence(Xmat,Xvecs,radius)
%======inputs=====
% Xmat: whole data points in phase space (numD * num of points)
% Xvecs: locations of center of sphere, there can be many centers 
%                                       (numD * num of centers)
% redius: radius of sphere

%=====output=====
% cnt = number of points that is close to all centers simultaneously


len = size(Xmat,2);
cnt = 0;

for i=1:len
    for j=1:size(Xvecs,2)
        tmp(j) = norm(Xmat(:,i)-Xvecs(:,j)) < radius;
        plus = min(tmp);    % =1 only when every centers are nearby
    end
    cnt = cnt + plus;
end

end
    