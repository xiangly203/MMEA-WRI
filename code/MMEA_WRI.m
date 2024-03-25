classdef MMEA_WRI < ALGORITHM
    % <multi><multimodal> <real/binary/permutation>
    % p --- 0.3 --- Parameter for quality of the local Pareto front
    methods
        function main(Algorithm,Problem)
            %% Generate random population
            p = Algorithm.ParameterSet(0.3);
            Population = Problem.Initialization();
            Population = Environmental_Selection_b(Population,Problem.N,Problem.FE,Problem.maxFE,p);
            Archive = UpdateArc(Population,[],Problem.N,p);
            %% Optimization
            while Algorithm.NotTerminated(Archive)
                CrowdDis = CalCrowding(Population.decs,p*Problem.N);
                MatingPool = TournamentSelection(2,Problem.N,1./CrowdDis);
                Offspring  = OperatorGA(Problem,Population(MatingPool));
                Population = Environmental_Selection_b([Population,Offspring],Problem.N,Problem.FE,Problem.maxFE,p);
                Archive = UpdateArc(Archive,Offspring,Problem.N,p);
                len_Pop = length(Archive)
            end
        end
    end
end