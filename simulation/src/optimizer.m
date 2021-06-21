%%% optimizer.m ---
%%
%% Filename: optimizer.m
%% Description:
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Code:

clearvars                               % Clear all variables
constants;                              % load constants
config;                                 % load configurations

% bounds
lb(1:T)=0;                              % lower bound of lambda
up(1:T)=20;                             % upper bound of arrival rate

% Set A & B, s.t. A * lambda' <= B
AP=eye(T,T);                            % identity matrix
A=-AP;                                  % -1s
bT(1:T)=0;                              % 0-vector
b=bT';                                  % 0-row (transposed)


% functionTolerance = 0.005

% --------------------------------------------------------------------------------
% GENETIC ALGORITHM
% --------------------------------------------------------------------------------

% options object
% options = optimoptions('ga',...
%                        'InitialPopulationMatrix',startLambda);
%                        % 'FunctionTolerance',functionTolerance

% % % ga(fitnessfcn,nvars,A,b,Aeq,beq,LB,UB,nonlcon), for documentation see
% % % https://de.mathworks.com/help/gads/ga.html
% [result,fval,exitflag,output,population,scores] = ...
%     ga(@simulation,T,A,b,[],[],lb,up,@constraints,options);

% PATTERNSEARCH
% --------------------------------------------------------------------------------

% options object

% options = optimoptions('patternsearch'); % 'MeshTolerance',0.0000000001
%                                         % 'FunctionTolerance',functionTolerance);
%                                         %

% [resss,fval,exitflag,output] = patternsearch(@simulation,startLambda,A,b,[],[],lb,[],@constraints, ...
%                                         options);


% options = optimoptions('fmincon'); %, 'Algorithm', 'interior-point', 'HonorBounds', false
                         % ,'HessianApproximation', 'finite-difference', 'SubproblemAlgorithm', 'cg'

% [resss,fval,exitflag,output] = fmincon(@simulation,startLambda,A,b,[],[],lb,[],@constraints, ...
%                                         options);

% SBSC
% --------------------------------------------------------------------------------

resss = sbc_spsa(startLambda);
fval = simulation(resss);


% --------------------------------------------------------------------------------

fval
% exitflag
% output
% population
% scores
resss
% global costs
% global IAvg
% global WAvg
% IAvg
% costs
% WAvg

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% optimizer.m ends here
