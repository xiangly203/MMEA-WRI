function [CrowdDis]=CalCrowding(PopDecs,p)
    N = size(PopDecs,1);
    Z = min(PopDecs,[],1);
    Zmax = max(PopDecs,[],1);
    popdec = (PopDecs-repmat(Z,N,1))./repmat(Zmax-Z,N,1);
    Distance = pdist2(popdec,popdec,'euclidean');
    Distance(logical(eye(length(Distance)))) = inf;
    [dis,I] = sort(Distance,2);
    p = floor(sqrt(N));
    I = I(:,1:p);
    kdistance = dis(:,p);
    D = dis(:,1:p);
    for i=1:N
        for j = 1:p
            D(i,j) = max(dis(i,j),kdistance(I(i,p)));
        end
    end
    CrowdDis = sum(D,2)./p;
end