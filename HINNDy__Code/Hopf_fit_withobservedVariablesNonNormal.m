clear all, close all, clc
figpath = '../figures/';
addpath('./utils');
addpath('./NoiseFunctions/');
addpath('./plottingfunctions/');

omega = 1;
A = 1;
%Number of variables
n = 4;

dt=0.001; %timestep
% Integrate interval
Initinterval = 16;
%neg_inter = 0
neg_inter = -0;
tinterval=[neg_inter Initinterval];
tspan2=[tinterval(2):-dt:tinterval(1)]; %interval for solving the 
tspan=[.001:dt:tinterval(2)-tinterval(1)];
N = length(tspan);
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
X=[];
%Coeficients of polyorder 3 c1*t+c2*t^2+c3*t^3 & and final time value 
c=[1,1,1,Initinterval];
%Analitic polinomial
y=c(1)*(tspan2)+c(2)*(tspan2).^2+c(3)*(tspan2).^3;
%inverted polinomial
yzero=c(1)*(-tspan+tinterval(2) )+c(2)*(-tspan...
    +tinterval(2)).^2+c(3)*(-tspan+tinterval(2)).^3;
%plot of inverted polinomial
figure(1)
plot(tspan2,y,'r-',tspan,yzero,'b--')
xlabel('time')
ylabel('beta parameter')
hold on
xline(0,'k--');
set(gca,'FontSize',16);
l=legend('Explicit polinomial for steady state generation','Used polynomial for ODE data generation');
l.FontSize = 14;
l.Location='northeast';
title('Inverted polinomial');

% Integration of hopf system
xMax = ones(size(c));
i=0;
for traslation=[0];
    i=i+1;
for mu0=[yzero(1)]    ;
    %x0=sqrt(yzero(1)/2) %Formula of radius of Initial Condition
    for x0=sqrt(yzero(1)/2)/xMax(3)+traslation%Formula of radius of Initial Condition
        [t,x] = ode45(@(t,x) hopfPolyOrder3NONNormal(t,x,c,omega,A,traslation,xMax),tspan,[tspan(1),mu0,x0,x0],options);
         X = [X;x];
         %Variable x3 vs bifurcation parameter
            figure(2)
            hold on
            plot(x(:,2),x(:,3),'b-')
            xlabel('Beta')
            ylabel('x_3')
            xline(0,'k--');
            set(gca,'FontSize',16);
            l=legend('Trajectory using numerical integration');
            l.FontSize = 14;
            l.Location='northeast';
            title('State variable vs Biffurcation parameter')
            hold off    
    end
end
xtrajectories(:,i)=[x(:,3)];
end

xMax = max(abs(x));

%Mu observed from equations of steady state
[x,yzero] = xNormalization(x,yzero);

mufunc = @(x) ((x(:,4)*xMax(4))+(x(:,3)*xMax(3)).*((x(:,3)*xMax(3)).^2+(x(:,4)*xMax(4)).^2))./(x(:,3)*xMax(3));
mu_observed=mufunc(x);%mu observed from equations. (Beta values!!!!!!)


% polinomial fit

%Define the function to fit: "Poly order 2"
F1=@(weightdx,time) (-time+tinterval(2))...
    *weightdx(1)+(-time+tinterval(2)).^2*weightdx(2)+(-time+tinterval(2)).^3*weightdx(3);
%curve fitting
weights0=[0.5 0.5 0.5]; %initial guess for weights
opts = optimoptions('lsqcurvefit','Display','off');
[weightdx, resnorm,~,exitflag,output] = lsqcurvefit(F1,weights0, tspan, mu_observed',[],[],opts); %Prediction of mu(t) depency on t of mu-observed using data integration 

%data predicted from F1 evaluated with the predicted coefficients
reproduced_data= F1(weightdx,tspan); %


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot of State Variable vs Timespan
% plotCleanState_PredFig_3(tspan,x,mu_observed,yzero,reproduced_data,n)
plotState_Beta_time_Pred(tspan,x,mu_observed,yzero,reproduced_data,n,3)


% Mu with Noise
noise_scale=0.018;


[xNoisy, Noise_normalized] = add_Noise_Max(x,noise_scale);
mu_obsNoisy=mufunc(xNoisy)
%mu_obsNoisy=(xNoisy(:,4)+xNoisy(:,3).*(xNoisy(:,3).^2+xNoisy(:,4).^2))./xNoisy(:,3);%mu observed from equations. (Beta values!!!!!!)

[weightdxNoise,resnormNoise,~,exitflagNoise,outputNoise] = lsqcurvefit(F1,weights0, tspan, mu_obsNoisy',[],[],opts);

reproduced_dataNoisy= F1(weightdxNoise,tspan);
% print('real, predicted without noise, weights with noise')
comparisonVector = [c(1:3);weightdx;weightdxNoise];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plotNoisyStateFig_4(tspan,xNoisy,mu_obsNoisy,yzero,reproduced_dataNoisy,n)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plotCleanNoiseStateFig_5(tspan,Noise_normalized,yzero,n)


%% Noise analysis 
% Creation of comparison vector for different noise variances: 
VectorOfNoise = [0:0.009:0.1];
name = mfilename;
name = name(1:10);
noise_Scale_maximum(F1,weights0, tspan, x,c,yzero,VectorOfNoise,name,mufunc)

