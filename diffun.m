function dydt = diffun(~,Equation,para,parameters,optimal)
dydt = zeros(7,1);

%%%% parameters
N=parameters(1);   % the population
Lambda = parameters(2);
sigma1 = parameters(3);
sigma2 = parameters(4);
alpha1 = parameters(5);
alpha2 = parameters(6);
gamma1 = parameters(7);
gamma2 = parameters(8);
theta = parameters(9);
mu = parameters(10);
delta = parameters(11);
nu = parameters(12);


u1 = optimal(1);
u2 = optimal(2);
u3 = optimal(3);


%%% para = [beta1 beta2];


%%% compartments
S=Equation(1);
E1=Equation(2);
E2=Equation(3);
I1=Equation(4);
I2=Equation(5);
Q=Equation(6);
R=Equation(7);



%%% differ equations



%S
dydt(1) = Lambda-(1-u1)*para(1)*I1*S/N-(1-u1)*para(2)*I2*S/N-mu*S+nu*R-u2*S;
%E1
dydt(2) = (1-u1)*para(1)*I1*S/N-(mu+sigma1)*E1;
%E2
dydt(3) = (1-u1)*para(2)*I2*S/N-(mu+sigma2)*E2;
%I1
dydt(4) = sigma1*E1-(delta+mu+alpha1*u3+gamma1)*I1;
%I2
dydt(5) = sigma2*E2-(delta+mu+alpha2*u3+gamma2)*I2;
%Q
dydt(6) = alpha1*u3*I1+alpha2*u3*I2-(mu+theta)*Q;
%R
dydt(7) = theta*Q+gamma1*I1+gamma2*I2-(nu+mu)*R+u2*S;
