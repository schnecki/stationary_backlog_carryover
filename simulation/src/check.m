%%% check.m ---
%%
%% Filename: check.m
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Code:


function arrivals = check(lmd)
    constants;                          % load constants
    config;                             % load config
    % generate count of incoming orders
    Arrivals(1:T) = 0;

    R=10000;

    for r=1:R
        for t=1:T
            tau=t;
            interArrTLmd = 1/lmd(t);
            while interArrTLmd > 0
                intArrTime=exprnd(interArrTLmd);
                if (tau + intArrTime <= t+1)
                    Arrivals(t)=Arrivals(t)+1;
                    tau=tau+intArrTime;
                else
                    break;
                end
            end
        end
    end

    arrivals=1/R * Arrivals;
    lmdRez = lmd
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% check.m ends here
