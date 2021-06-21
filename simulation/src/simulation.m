%%% simulation.m ---
%%
%% Filename: simulation.m
%% Commentary: Matlab Implementation of the SBC in "Order release optimization
%% for time-dependent and stochastic manufacturing systems"
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Code:

function costs = simulation(lmd)
% fprintf('simulation in')
    constants;                          % load constants
    config;                             % laod config


    % set information for constraints as global
    clearvars cost costs I IAvg W WAvg;
    global costs
    global IAvg
    global OAvg
    global WAvg

    W(1:R,1:T)=0;                       % expected number of orders in the system
                                        % (in queue or at the server) at end of
                                        % period
    I(1:R,1:T)=0;                       % expected final product inventory at
                                        % the end of period
    O(1:R,1:T)=0;                       % output

    cost(1:R,1:T)=0;                    % costs
    IAvg(1:T)=0;                        % set zeros
    WAvg(1:T)=0;                        % set zeros
    OAvg(1:T)=0;


    % generate incoming orders
    genDemMem = memoize(@generateDemand);
    simMem = memoize(@sbc_sim);

    [Arr,Proc]=genDemMem(lmd);
    for r=1:R
        % simulate
        [ISim,WSim,OSim,costSim] = simMem(r,Arr(r),T,mu,D,g,h);
        I(r,:) = ISim;
        O(r,:) = OSim;
        W(r,:) = WSim;
        cost(r,:) = costSim;
    end

    % IAvg=1/R*sum(I,1);                  % mean over sum of fist dim
    % WAvg=1/R*sum(W,1);                  % mean over sum of fist dim
    % % fprintf('lmd: %f -> %f \n', lmd, IAvg)
    % costs=mean(sum(cost,2))
    costT(1:T)=0;
    for i=1:T
        IAvgTmp=0;
        OAvgTmp=0;
        WAvgTmp=0;
        costTmp=0;
        for r=1:R
            IAvgTmp = IAvgTmp + I(r,i);
            WAvgTmp = WAvgTmp + W(r,i);
            OAvgTmp = OAvgTmp + O(r,i);
            costTmp = costTmp + cost(r,i);
        end
        IAvg(i) = 1/R * IAvgTmp;
        OAvg(i) = 1/R * OAvgTmp;
        WAvg(i) = 1/R * WAvgTmp;
        costT(i) = 1/R * costTmp;
    end
    costs = 0;

    for i=1:T
        costs = costs + costT(i);
    end

    if useBoCosts == 1
        boCosts = sum(boCosts * max(0,-IAvg));
        fprintf('Costs w/o BO: %.2f\n', costs);
        fprintf('BO Costs: %.2f\n', boCosts);
        costs = costs + boCosts;
    end
    fprintf('Sum costs: %.2f\n', costs);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% simulation.m ends here
