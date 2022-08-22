%plot with and without control
size_u=size(u);
% ki = load('ki1.mat');
% ki = ki.frac;
b6=load('beta16.mat');
b6 = b6.frac;
b7=load('beta17.mat');
b7 = b7.frac;
b8=load('beta18.mat');
b8 = b8.frac;
b9=load('beta19.mat');
b9 = b9.frac;
a10b20=load('a10b20.mat');
a10b20 = a10b20.frac;
a10b21=load('a10b21.mat');
a10b21 = a10b21.frac;
a10b22=load('a10b22.mat');
a10b22 = a10b22.frac;
xpollution_1=zeros(size_u(1),1);
xpollution_2=zeros(size_u(1),1);
xpollution_3=zeros(size_u(1),1);
xpollution_4=zeros(size_u(1),1);
xpollution_5=zeros(size_u(1),1);
xpollution_6=zeros(size_u(1),1);
xpollution_7=zeros(size_u(1),1);
for i=1:size_u(1)
    for j=1:size_u(2)
        xpollution_1(i)=xpollution_1(i)+b6(j+1,i);
        xpollution_2(i)=xpollution_2(i)+b7(j+1,i);
        xpollution_3(i)=xpollution_3(i)+b8(j+1,i);
        xpollution_4(i)=xpollution_4(i)+b9(j+1,i);
        xpollution_5(i)=xpollution_5(i)+a10b20(j+1,i);
        xpollution_6(i)=xpollution_6(i)+a10b21(j+1,i);
        xpollution_7(i)=xpollution_7(i)+a10b22(j+1,i);
    end
end
plot(t,xpollution_1);
hold on
plot(t,xpollution_2);
hold on
plot(t,xpollution_3);
hold on
plot(t,xpollution_4);
hold on
plot(t,xpollution_5);
hold on
plot(t,xpollution_6);
hold on
plot(t,xpollution_7);
xlabel('t');
ylabel('Total pollution');
legend('beta=1.6','beta=1.7','beta=1.8','beta=1.9','beta=2','beta=2.1','beta=2.2');
axis([0 5 0 20]);


