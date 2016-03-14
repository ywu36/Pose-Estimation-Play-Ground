function [A, T dataOut] = SICP(model, data, S0, param, if_visualization) % from data to model.
%% Parameters explaination:
% model: 2 x N point clouds,
% data: 2 x N point clouds. The transformation of SICP is from the data to the model.
% S0: 2 x 2 dignal matrix
% param: define the number of iterations in inner and outer loop.
% if_visualization: wheter you hope to visualize the process : 0 or 1.
% Connection: ywu36@uh.edu,  Rein. Y. Wu

%% Estimate mean points
data_num = size(model,2);
mean_model = mean(model,2);
data_t =data;
A = eye(2);
S = S0;
T = zeros(2,1);
%% Initailize the scaling parameters
S_t = S0;
%% Estimate Scaling and rotation parameters iteratively
for j = 1:param.outer_number
    mean_data = mean(data_t,2);
    for i = 1:param.inner_number
        % Update rotation
        q = data_t - repmat(mean_data,[1 data_num]);
        n = model - repmat(mean_model,[1 data_num]);
        C=S_t*q*n';
        [U,~,V]=svd(C);
        Ri=V*U';
        if det(Ri)<0
            V(:,end)=-V(:,end);
            Ri=V*U';
        end
        % Update scaling
        E_1 = [1 0; 0 0];
        E_2 = [0 0; 0 1];
        s_1  = sum(diag(n'*Ri*E_1*q))./sum(diag((q'*E_1*q)));
        s_2  = sum(diag((n'*Ri*E_2*q)))./sum(diag((q'*E_2*q)));
        S_t  = [s_1 0;0 s_2];
    end
    % Update translation
    temp = Ri*(S_t*data_t);
    Ti=mean_model - mean(temp,2);
    data_t = temp + repmat(Ti,[1 data_num]);
    %% Update the final rotation, scaling and translation matrix
    A = Ri*(S_t*A);
    T = Ri*(S_t*T) + Ti;
    %% Visualization
    if if_visualization==1
        plot(model(1,:),model(2,:),'r.',data_t(1,:),data_t(2,:),'b.'), axis equal
    end

end
dataOut = A*data + repmat(T,[1 data_num]);

