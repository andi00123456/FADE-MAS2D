%clear all,clc
%plot with and without control and optimial Kp, Ki
load J_0_u.mat
size_u=size(u);
u_00 = u;
xpollution_0=zeros(size_u(1),1);
load J_20_u.mat
u_20 = u;
xpollution_20=zeros(size_u(1),1);
load J_op_new_u.mat
u_80 = u;
xpollution_80=zeros(size_u(1),1);
% load J_only_P.mat
% u_p = u;
% xpollution_p=zeros(size_u(1),1);

%xpollution_un=zeros(size_u(1),1);
for i=1:size_u(1)
    for j=1:size_u(2)
        xpollution_0(i)=xpollution_0(i)+u_00(i,j);
        xpollution_20(i)=xpollution_20(i)+u_20(i,j);
        xpollution_80(i)=xpollution_80(i)+u_80(i,j);
        %xpollution_p(i)=xpollution_p(i)+u_p(i,j);
        %xpollution_un(i)=xpollution_un(i)+u(i,j+1);
    end
end
plot(t,xpollution_0,'g--');
hold on
plot(t,xpollution_20,'r--');
hold on
plot(t,xpollution_80,'b');
%hold on
%plot(t,xpollution_p,'m--');
xlabel('t');
ylabel('Total pollution');
legend('Without Control','Not Optimal Kp,Ki Control','Optimaized Kp, Ki');
title('Optimized Control Versus Not Optimized and No Control')
axis([0 4 0 10]);


