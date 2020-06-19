function value=environment(x)
fl=x(1);
Pt=x(2);
lambda=x(3);
%决策变量：为函数的输入值
%fl=4*(10^8);%[0,4*10^8]
%lambda=0;%[0,1]
%Pt=0.1;%W [0,0.1]
%约束变量:应该在粒子群算法中对函数输出值进行约束
%Lmax=1.5*(10^5);%[1.5,4.5]应该扩大数量级到10^5
%F=6*10^9;
%El=a*lambda*I*K*(fl^2);
%Ec=(P0+kt*Pt)*tU+Pr*tD;
%L;

a=40;
I=10*1024*1024*8;%bit
K=10^(-26);
P0=0.4;%W
kt=18;
B1=1;
Pr=0.4;%W
B2=0.2;
WU=10;%MHZ
d=10;%[10,100] 也可以调整
v=4;
h1=0.99;
N0=174*(10^(-13));
WD=10;%MHZ
PF=0.1;%W
h2=0.99;
fc=8*(10^8);

%calculating
RU=WU*log2(1+(Pt*(d^(-v)*(h1^2))/N0));
RD=WD*log2(1+(PF*(d^(-v)*(h2^2))/N0));
tU=B1*(1-lambda)*I/RU;
tD=B2*(1-lambda)*I/RD;
TC=a*(1-lambda)*I/fc;%Cloud端执行时间
tl=a*lambda*I/fl;
tc=tU+TC+tD;
L=max(tl,tc);
E=a*I*K*lambda*(fl^2)+(P0+kt*Pt)*(B1*(1-lambda)*I/RU)+Pr*(B2*(1-lambda)*I/RD);
value=E;
