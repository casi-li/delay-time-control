function [sys,x0,str,ts]=ship_model(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      =2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;

sys=simsizes(sizes);
x0=[0,0,0];
str=[];
ts=[0 0];
function sys=mdlDerivatives(t,x,u)
% T=18.5;
K=0.0118;
% 
% sys(1)=x(2);
% sys(2)=x(3);
% sys(3)=-1/(T^3)*x(1)-3/(T^2)*x(2)-3/T*x(3)+K/(T^3)*u(1);%%+0.1*sin(t);
% A=0.1309;
% B=1.842e-004;
% a=3;
 A=0.1206;
 B=1.1397e-005;
a=3;
 T3=20.7327;
% T3=17.61;
ut=u(1);
dut=u(2);
sys(1)=x(2);
sys(2)=x(3);
% sys(3)=-A*x(3)-B/K*(a*(x(2)^3)+x(2))+B*(ut+T3*dut);
%sys(3)=-3.4*x(3)-0.3710/K*(x(2)^3)-0.35/K*x(2)+0.35*(ut+0.35*dut);%二阶非线性
sys(3)=-3.4*x(3)-(0.35/K)*x(2)+0.35*(ut+0.35*dut);%二阶线性

function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
