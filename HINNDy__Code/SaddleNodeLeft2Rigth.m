%The sadddle note bifurcation has problem when converging to the origin
%i.e. moving from left to right(it goes to infinity after reachin the biff
%point)

clear all, close all, clc
figpath = '../figures/';
addpath('./utils');
addpath('./NoiseFunctions/');
addpath('./plottingfunctions/');

%Number of variables
n = 3;

dt=0.1; %timestep

Initinterval = 16;
neg_inter = 0;
tinterval=[neg_inter Initinterval];
tspan2=[tinterval(2):-dt:tinterval(1)]; %interval for solving ODE
tspan=[.01:dt:tinterval(2)-tinterval(1)];
N = length(tspan);
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
X=[];

%Coeficients of polyorder 3 c1*t+c2*t^2+c3*t^3 & and final time value 
c=[1,0,0,Initinterval];
%Analitic polinomial
%y=c(1)*(tspan2)+c(2)*(tspan2).^2+c(3)*(tspan2).^3;
y=c(1)*(tspan)+c(2)*(tspan).^2+c(3)*(tspan).^3;
%derivative of analitical polinomial is : c1+2*c(2)*(tspan2)+3*c(3)*(tspan2).^2;

%inverted polinomial
y2=c(1)*(-tspan+tinterval(2) )+c(2)*(-tspan...
    +tinterval(2)).^2+c(3)*(-tspan+tinterval(2)).^3;

yzero = c(1)*(tspan+tinterval(1))+c(2)*(tspan+tinterval(1)).^2 ...
        +c(3).*(tspan+tinterval(1)).^3;

%The input of the system is the derivative of y2
% = -c(1)- 2*c(2)* (-y(1)+c(4)) - 3*c(3)*(-y(1)+c(4))^2;
%plot of inverted polinomial
figure(1)
%plot(tspan2,y,'r-',tspan,y2,'b--')
plot(tspan,y,'r-',tspan,y2,'b--')
xlabel('time')
ylabel('beta parameter')
hold on
xline(0,'k--');
set(gca,'FontSize',16);
l=legend('Explicit polinomial for steady state generation','implicit polinmial for ODE data generation');
l.FontSize = 14;
l.Location='northeast';
title('Inverted polinomial');

%Integration of hopf system

%reescaling is zero for my origina variables. 
xMax = [1,1,1];
for mu0=[yzero(1)]    
    %x0=sqrt(y2(1)/2) %Formula of radius of Initial Condition
    %for x0=sqrt(y2(1))%Formula of radius of Initial Condition
    for x0=sqrt(y(1))%Formula of radius of Initial Condition
        [t,x] = ode45(@(t,x) saddlenodeNewPoli(t,x,c,xMax,1,1),tspan,[tspan(1),mu0,x0],options);
         X = [X;x];
         % Variable x3 vs bifurcation parameter
            figure(2)
            hold on
            plot(x(:,2),x(:,3),'b-')
            
            xlabel('Beta')
            ylabel('x_3')
            xline(0,'k--');
            set(gca,'FontSize',16);
            l=legend('state variable vs bifurcation');
            l.FontSize = 14;
            l.Location='northeast';
            title('Saddle  State vsparameter')
            hold off    
    end
end

%Mu observed from equations of steady state

%[x,yzero] = xNormalization(x,yzero);
mufunc = @(x) (x(:,3).^2)*xMax(3)^2; 
mu_observed= mufunc(x);

%Polinomial fit

%Define the function to fit: "Poly order 2"
F1=@(weightdx,xdata)  weightdx(1)*(xdata+tinterval(1))+weightdx(2)*(xdata+tinterval(1)).^2 ...
        +weightdx(3).*(xdata+tinterval(1)).^3;


% curve fitting
weights0=[0.5 0.5 0.5]; %initial guess for weights
opts = optimoptions('lsqcurvefit','Display','off');
[weightdx, resnorm,~,exitflag,output] = lsqcurvefit(F1,weights0, tspan, mu_observed',[],[],opts);

%data predicted from F1 evaluated with the predicted coefficients
reproduced_data= F1(weightdx,tspan);


%plot of beta: real VS polinomial fit VS steady equations
plotState_Beta_time_Pred(tspan,x,mu_observed,yzero,reproduced_data,n,3)

%% Mu with ratio State-Noise

noise_scale = 0.01;

%create the maximum of the values of the tables. 
[xNoisy, Noise_normalized] = add_Noise_Max(x,noise_scale);

%next step is to use the noise for the figures. 
mu_obsNoisy = mufunc(xNoisy);

[weightdxNoise,resnormNoise,~,exitflagNoise,outputNoise] = lsqcurvefit(F1,weights0, tspan, mu_obsNoisy');

reproduced_dataNoisy= F1(weightdxNoise,tspan);

comparisonVector = [c(1:(length(c)-1));weightdx;weightdxNoise]


%% Noise analysis 
% Creation of comparison vector for different noise variances: 
VectorOfNoise = [0:0.1:0.5];
name = mfilename;
name = name(1:10);
%noise_Scale_maximum(F1,weights0, tspan, x,c,yzero,VectorOfNoise,name,mufunc)

noise_5_Boxplots(F1,weights0, tspan, x,c,yzero,VectorOfNoise,name,mufunc)
