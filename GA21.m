%%%%%%%%%%%%%%%%%%%%?????????%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%???%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;               %??????
close all;               %??
clc;                     %??
m=20;                    %????
G_max=200;               %??????
Rho=0.9;                 %???????
P0=0.2;                  %??????
XMAX= 5;                 %????x???
XMIN= -5;                %????x???
YMAX= 5;                 %????y???
YMIN= -5;                %????y???
ZMAX= 5;                 %????z???
ZMIN= -5;                %????z???
%%%%%%%%%%%%%%%%%??????????%%%%%%%%%%%%%%%%%%%%%%
for i=1:m
    X(i,1)=(XMIN+(XMAX-XMIN)*rand);
    X(i,2)=(YMIN+(YMAX-YMIN)*rand);
    X(i,3)=(YMIN+(YMAX-YMIN)*rand);
    Tau(i)=func(X(i,1),X(i,2),X(i,3));
end
step=0.1;                %??????
for NC=1:G_max
    lamda=1/NC;
    [Tau_best,BestIndex]=min(Tau);
    %%%%%%%%%%%%%%%%%%????????%%%%%%%%%%%%%%%%%%%%
    for i=1:m
        P(NC,i)=(Tau(BestIndex)-Tau(i))/Tau(BestIndex);%??????????????????????
    end
    %%%%%%%%%%%%%%%%%%%%%%????%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:m
           %%%%%%%%%%%%%%%%%????%%%%%%%%%%%%%%%%%%%%%%
        if P(NC,i)<P0
            temp1=X(i,1)+(2*rand-1)*step*lamda;
            temp2=X(i,2)+(2*rand-1)*step*lamda;
            temp3=X(i,3)+(2*rand-1)*step*lamda;
        else
            %%%%%%%%%%%%%%%%????%%%%%%%%%%%%%%%%%%%%%%%
             temp1=X(i,1)+(XMAX-XMIN)*(rand-0.5);
             temp2=X(i,2)+(YMAX-YMIN)*(rand-0.5);
             temp3=X(i,3)+(ZMAX-ZMIN)*(rand-0.5);
        end
        %%%%%%%%%%%%%%%%%%%%%????%%%%%%%%%%%%%%%%%%%%%%%
        if temp1<XMIN
            temp1=XMIN;
        end
        if temp1>XMAX
            temp1=XMAX;
        end
        if temp2<YMIN
            temp2=YMIN;
        end
        if temp2>YMAX
            temp2=YMAX;
        end
        if temp3<ZMIN
            temp3=ZMIN;
        end
        if temp3>ZMAX
            temp3=ZMAX;
        end
        %%%%%%%%%%%%%%%%%%????????????????????????%%%%%%%%%%%%%%%%%%
        if func(temp1,temp2,temp3)<func(X(i,1),X(i,2),X(i,3))
            X(i,1)=temp1;
            X(i,2)=temp2;
            X(i,3)=temp3;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%?????%%%%%%%%%%%%%%%%%%%%%%%
    %%%?????????????“??”????????????????????%%%%
    for i=1:m
        Tau(i)=(1-Rho)*Tau(i)+func(X(i,1),X(i,2),X(i,3));
    end
    [value,index]=min(Tau);
    trace(NC)=func(X(index,1),X(index,2),X(index,3));
end
[min_value,min_index]=min(Tau);
minX=X(min_index,1);                           %????
minY=X(min_index,2);                           %????
minZ=X(min_index,3);                           %????
minValue=func(X(min_index,1),X(min_index,2),X(min_index,3));  %???
figure
plot(trace)
xlabel('seach number');
ylabel('E');
title('Ant Colony Algorithm')