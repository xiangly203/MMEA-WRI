function [Population] = Environmental_Selection_b(Population,N,~,~,p)
    T = p*N;
    t_dec = Population.decs;
    t_dec = (t_dec-min(t_dec,[],1))./(max(t_dec,[],1) - min(t_dec,[],1));
    B = pdist2(t_dec,t_dec,"minkowski",2);
    [~,B] = sort(B,2);
    B = B(:,1:T);
    Fitness = CalFitness(Population.objs,Population.decs,B,T);
    [~,I] = sort(Fitness);
    Population = Population(I(1:N));
end
