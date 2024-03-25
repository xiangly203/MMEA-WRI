function Fitness = CalFitness(PopObj,PopDecs,B,T)
    % Calculate the fitness of each solution

    N = size(PopObj,1);
    Dominate = false(N);
    for i = 1:N
        for j=1:T
            k = any(PopObj(i,:)<PopObj(B(i,j),:)) - any(PopObj(i,:)>PopObj(B(i,j),:));
            if k == 1
                Dominate(i,B(i,j)) = true;
            elseif k == -1
                Dominate(B(i,j),i) = true;
            end
        end
    end

    %% Calculate S(i)
    S = sum(Dominate,2);

    %% Calculate R(i)
    R = zeros(1,N);
    for i = 1 : N
        R(i) = sum(S(Dominate(:,i)));
    end

    lrd = CalCrowding(PopDecs,T);
    %% Calculate the fitnesses

    Fitness = R + 1 - lrd';
end