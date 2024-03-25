function [Population] = UpdateArc(Population,arc,N,p)
    Population = [Population,arc];
    [FrontNo,~] = NDSort(Population.objs,N);
    %     Next = FrontNo < MaxFNo;
    ND_Next = find(FrontNo <= 1);
    %     Local
    T = p*N;
    %     B = pdist2(Population.decs,Population.decs);
    t_dec = Population.decs;
    t_dec = (t_dec-min(t_dec,[],1))./(max(t_dec,[],1) - min(t_dec,[],1));
    B = pdist2(t_dec,t_dec);
    [~,B] = sort(B,2);
    B = B(:,1:T);
    Fitness = CalFitness(Population.objs,Population.decs,B,T);
    NFND = find(Fitness<=1);
    ND_Next = union(ND_Next,NFND);
    Del =[];
    if length(ND_Next) > N
        Del = Truncation(Population(ND_Next).decs,length(ND_Next) - N);
    end
    ND_Next(Del) = [];
    Population = Population(ND_Next);
end

function Del = Truncation(PopDecs,K)
    % Select part of the solutions by truncation
    %% Truncation
    Z = min(PopDecs,[],1);
    Zmax = max(PopDecs,[],1);
    [N, ~] = size(PopDecs);
    popdec = (PopDecs-repmat(Z,N,1))./repmat(Zmax-Z,N,1);
    Distance = pdist2(popdec,popdec,"euclidean");
    Distance(logical(eye(length(Distance)))) = inf;
    Del = false(1,size(popdec,1));
    while sum(Del) < K
        Remain   = find(~Del);
        Temp     = sort(Distance(Remain,Remain),2);
        [~,Rank] = sortrows(Temp);
        Del(Remain(Rank(1))) = true;
    end
end