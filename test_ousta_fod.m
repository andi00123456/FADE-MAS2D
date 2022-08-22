clc;
close all;
clear all;
t=0:0.001:3;
f=@(t)exp(-t).*sin(3*t+1);
% f=@(t)sin(3*t+1);
s=t';
g=f(s);
G=ousta_fod(-0.5,4,1e-3,1e3);
y1=lsim(G,f(t),t);
FraOrder=CalFracPra(-0.5,4);
SIMTIME=3;
OPTIONS=simset('Solver', 'ode4', 'FixedStep', 0.001);
    	sim('frac_test_caokc', SIMTIME,OPTIONS)
%         sim('frac_test_caojx', SIMTIME,OPTIONS)
 plot(t,y1(:),'r',s,y2.signals.values,'b-.');