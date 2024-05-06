%%% This is the data fitting code.

clear all

% data import
CovidTable = readtable('data/Ghana_only_covid19_data.csv','NumHeaderLines',59);  % skips the first three rows of data
Vaccine=CovidTable{:,8};
date=CovidTable{:,1};
% call parameters
parameters=call_parameters();
% parameters(7)=0;
% parameters(8)=0;
% set I compartsments
[I1, I2, ytrue]=set_compartsments();

% set optimal control
optimal = [0.; 0.; 1]; % u1, u2, u3

sol=zeros(7,1);
% I1(:)=0;
% ytrue(:,1)=0;
k=1;
for i=1:length(I1)-1
    
    para = optimvar('para',2,"LowerBound",0,"UpperBound",100);

    tspan=[i:i+1];
    initial=[parameters(1)-4-1;4;0;1;0;0;0];
    True_interval_value=transpose(ytrue(i:i+1,1:2));
    if i==1
        myfcn = fcn2optimexpr(@FitToODE,para,tspan,initial,parameters,optimal);
    else
        myfcn = fcn2optimexpr(@FitToODE,para,tspan,initial2,parameters,optimal);
    end
    obj = sum(sum((myfcn - True_interval_value).^2));
    prob = optimproblem("Objective",obj);
    para0.para = [0.0001 0.0001];
    [parasol,sumsq] = solve(prob,para0);
    beta1(i)=parasol.para(1);
    beta2(i)=parasol.para(2);
    betas(i,:)=[beta1(i);beta2(i)];
    error(i)=sumsq;
    if i==1
        soltrue = ode45(@(t,y)diffun(t,y,betas(i,:),...
            parameters,optimal),tspan,initial);
        yvalstrue = deval(soltrue,tspan);
        initial2=yvalstrue(:,2);
        ym1(1)=yvalstrue(4,1);
    else
        soltrue = ode45(@(t,y)diffun(t,y,betas(i,:),...
            parameters,optimal),tspan,initial2);
        yvalstrue = deval(soltrue,tspan);
        initial2=yvalstrue(:,2);

        
        if i==596 %date(i)=='10/20/2021' %start the omicron variants
            initial2(3)=0.142857142857143*8;
            initial2(5)=0.142857142857143;
        end        
    end
    
    ym1(i+1)=yvalstrue(4,2);
    ym2(i+1)=yvalstrue(5,2);

    sol(:,i+1)=yvalstrue(:,2);

    
end

plt=1;

if plt==1
    figure
    grid on
    hold on
    t = datetime(2020,3,1) + caldays(1:length(ym1));
    tt=datenum(t);
    g1=plot(tt,ym1+ym2,'c','LineWidth',2);
    g2=plot(tt,ym1,'r','LineWidth',2);

    g5=area(tt,ytrue(1:end,1:2),'FaceAlpha',.3,'EdgeAlpha',0);
    colororder(['r';'g'])
    II=I1+I2;
    g6=plot(tt,II(1:end),'k');
    
    
    legend([g1 g2 g5],{'Total number of infectious','Coronavirus','Matant virus','Actual'})
    title('Daily infections')
    xlabel('Time') 
    ylabel('The number of infectious')
    datetick('x','mm/dd')
%     saveas(gcf,'[Fig]model_fitting2.png')

end

