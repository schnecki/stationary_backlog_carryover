%%% sim.m ---
%%
%% Filename: sim.m
%% Description:
%% Author: Manuel Schneckenreither
%% Maintainer:
%% Created: Tue Mar 27 09:53:20 2018 (+0200)
%% Version:
%% Package-Requires: ()
%% Last-Updated: Wed Jul 15 10:32:16 2020 (+0200)
%%           By: Manuel Schneckenreither
%%     Update #: 41
%% URL:
%% Doc URL:
%% Keywords:
%% Compatibility:
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Code:


% Simulation
function [I,W,O,cost] = sbc_sim(r,arr,T,mu,D,g,h)
% fprintf('sim in')

    period=1;                           % simulation period counter
    I(1:T)=0;
    W(1:T)=0;
    O(1:T)=0;
    cost(1:T)=0;
    lastEndTime=0;
    i=0;
    for i=0:arr.size()-1               % for all orders

        % continue to period of last processing end and skip empty periods => end of period
        % calculations
        while period <= T && (period < floor(lastEndTime) || period < floor(arr.get(i)))

            % WIP (queue)
            j = i;
            while j < arr.size() && floor(arr.get(j)) <= period
                W(period) = W(period)+1; % queue size
                j=j+1;
            end

            % INVENTORY (size and costs)
            I(period) = I(period)-D(period);
            cost(period) = h*W(period) + g*max(0,I(period));

            % Inventory of next period (period in which orders may arrive)
            period = period + 1;
            if period <= T
                I(period) = I(period) + I(period-1);
            end
        end

        % END OF SIMULATION/NO MORE ORDERS
        if period > T
            break;
        end


        % start time is maximum of period start, arrival time and processing end
        % time of last order
        % fprintf("start\n")
        startTime = max(max(period,arr.get(i)),lastEndTime);
        procTime=exprnd(mu);            % processing time

        lastEndTime=startTime+procTime; % this order specifies last end time

        % Print orders
        % fprintf('order %d, Arr: %f, Proc: %f, Start: %f, End: %f\n', i, ...
        %         arr.get(i),procTime, startTime, lastEndTime);

        % add item to WIP for all processing period
        for j=floor(startTime):min(T,floor(lastEndTime)-1)
            W(j) = W(j)+1;
        end

        % add item to FGI in which it will be finished
        if floor(lastEndTime) <= T
            I(floor(lastEndTime)) = I(floor(lastEndTime))+1;
            O(floor(lastEndTime)) = O(floor(lastEndTime))+1;
        end
    end

    % All orders done, propagate inventory back
    if period <= T
        I(period) = I(period) - D(period);
        for j=period+1:T            % simulate end of periods
            I(j) = I(j) + I(j-1) - D(j);
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% sim.m ends here
