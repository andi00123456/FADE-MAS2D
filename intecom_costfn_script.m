%% 
%clc, clear

%load J_final.mat
%load J_KK.mat
%load J_Q.mat
%load J_R.mat
%J = J_KK;

KP_id = reshape(KP_id,[n_opt,n_opt,n_opt]);
KI_id = reshape(KI_id,[n_opt,n_opt,n_opt]);
KS_id = reshape(KS_id,[n_opt,n_opt,n_opt]);
J = reshape(J',[n_opt,n_opt,n_opt]);

k = find(J == min(J(:)));

if numel(k) > 0
    if numel(k) == 1
        k_id = k;
    else
        k_id = k(1);
        disp('multiple minimums')
    end
else
    disp error
end

% have to correct for ndgrid to make in meshgrid form,
% the order of x and y will be reversed. (see in xlabel)
KP_id = permute(KP_id,[2,1,3]);
KI_id = permute(KI_id,[2,1,3]);

slice(KP_id,KI_id,KS_id,J,KP_id(k_id),KI_id(k_id),KS_id(k_id))
%slice(KP_id,KS_id,J,KP_id(k_id),KS_id(k_id))

xlabel('Ki'); ylabel('Kp'); zlabel('Ks');
%ylabel('Kp'); zlabel('Ks');
title('Cost function R, K, Q in average versus k_p, k_i, and k_s')

hold on 
scatter3(KP_id(k_id),KI_id(k_id),KS_id(k_id),100,'filled','r')
hold off