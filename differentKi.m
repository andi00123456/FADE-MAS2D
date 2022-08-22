%plot with and without control
size_u=size(u);
% ki = load('ki1.mat');
% ki = ki.frac;
% a6=load('alpha0.6.mat');
% a6 = a6.frac;
% a7=load('alpha0.7.mat');
% a7 = a7.frac;
% a8=load('alpha0.8.mat');
% a8 = a8.frac;
% a9=load('alpha0.9.mat');
% a9 = a9.frac;
% ki2=load('kp6ki2.mat');
% ki2 = ki2.frac;
% ki3=load('kp6ki3.mat');
% ki3 = ki3.frac;
% ki4=load('kp6ki4.mat');
% ki4 = ki4.frac;
% ki5=load('kp6ki5.mat');
% ki5 = ki5.frac;
% ki6=load('kp6ki6.mat');
% ki6 = ki6.frac;
% best=load('kp9ki1.mat');
% best = best.frac;
% kp90=load('kp80ki0.mat');
% kp90 = kp90.frac;
% kp80ki40=load('kp80ki40.mat');
% kp80ki40 = kp80ki40.frac;
% kp40ki0=load('kp40ki0.mat');
% kp40ki0 = kp40ki0.frac;
% xpollution_1=zeros(size_u(1),1);
% xpollution_2=zeros(size_u(1),1);
% xpollution_3=zeros(size_u(1),1);
% xpollution_4=zeros(size_u(1),1);
% xpollution_5=zeros(size_u(1),1);
% xpollution_6=zeros(size_u(1),1);
% xpollution_7=zeros(size_u(1),1);
xpollution_8=zeros(size_u(1),1);
for i=1:size_u(1)
    for j=1:size_u(2)
%         xpollution_1(i)=xpollution_1(i)+ki(j+1,i);
%         xpollution_2(i)=xpollution_2(i)+ki2(j+1,i);
%         xpollution_3(i)=xpollution_3(i)+ki3(j+1,i);
%         xpollution_4(i)=xpollution_4(i)+ki4(j+1,i);
%         xpollution_5(i)=xpollution_5(i)+ki5(j+1,i);
%         xpollution_6(i)=xpollution_6(i)+kp40ki0(j+1,i);
%         xpollution_7(i)=xpollution_7(i)+kp80ki40(j+1,i);
        xpollution_8(i)=xpollution_8(i)+kp90(j+1,i);
    end
end
% plot(t,xpollution_1,'k');
% hold on
figure(1)
% plot(t,xpollution_2,'LineWidth',2);
% hold on
% plot(t,xpollution_3,'LineWidth',2);
% hold on
% plot(t,xpollution_4,'LineWidth',2);
% hold on
% plot(t,xpollution_5,'LineWidth',2);
% hold on
% plot(t,xpollution_6,'LineWidth',2);
% hold on
% plot(t,xpollution_7,'x','LineWidth',2);
% hold on
plot(t,xpollution_8,'o','LineWidth',2);
hold on
plot([2.25 2.25],[0 10],'k--','LineWidth',1);
xlabel('t');
ylabel('Total Methane Emissions');
%legend('ki=2','ki=3','ki=4','ki=5','ki=6','best','kp=80');
axis([0 5 0 10]);
%figure(2)



