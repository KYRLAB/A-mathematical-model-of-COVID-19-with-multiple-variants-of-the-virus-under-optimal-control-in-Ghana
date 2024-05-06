%%% This is the code for optimal controls.

clear all


parameters=call_parameters();

% set I compartsments
for l=0.1
    for m=0.1
        for p=0
% set optimal control
optimal = [l; m; p]; % u1, u2, u3

sol=zeros(7,1);


k=1;
endpoint=400;
for i=1:endpoint
    
    tspan=[i:i+1];
    initial=[parameters(1)-100;40;40;10;10;0;0];

    beta1(i)=0.6;
    beta2(i)=0.6;
    betas(i,:)=[beta1(i);beta2(i)];
    if i==1
        soltrue = ode45(@(t,y)diffun(t,y,betas(i,:),...
            parameters,optimal),tspan,initial);
        yvalstrue = deval(soltrue,tspan);
        initial2=yvalstrue(:,2);
        ym1(1)=yvalstrue(4,1);
        ym2(1)=yvalstrue(5,1);

    else
        soltrue = ode45(@(t,y)diffun(t,y,betas(i,:),...
            parameters,optimal),tspan,initial2);
        yvalstrue = deval(soltrue,tspan);
        initial2=yvalstrue(:,2);

%         if i==20 %start the I2 variants
%             initial2(3)=40;
%             initial2(5)=10;
%         end

    end
    
    ym1(i+1)=yvalstrue(4,2);
    ym2(i+1)=yvalstrue(5,2);

    sol(:,i+1)=yvalstrue(:,2);

    
end

plt=1;

if plt==1
    [max_value_I1 max_idx_I1]=max(ym1);
    [max_value_I2 max_idx_I2]=max(ym2);

    figure('Renderer', 'painters', 'Position', [10 10 900 400])
    grid on
    hold on
    g1=plot(ym1,'LineWidth',2);
    g2=plot(ym2,'LineWidth',2);
    g3=plot(sol(2,2:end),'LineWidth',2);
    g4=plot(sol(3,2:end),'LineWidth',2);
    g5=plot(sol(6,2:end),'LineWidth',2);
%     g6=plot(sol(7,2:end),'LineWidth',2);
% 
    u1 = optimal(1);
    u2 = optimal(2);
    u3 = optimal(3);
    s1 = num2str(u1);
    s2 = num2str(u2);
    s3 = num2str(u3);

    s4 = 'u1, u2, u3 = ';
    title_name = strcat('[  ',s4,s1,',',s2,',',s3,']  [','beta1, beta2 =', num2str(beta1(i)),',',num2str(beta2(i)),']');

    a=strcat('CS3_',title_name,'.eps');
    xlim([0 endpoint]);
    legend([g1 g2 g3 g4 g5 ],{'I1','I2','E1','E2','Q'},'Orientation','horizontal','Location','northeast','FontSize',15)
    title(title_name,'FontSize',15)
    ylabel('Number of individuals in each compartment ','FontSize',15)
    xlabel('Time','FontSize',15)
    txt1 = ['\leftarrow Peak = (' num2str(max_idx_I1) ',' num2str(max_value_I1) ')' ];
    txt2 = ['\leftarrow Peak = (' num2str(max_idx_I2) ',' num2str(max_value_I2) ')' ];
    t1 = text(max_idx_I1,max_value_I1,txt1);
    t2 = text(max_idx_I2,max_value_I2,txt2);


  %  saveas(gcf,a,'epsc')
  %  close
end

end
end
end
