plt=1;
% 
% N=33773888;    % the population
% Lambda = 28.452;
% sigma1 = 1/10;
% sigma2 = 1/8;
% alpha1 = 1/4;
% alpha2 = 1/4;
% gamma1 = 1/14;
% gamma2 = 1/20;
% theta = 1/7;
% mu = 0.071855;
% delta = 0.0085;
% nu = 1/90;


% parameters
% N=33773888;    % the population
% Lambda = 2632.70;
sigma1 = 1/10;
sigma2 = 1/8;
alpha1 = 1/4;
alpha2 = 1/4;
gamma1 = 1/14;
gamma2 = 1/20;
theta = 1/7;
mu = 0.0070855;
delta = 0.0085;
nu = 1/90;


if plt==1
    fig1 = figure(1);
    set(fig1, 'OuterPosition', [3, 270, 1000, 420])
    grid on
    hold on
    t = datetime(2020,3,1) + caldays(1:length(ym1));
    tt=datenum(t);
%     ytrue(1:end,3)=ytrue(1:end,1)+ytrue(1:end,2);
    g5=area(tt,ytrue(1:end,1:2),'FaceAlpha',.7,'EdgeAlpha',.8);
%     g5=bar(tt,ytrue(1:end,[1,3]),'FaceAlpha',.7,'EdgeAlpha',0);
    colororder([[0 0.4470 0.7410];[0.9500 0.3250 0.0980]	])
    II=I1+I2;
    g6=plot(tt,II(1:end),'k','LineWidth',1.5);
    
    
    legend([g5 g6],{'Fitted I_1 (Original+Delta)','Fitted I_2 (Omicron)','Real data'})
    title('The daily infection fitting results for each variant in Ghana')
%     xlabel('2020-02-16 ~ 2022-09-05') 
    ylabel('The number of infected indivisuals') 

    datetick('x','mm/dd')

end
plt=0;
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
    
    
    legend([g2 g1 g5],{'I1 (Original+Delta)','I2 (Omicron)','Actual I1','Actual I2'})
    title('Daily infection fitting for each strain in Ghana.')
    ylabel('The number of infected indivisuals') 

%     xlabel('2020-02-16 ~ 2022-09-05') 
    datetick('x','mm/dd')

end

Re1=beta1'*sigma1/(mu+sigma1)/(delta+mu+alpha1+gamma1);
Re2=beta2'*sigma2/(mu+sigma2)/(delta+mu+alpha2+gamma2);
% Re1=movmean(Re1,14);
% Re2=movmean(Re2,14);
AveRe1 = zeros(length(Re1));
AveRe2 = zeros(length(Re2));
Aveday = 14;
 

for i=1:fix(length(Re1)/Aveday)
    AveRe1(Aveday*(i-1)+1) = mean(Re1(Aveday*(i-1)+1:Aveday*(i)));
    AveRe2(Aveday*(i-1)+1) = mean(Re2(Aveday*(i-1)+1:Aveday*(i)));

    AveRe1(Aveday*(i-1)+2:Aveday*(i)) = AveRe1(Aveday*(i-1)+1);
    AveRe2(Aveday*(i-1)+2:Aveday*(i)) = AveRe2(Aveday*(i-1)+1);

end


% figure
% plot(AveRe1)
% hold on 
% plot(AveRe2)
% % plot(AveRe1)

