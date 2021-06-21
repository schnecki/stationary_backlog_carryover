%%% constraints_abc.m ---
%%
%% Filename: constraints_abc.m
%% Description:
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Code:


% Function handle that returns two outputs: [c,ceq] = nonlcon(x)

% ga attempts to achieve c ≤ 0 and ceq = 0. c and ceq are row vectors when there
% are multiple constraints. Set unused outputs to [].

function [c, ceq] = constraints(lmd)
    constants;                          % load constants
    config;
    genDemMem = memoize(@generateDemand);
    simMem = memoize(@sbc_sim);
    [Arr,Proc]=genDemMem(lmd);
    for r=1:R
        % simulate
        [ISim,WSim,costSim] = simMem(r,Arr(r),T,mu,D,g,h);
        I(r,:) = ISim;
    end
    IAvg=1/R*sum(I,1);                  % mean over sum of fist dim

    % fprintf('lmd: %f -> %f \n', lmd, IAvg)

    c = -IAvg;  % [to_vector(-IAvg)];
    % c = to_vector(-IAvg);
    % fprintf('%d\n', 2)
    ceq = [];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% constraints_abc.m ends here
