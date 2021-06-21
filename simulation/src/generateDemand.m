%%% generateDemand.m ---
%%
%% Filename: generateDemand.m
%% Description:
%% Author: Manuel Schneckenreither
%% Maintainer:
%% Created: Tue Mar 27 09:53:57 2018 (+0200)
%% Version:
%% Package-Requires: ()
%% Last-Updated: Tue Mar 27 10:25:35 2018 (+0200)
%%           By: Manuel Schneckenreither
%%     Update #: 13
%% URL:
%% Doc URL:
%% Keywords:
%% Compatibility:
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Commentary:
%%
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Change Log:
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Code:

% Generates demand and processing times for all replications

function [Arr,Proc] = generateDemand(lmd)
    constants;
    for r=1:R
        Arr(r)=java.util.LinkedList;
        Proc(r)=java.util.LinkedList;
        for t=1:T
            tau=t;
            interArrTLmd = 1/lmd(t);
            while interArrTLmd > 0
                intArrTime=exprnd(interArrTLmd);
                if (tau + intArrTime < t+1)
                    Arr(r).add(tau+intArrTime);
                    tau=tau+intArrTime;
                else
                    break;
                end
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% generateDemand.m ends here
