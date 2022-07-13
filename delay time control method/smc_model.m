function [sys,x0,str,ts] = smc_model(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;

sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
% c1=5;
% c2=5;
% 
% yd=u(1);
% dyd=cos(t);
% ddyd=-sin(t);
% dddyd=-cos(t);
% 
% x1=u(2);
% x2=u(3);
% x3=u(4);
% 
% e=x1-yd;
% de=x2-dyd;
% dde=x3-ddyd;
% 
% s=c1*e+c2*de+dde;
% v=-dddyd+c1*de+c2*dde;
% 
% T=18.5;K=0.2;
% b=K/(T^3);
% alfa=-1/(T^3)*x1-3/(T^2)*x2-3/T*x3;
% xite=0.50;
% ut=-1/b*(v+alfa+xite*s);
% sys(1)=ut;
% B=1.842e-004;
 B=1.1397e-005;
% k1=0.1083;
% k2=0.1041;
%  k1=0.16;
%  k2=0.15;
%original中使用
%适宜随机逼近mdl
k1=2;%不能太大
k2=0.1;%不能太大
fa=0.5;
% c1=1.847;
% c2=2.718;
c1=1.5;
c2=2;
% c1=0.008;
% c2=0.16;
% C=711.114;
% C=10586.4;
a=3;
% K=0.0118;

xd=u(1);
x=u(2);
dx=u(3);
ddx=u(4);
dxd=0;
ddxd=0;
dddxd=0;
% dxd=u(5);
% ddxd=u(6);
% dddxd=u(7);

e=x-xd;
de=dx-dxd;
dde=ddx-ddxd;

s=c1*e+c2*de+dde;
% ut=(1/B)*(-k1*s-k2*(abs(s)^fa)*sign(s)-c1*de-c2*dde+dddxd)+C*(dde+ddxd)+a*(de+dxd)^3+de+dxd;
%  ut=(1/0.371)*(-k1*s-k2*(abs(s)^fa)*sign(s)-c1*de-c2*dde+dddxd)+9.16*(dde+ddxd)+a*(de+dxd)^3+de+dxd;
%original中使用
%ut=(1/0.371)*(-k1*s-k2*sign(s)-c1*de-c2*dde+dddxd)+9.16*(dde+ddxd)+a*(de+dxd)^3+de+dxd;%二阶非线性
 ut=(1/0.371)*(-k1*s-k2*sign(s)-c1*de-c2*dde+dddxd)+9.16*(dde+ddxd)+de+dxd;%二阶线性
sys(1)=ut;
