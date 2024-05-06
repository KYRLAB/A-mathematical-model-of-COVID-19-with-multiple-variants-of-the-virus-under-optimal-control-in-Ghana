function parameters = call_parameters(varargin) % varargin variables indicate "rho"s

% data import
CovidTable = readtable('data/Ghana_only_covid19_data.csv','NumHeaderLines',59);  % skips the first three rows of data
% VaccineData_t = readtable('data/vaccine.csv','NumHeaderLines',1);  % skips the first three rows of data
Vaccine=CovidTable{:,8};



% % parameters
N=33773888;    % the population
Lambda = 2632.70;
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




%%%% parameters
parameters=[N;Lambda;sigma1;sigma2;alpha1;alpha2;gamma1;gamma2;theta;mu;delta;nu];

end