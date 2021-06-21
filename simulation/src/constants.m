%%% constants.m ---
%%
%%% Code:


% Indices
T=101;                                  % number of periods (incl. period 0)

R=5000;                                 % replications

mu=1.0;                                 % Service rate at bottleneck station

% Parameters
h=0.8;                                  % holding costs coefficient for WIP
g=1.0;                                  % hodling costs coefficient for product
                                        % inventory


% init global variables
global IAvg;
IAvg(1:T)=0;                            % set zeros


% SPSA constants setup
useBoCosts = 0;                         % Use Backorder costs for SPSA
boCosts = 00;                          % Per order


c = 0.1;                                % step for lambda

alph = 0.602;                           % see Spall (1998) Implementation of simultaneous
gamm = 0.101;                           % perturbation stochastic approximation

A = 1000;
% a= 10^-1;
a = 0.004;

phi = 1.0;                             % tolerance value in percent to get out of local minimum
deltaEnd = 0.05;                       % stopping criterion


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% constants.m ends here
