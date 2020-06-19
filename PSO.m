%%%%%%%%%%%%%%%%%粒子群算法求函数极值%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%初始化%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;              %清除所有变量
close all;              %清图
clc;                    %清屏
N=1000;                  %群体粒子个数
D=3;                    %粒子维数
T=200;                  %最大迭代次数
c1=1.5;                 %学习因子1
c2=1.5;                 %学习因子2
Wmax=0.8;               %惯性权重最大值
Wmin=0.4;               %惯性权重最小值
Lmax=1.5*(10^5);        %[1.5,4.5]
F=6*10^9;
flmax=4*(10^8);         %
flmin=0;                %
Ptmax=0.1;              %
Ptmin=0;                %
lambdamax=1;            %
lambdamin=0;            %
%Xmax=4;                 %位置最大值
%Xmin=-4;                %位置最小值
Vflmax=400;
Vflmin=-400;
VPtmax=0.01;
VPtmin=-0.01;
Vlmdmax=0.1;
Vlmdmin=-0.1;
%Vmax=1;                 %速度最大值
%Vmin=-1;                %速度最小值
%%%%%%%%%%%%%%%%初始化种群个体（限定位置和速度）%%%%%%%%%%%%%%%%
fl=rand(N,1) * (flmax-flmin)+flmin;
Pt=rand(N,1) * (Ptmax-Ptmin)+Ptmin;
lambda=rand(N,1) * (lambdamax-lambdamin)+lambdamin;
x=[fl Pt lambda];
%x=rand(N,D) * (Xmax-Xmin)+Xmin;%rand函数生成N*D的矩阵，每个元素的值取0-1 x是核心值，我的版本里D=3
Vfl=rand(N,1) * (Vflmax-Vflmin)+Vflmin;
VPt=rand(N,1) * (VPtmax-VPtmin)+VPtmin;
Vlmd=rand(N,1) * (Vlmdmax-Vlmdmin)+Vlmdmin;
v=[Vfl VPt Vlmd];
%v=rand(N,D) * (Vmax-Vmin)+Vmin;
%%%%%%%%%%%%%%%%%%初始化个体最优位置和最优值%%%%%%%%%%%%%%%%%%%
p=x;
pbest=ones(N,1);%生成100*1的矩阵，每个元素值为1
for i=1:N
    pbest(i)=environment(x(i,:));%x(i,:)的意思是取矩阵x的第i行成为新的矩阵
end
%%%%%%%%%%%%%%%%%%%初始化全局最优位置和最优值%%%%%%%%%%%%%%%%%%
g=ones(1,D);
gbest=inf;%+∞
for i=1:N
    if(pbest(i)<gbest)
        g=p(i,:);
        gbest=pbest(i);
    end
end
gb=ones(1,T);
%%%%%%%%%%%按照公式依次迭代直到满足精度或者迭代次数%%%%%%%%%%%%%
for i=1:T
    for j=1:N
        %%%%%%%%%%%%%%更新个体最优位置和最优值%%%%%%%%%%%%%%%%%
        if (environment(x(j,:))<pbest(j))
            p(j,:)=x(j,:);
            pbest(j)=environment(x(j,:));
        end
        %%%%%%%%%%%%%%%%更新全局最优位置和最优值%%%%%%%%%%%%%%%
        if(pbest(j)<gbest)
            g=p(j,:);
            gbest=pbest(j);
        end
        %%%%%%%%%%%%%%%%计算动态惯性权重值%%%%%%%%%%%%%%%%%%%%
        w=Wmax-(Wmax-Wmin)*i/T;
        %%%%%%%%%%%%%%%%%跟新位置和速度值%%%%%%%%%%%%%%%%%%%%%
        v(j,:)=w*v(j,:)+c1*rand*(p(j,:)-x(j,:))...
            +c2*rand*(g-x(j,:));
        x(j,:)=x(j,:)+v(j,:);
        %%%%%%%%%%%%%%%%%%%%边界条件处理%%%%%%%%%%%%%%%%%%%%%%
        %一共有五个约束条件，延迟约束和是三个决策变量的约束以及CPU执行周期F
        if L(x(j,:)) > Lmax
            x(j,3) = rand(1) * (lambdamax-lambdamin)+lambdamin;
        end
        if x(j,1) > flmax || x(j,1) < 0
            x(j,1) = rand(1) * (flmax-flmin)+flmin;
        end
        if x(j,2) > Ptmax || x(j,2) < 0
            x(j,2) = rand(1) * (Ptmax-Ptmin)+Ptmin;
        end
        if x(j,3) >lambdamax || x(j,3) < 0
            x(j,3) = rand(1) * (lambdamax-lambdamin)+lambdamin;
        end
        if calF(x(j,3)) > F
            x(j,3) = rand(1) * (lambdamax-lambdamin)+lambdamin;
        end
        %for ii=1:D
        %    if (v(j,ii)>Vmax)  ||  (v(j,ii)< Vmin)
        %        v(j,ii)=rand * (Vmax-Vmin)+Vmin;
        %    end
        %    if (x(j,ii)>Xmax)  ||  (x(j,ii)< Xmin)
        %        x(j,ii)=rand * (Xmax-Xmin)+Xmin;
        %    end
        %end
    end
    %%%%%%%%%%%%%%%%%%%%记录历代全局最优值%%%%%%%%%%%%%%%%%%%%%
    gb(i)=gbest;
end
g;                         %最优个体         
gb(end);                   %最优值
figure
plot(gb)
xlabel('迭代次数');
ylabel('总能耗值');
title('适应度进化曲线')

