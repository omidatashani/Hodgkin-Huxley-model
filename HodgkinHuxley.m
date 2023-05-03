simulationTime = 100; 
deltaT=.01;
t=0:deltaT:simulationTime;

changeTimes = [0]; 
currentLevels = [10]; 

I(1:numel(t)) = currentLevels;

gbar_K=36; gbar_Na=120; g_L=.3;
E_K = -12.14; E_Na=115.17; E_L=10.58;
C=1;

V=0;
alpha_n = .01 * ( (10-V) / (exp((10-V)/10)-1) ); 
beta_n = .125*exp(-V/80); 
alpha_m = .1*( (25-V) / (exp((25-V)/10)-1) ); 
beta_m = 4*exp(-V/18); 
alpha_h = .07*exp(-V/20); 
beta_h = 1/(exp((30-V)/10)+1); 

n(1) = alpha_n/(alpha_n+beta_n); 
m(1) = alpha_m/(alpha_m+beta_m); 
h(1) = alpha_h/(alpha_h+beta_h); 

for i=1:numel(t)-1 
    
    alpha_n(i) = .01 * ( (10-V(i)) / (exp((10-V(i))/10)-1) );
    beta_n(i) = .125*exp(-V(i)/80);
    alpha_m(i) = .1*( (25-V(i)) / (exp((25-V(i))/10)-1) );
    beta_m(i) = 4*exp(-V(i)/18);
    alpha_h(i) = .07*exp(-V(i)/20);
    beta_h(i) = 1/(exp((30-V(i))/10)+1);
    
    I_Na = (m(i)^3) * gbar_Na * h(i) * (V(i)-E_Na); 
    I_K = (n(i)^4) * gbar_K * (V(i)-E_K); 
    I_L = g_L *(V(i)-E_L); 
    I_ion = I(i) - I_K - I_Na - I_L; 
    
    V(i+1) = V(i) + deltaT*I_ion/C;
    n(i+1) = n(i) + deltaT*(alpha_n(i) *(1-n(i)) - beta_n(i) * n(i)); 
    m(i+1) = m(i) + deltaT*(alpha_m(i) *(1-m(i)) - beta_m(i) * m(i)); 
    h(i+1) = h(i) + deltaT*(alpha_h(i) *(1-h(i)) - beta_h(i) * h(i)); 

end

V = V-60;

plot(t,V,'LineWidth',2)
hold on
legend({'voltage'})
ylabel('Voltage (mv)')
xlabel('time (ms)')
title('Voltage over Time in Simulated Neuron')