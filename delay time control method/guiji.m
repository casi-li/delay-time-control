function [sys,x0,str,ts]=guiji(t,x,u,flag)
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
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      =3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;

sys=simsizes(sizes);
x0=[0,0];
str=[];
ts=[0 0];

function sys=mdlDerivatives(t,x,u)
v=u(1);
us=u(2);
fai=u(3);
u0=7.15;
sys(1)=(us+u0)*cos(fai)-v*sin(fai);
sys(2)=v*cos(fai)+(us+u0)*sin(fai);

function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);