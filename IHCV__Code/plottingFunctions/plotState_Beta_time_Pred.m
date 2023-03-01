function plotState_Beta_time_Pred(tspan,x,mu_observed,yzero,reproduced_data,n,nfig)
    if n == 4
        figure(nfig)
        subplot(2,4,1)
        hold on
        plot(tspan,x(:,3),'b-','LineWidth',2)
        xlabel('time')
        ylabel('x')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('x VS T');
        l.FontSize = 14;
        l.Location='northeast';
        title('state x')
        hold off
        
        subplot(2,4,2)
        hold on
        plot(tspan,x(:,4),'b-','LineWidth',2)
        xlabel('time')
        ylabel('y')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('state y');
        l.FontSize = 14;
        l.Location='northeast';
        title('State vs time')
        hold off
                    
    
        
        
        subplot(2,4,3)
        plot(tspan,yzero,'r-','linewidth',2)% good True dynamic
        yline(0,'k--','HandleVisibility','off');
        hold on
        plot(tspan,reproduced_data,'b--','linewidth',2); %Alpha from polinomial fit
        xlabel('Time')
        ylabel('Alpha')
        %axis([0 20 -100 5000])
        set(gca,'FontSize',16);
        l=legend('True ','Inferred','Intermediate');
        l.FontSize = 14;
        l.Location='northeast';
        title('True, Inferred')
        hold off
        
        
        subplot(2,4,4)
        plot(tspan,yzero,'r-','linewidth',2)% good True dynamic
        yline(0,'k--','HandleVisibility','off');
        hold on
        plot(tspan,reproduced_data,'b--','linewidth',2); %Alpha from polinomial fit
        plot(tspan,mu_observed,'m-')%,'linewidth',2) %Alpha from steady equations
        xlabel('Time')
        ylabel('Alpha')
        %axis([0 20 -100 5000])
        set(gca,'FontSize',16);
        l=legend('True ','Inferred','Intermediate');
        l.FontSize = 14;
        l.Location='northeast';
        title('True, Inferred, intermediate')
        hold off
        
        subplot(2,4,5)
        hold on
        plot(x(:,2),x(:,3),'b-','LineWidth',2)
        xlabel('Alpha')
        ylabel('x')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('x VS T');
        l.FontSize = 14;
        l.Location='northeast';
        title('x3 vs Bif par/ter')
        hold off
        
        subplot(2,4,6)
        hold on
        plot(x(:,2),x(:,4),'b-','LineWidth',2)
        xlabel('Alpha')
        ylabel('y')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('y x VS Time');
        l.FontSize = 14;
        l.Location='northeast';
        title('x VS biff/par')
        hold off
    elseif n == 3
        figure(nfig)
        subplot(2,3,1)
        hold on
        plot(tspan,x(:,3),'b-','linewidth',2)
        xlabel('time')
        ylabel('x')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('X VS Time');
        l.FontSize = 14;
        l.Location='northeast';
        title('Observation State')
        hold off
        
        subplot(2,3,2)
        plot(tspan,yzero,'r-','linewidth',2)% good True dynamic
        yline(0,'k--','HandleVisibility','off');
        hold on
        plot(tspan,reproduced_data,'b--','linewidth',2); %Alpha from polinomial fit
        xlabel('Time')
        ylabel('Alpha')
        %axis([0 20 -100 5000])
        set(gca,'FontSize',16);
        l=legend('True ','Inferred','Intermediate');
        l.FontSize = 14;
        l.Location='northeast';
        title('True, Inferred ')

        hold off                
        
        subplot(2,3,3)
        plot(tspan,yzero,'r-','linewidth',2)% good True dynamic
        yline(0,'k--','HandleVisibility','off');
        hold on
        plot(tspan,reproduced_data,'b--','linewidth',2); %Alpha from polinomial fit
        plot(tspan,mu_observed,'m-','linewidth',1)%,'linewidth',2) %Alpha from steady equations
        xlabel('Time')
        ylabel('Alpha')
        %axis([0 20 -100 5000])
        set(gca,'FontSize',16);
        l=legend('True ','Inferred','Intermediate');
        l.FontSize = 14;
        l.Location='northeast';
        title('True, Inferred, intermediate')
        hold off
        
        subplot(2,3,4)
        hold on
        plot(x(:,2),x(:,3),'b-','linewidth',2)
        xlabel('Alpha')
        ylabel('x')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend(' x VS Time');
        l.FontSize = 14;
        l.Location='northeast';
        title('State vs Alpha')
        hold off
    elseif n == 5
        figure(nfig)
        subplot(2,5,1)
        hold on
        plot(tspan,x(:,3),'b-','LineWidth',2)
        xlabel('time')
        ylabel('x')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('X VS Time');
        l.FontSize = 16;
        l.Location='northeast';
        title('Prediction with noise = x3 vs time')
        hold off
        
        subplot(2,5,2)
        hold on
        plot(tspan,x(:,4),'b-','LineWidth',2)
        xlabel('time')
        ylabel('y')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('y x VS Time');
        l.FontSize = 16;
        l.Location='northeast';
        title('y vs time')
        hold off
                    
        subplot(2,5,3)
        hold on
        plot(tspan,x(:,5),'b-')
        xlabel('time')
        ylabel('x_5')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('x_5 VS Time');
        l.FontSize = 16;
        l.Location='northeast';
        title('x5 vs time')
        hold off
        
        
        subplot(2,5,4)
        plot(tspan,yzero,'r-','linewidth',2)% good True dynamic
        yline(0,'k--','HandleVisibility','off');
        hold on
        plot(tspan,reproduced_data,'b--','linewidth',2); %Alpha from polinomial fit
        xlabel('Time')
        ylabel('Alpha')
        %axis([0 20 -100 5000])
        set(gca,'FontSize',16);
        l=legend('True ','Inferred','Intermediate');
        l.FontSize = 14;
        l.Location='northeast';
        title('True, Inferred, intermediate')
        hold off
        
        
        subplot(2,5,5)
        plot(tspan,yzero,'r-','linewidth',2)% good True dynamic
        yline(0,'k--','HandleVisibility','off');
        hold on
        plot(tspan,reproduced_data,'b--','LineWidth',1); %Alpha from polinomial fit
        plot(tspan,mu_observed,'m-')%,'LineWidth',1) %Alpha from steady equations
        xlabel('Time')
        ylabel('Alpha')
        %axis([0 20 -100 5000])
        set(gca,'FontSize',16);
        l=legend('True ','Inferred','Intermediate');
        l.FontSize = 14;
        l.Location='northeast';
        title('True, Predict, Int/ate')
        hold off
        
        subplot(2,5,6)
        hold on
        plot(yzero,x(:,3),'b-')
        xlabel('time')
        ylabel('x')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('x3 VS Time');
        l.FontSize = 14;
        l.Location='northeast';
        title('x3 vs alpha')
        hold off
        
        subplot(2,5,7)
        hold on
        plot(yzero,x(:,4),'b-')
        xlabel('time')
        ylabel('y')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('y VS Time');
        l.FontSize = 14;
        l.Location='northeast';
        title('y vs alpha')
        hold off

        subplot(2,5,8)
        hold on
        plot(yzero,x(:,5),'b-')
        xlabel('time')
        ylabel('x_5')
        xline(0,'k--');
        set(gca,'FontSize',16);
        l=legend('x_5  VS Time');
        l.FontSize = 14;
        l.Location='northeast';
        title('State variable vs Biffurcation parameter')
        hold off
    end
end
