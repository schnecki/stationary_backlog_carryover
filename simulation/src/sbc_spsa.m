%%% spsa.m ---
%%
%% Filename: spsa.m
%% Description:
%%
%%
%%% Code:


function res = sbc_spsa(lmd)
    constants;
    config;
    k = 1;
    sz = 1;
    for i=1:size(lmd,2)
        if D(i) ~= 0
            sz = i;
        end
    end
    % Set rest to 0
    for i=1+sz:size(lmd,2)
        lmd(i) = 0;
    end
    fprintf('size: %d\n', sz);
    startCosts = simulation(lmd)
    res = spsaP(k,lmd,startCosts,alph,gamm,R,sz);
end

function res = spsaP(k, theta, costs, al, ga,repls,sz)
    constants;
    ak = a/(k+A)^al;
    ck = c/k^ga;

    if mod(k,10) == 0
        currentSolution = theta
        fprintf('current costs: %f\n', costs);
    end

    res = theta;
    p = size(theta,2);
    delta=to_vector(2*round(rand(p,1))-1);
    for i=1+sz:p
       delta(i) = 0;
    end
    minTheta(1:p) = 0;
    maxTheta(1:p) = 1.5;
    thetaplus = max(theta+ck*delta,minTheta);
    yplus = simulation(thetaplus);
    thetaminus = max(theta-ck*delta,minTheta);
    yminus = simulation(thetaminus);
    ghat = (yplus-yminus)./(2*ck*delta);
    for i=1+sz:p                       % fix infinite values (div by 0)
        ghat(i) = 0;
    end

    newTheta = min(max(theta-ak*ghat,minTheta),maxTheta)
    ghat = ghat
    fprintf('Step %d\n', k);
    fprintf('Mag(ghat): %f\n', max(ghat)-min(ghat));
    fprintf('ak: %f\n', ak);
    fprintf('ck: %f\n', ck);

    newCosts = simulation(newTheta)

    % if k==100
    %     al = 1.0;
    %     ga = 1/6;
    %     repls=3000;
    % end
    %
    % if k<1
    %     spsaP(k+1,newTheta,newCosts,al,ga,repls,sz)    % standard spsa
    % else

    % check stopping criterion
    if abs(costs-newCosts) >= deltaEnd

        fprintf('not stopping: %f >= %f\n', abs(costs-newCosts), deltaEnd);
        % iteration handling like Kacar
        if (newCosts/costs) > phi
            fprintf('retrying with old theta: %f > %f\n', newCosts/costs, phi);
            spsaP(k+1,theta,costs,al,ga,repls,sz);
            return
        else
            fprintf('success. new step with new theta: %f <= %f\n', newCosts/costs, phi);
            spsaP(k+1,newTheta,newCosts,al,ga,repls,sz); % maybe set al=1.0, ga=1/6
            return
        end

    else
        fprintf('finished: %f < %f\n', abs(costs-newCosts), deltaEnd);
        fprintf('costs: %f\n', costs);
        fprintf('newCosts: %f\n', newCosts);
        if costs > newCosts
            res = newTheta
        else
            res = theta
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% spsa.m ends here
