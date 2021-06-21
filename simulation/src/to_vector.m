%%% to_vector.m ---
%%
%% Filename: to_vector.m
%% Description:
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%% Code:

function v = to_vector(A)
    v=reshape(A,[1,size(A,1)*size(A,2)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% to_vector.m ends here
