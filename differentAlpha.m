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
a8b2=load('a8b2.mat');
a8b2 = a8b2.frac;
a9b2=load('a9b2.mat');
a9b2 = a9b2.frac;
a10b20=load('a10b20.mat');
a10b20 = a10b20.frac;
a11b20=load('a11b20.mat');
a11b20 = a11b20.frac;
a12b20=load('a12b20.mat');
a12b20 = a12b20.frac;
% xpollution_1=zeros(size_u(1),1);
xpollution_2=zeros(size_u(1),1);
xpollution_3=zeros(size_u(1),1);
xpollution_4=zeros(size_u(1),1);
xpollution_5=zeros(size_u(1),1);
xpollution_6=zeros(size_u(1),1);
for i=1:size_u(1)
    for j=1:size_u(2)
%         xpollution_1(i)=xpollution_1(i)+ki(j+1,i);
        xpollution_2(i)=xpollution_2(i)+a8b2(j+1,i);
        xpollution_3(i)=xpollution_3(i)+a9b2(j+1,i);
        xpollution_4(i)=xpollution_4(i)+a10b20(j+1,i);
        xpollution_5(i)=xpollution_5(i)+a11b20(j+1,i);
        xpollution_6(i)=xpollution_6(i)+a12b20(j+1,i);
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
plot([2.26 2.26],[0 20],'r--','LineWidth',1);
xlabel('t');
ylabel('Total Methane Emissions');
legend('alpha=0.8','alpha=0.9','alpha=1.0','alpha=1.1','alpha=1.2');
axis([0 5 0 20]);
%figure(2)



