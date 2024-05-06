function [I1, I2, ytrue]=set_compartsments()

% data import
CovidTable = readtable('data/Ghana_only_covid19_data.csv','NumHeaderLines',59);  % skips the first three rows of data
Vaccine=CovidTable{:,8};

N=33773888;    % the population


date_Cnt=CovidTable{:,1};

I1=CovidTable{:,5};
I2=CovidTable{:,6};

I1=movmean(I1,14);
I2=movmean(I2,14);





pp=csaps(1:length(I1),I1,0.009);
pp2=csaps(1:length(I1),I2,0.009);
ytrue=pp.coefs(:,4);
ytrue2=pp2.coefs(:,4);
% fnplt(pp)
% plot(ytrue)
% plot(I)
% hold on
ytrue(end+1)=sum(pp.coefs(end,:));
ytrue2(end+1)=sum(pp2.coefs(end,:));

ytrue(:,2)=ytrue2;
ytrue(ytrue<0)=0;





end