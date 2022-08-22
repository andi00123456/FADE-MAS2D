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
kp1=load('kp1ki3.mat');
kp1 = kp1.frac;
kp3=load('kp3ki3.mat');
kp3 = kp3.frac;
kp6=load('kp6ki3B.mat');
kp6 = kp6.frac;
kp9=load('kp9ki3.mat');
kp9 = kp9.frac;
kp12=load('kp12ki3.mat');
kp12 = kp12.frac;
% xpollution_1=zeros(size_u(1),1);
xpollution_2=zeros(size_u(1),1);
xpollution_3=zeros(size_u(1),1);
xpollution_4=zeros(size_u(1),1);
xpollution_5=zeros(size_u(1),1);
xpollution_6=zeros(size_u(1),1);
for i=1:size_u(1)
    for j=1:size_u(2)
%         xpollution_1(i)=xpollution_1(i)+ki(j+1,i);
        xpollution_2(i)=xpollution_2(i)+kp1(j+1,i);
        xpollution_3(i)=xpollution_3(i)+kp3(j+1,i);
        xpollution_4(i)=xpollution_4(i)+kp6(j+1,i);
        xpollution_5(i)=xpollution_5(i)+kp9(j+1,i);
        xpollution_6(i)=xpollution_6(i)+kp12(j+1,i);
    end
end
% plot(t,xpollution_1,'k');
% hold on
figure(1)
plot(t,xpollution_2,'LineWidth',2);
hold on
plot(t,xpollution_3,'LineWidth',2);
hold on
plot(t,xpollution_4,'LineWidth',2);
hold on
plot(t,xpollution_5,'LineWidth',2);
hold on
plot(t,xpollution_6,'LineWidth',2);
hold on
plot([2.25 2.25],[0 10],'r--','LineWidth',1);
xlabel('t');
ylabel('Total Methane Emissions');
legend('kp=1','kp=3','kp=6','kp=9','kp=12');
axis([0 5 0 10]);
%figure(2)



