clf;
clear;
a = 0;
b = 0;
for i = 0 : tp : 6000
    a = a+1;
    b =0;
    elevation(a) = i;
    for j = 0: tp : 30
        temp(b) = j;
        
        
        
    end
end
P = (((101325(1-2.25577-(10^-5)*elevation))^5.25588)+(0.4*(6.1078*10^((7.5*(temp-273))/(237.3+(temp-273))))))
Pv = (0.4*(6.1078*10^((7.5*(temp-273))/(237.3+(temp-273)))))
density = P/(287.05*temp))*(1-((0.378*Pv)/P))
velocity = 5.14 * density + 28.3;