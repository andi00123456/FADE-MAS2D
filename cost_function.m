clear all,clc
R = 0.33;        % 1                     0                     0                         0.33
KK = 0.33; % 0                     1                     0
Q =  0.33*1e4; % 0                     0                     1
n_opt =1;
p_out_max = 0.1;
epsillon = 0.5; % depend on f_d
t_max = 2.1 + log(20/epsillon); % time from start control to
%%
%n_opt =10;
% Kp 8.42, Ki 10, Ks 50.894 J_20
% Kp 22.22, Ki 9.33, Ks 62.44 J_80
KP = linspace(0,42.22,n_opt);
KI = linspace(0,48.33,n_opt);
KS = linspace(0,52.44,n_opt);
[KP_id,KI_id,KS_id] = ndgrid(KP,KI,KS);
KP_id = KP_id(:);
KI_id = KI_id(:);
KS_id = KS_id(:);
%%
for trial = 1:size(KP_id)
    global e_k p_out t_c kp ki ks p_out_t 
    kp = KP_id(trial);
    ki = KI_id(trial);
    ks = KS_id(trial);
    e_k = [];
    p_out_t = [];
    p_out_tmp = [];
    t_c = t_max;
    simstart_v2
    p2dot = p_out_t;
    for tmp_trails = 1:size(p_out_t,1)
        p_out_tmp(tmp_trails) = norm(p_out_t(tmp_trails,:));
    end
    p_out_t = p_out_tmp;
    size_u=size(u);
    xpollution_i=zeros(size_u(1),1);
    %xpollution_un=zeros(size_u(1),1);
    for m=1:size_u(1)
            xpollution_i(m)=xpollution_i(m)+sum(u(m,:));
        %xpollution_i(m)
        if xpollution_i(m) < epsillon && m > 20
            t_c = t(m);
            break
        end
    end
    plot(t,xpollution_i);
    J_ave(trial) = R*sum(xpollution_i)/4269.25674947314 + KK*sum((p_out_t/p_out_max).^2)/NA/length(p_out_t) + Q*sum(e_k.^2)/length(p_out_t);
    J_R(trial) = 1*sum(xpollution_i)/4269.25674947314;
    J_KK(trial) = 1*sum((p_out_t/p_out_max).^2)/NA/length(p_out_t);
    J_Q(trial) = 1*sum(e_k.^2)/length(p_out_t);
%     R*sum(xpollution_i)/4269.25674947314
% %     R*(t_c/t_max)
%     KK*sum((p_out_t/p_out_max).^2)/NA/length(p_out_t)
%     Q*sum(e_k.^2)/length(p_out_t)
     disp(trial);
end
%%
indicesAve = find(J_ave == min(J_ave(:)));
indicesR = find(J_R == min(J_R(:)));
indicesK = find(J_KK == min(J_KK(:)));
indicesQ = find(J_Q == min(J_Q(:)));
optimals = [];
optimal_ki_ave  = KP_id(indicesAve);
optimal_kp_ave = KI_id(indicesAve);
optimal_ks_ave = KS_id(indicesAve);
optimal_ki_R = KP_id(indicesR);
optimal_kp_R = KI_id(indicesR);
optimal_ks_R = KS_id(indicesR);
optimal_ki_K = KP_id(indicesK);
optimal_kp_K = KI_id(indicesK);
optimal_ks_K = KS_id(indicesK);
optimal_ki_Q = KP_id(indicesQ);
optimal_kp_Q = KI_id(indicesQ);
optimal_ks_Q = KS_id(indicesQ);
optimals = [optimal_kp_ave,optimal_ki_ave,optimal_ks_ave;
                  optimal_kp_R,optimal_ki_R,optimal_ks_R;
                  optimal_kp_K,optimal_ki_K,optimal_ks_K;
                  optimal_kp_Q,optimal_ki_Q,optimal_ks_Q;];
