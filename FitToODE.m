function solparameter = FitToODE(para,tspan,initial,parameters,optimal)
sol = ode45(@(t,Equation)diffun(t,Equation,para,parameters,optimal),tspan,initial);
solparameter = deval(sol,tspan);
solparameter=solparameter([4,5],:);
end