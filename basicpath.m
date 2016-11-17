clear
clf
p = 1.2;
C = .3;
A = .0043;
m = .145;
g = 9.8;
r = .037;
I = 2/5  * m * r ^2;
revmin = 2500;
s = revmin / 60;
Cl = .15;
%G = 4 / 3 * 4 * pi ^ 2 * (r ^ 3) * s * p * Vtot)/m;



Vinit = 50;
tp = pi/12;
tp2 = .01;
theta = pi / 3;



    xi = 0;
    yi = 1;

    
        Vx = cos(theta) * Vinit
        Vy = sin(theta) * Vinit;
        Vyi = sin(theta) * Vinit;
        x(1) = xi + tp2 * Vx;
        y(1) = yi + tp2 * Vy;
    
        for j = tp2 + tp2:tp2:10

            currentamount2 = (j)/tp2;
            currentamount2 = round(currentamount2);
            pastamount2 = (j)/tp2 - 1;
            pastamount2 = round(pastamount2);
            Vtot = sqrt(Vx^2 + Vy^2);

      
            
            Vy = Vy - g * tp2 - (1/2 * p * C * A * (Vtot ^2) * (Vy / Vtot) * tp2)/m;

            Vx = Vx - (1/2 * p * C * A * (Vtot ^2) * (Vx / Vtot) * tp2)/m;
            x(currentamount2) = x(pastamount2) + tp2 * Vx;
            y(currentamount2) = y(pastamount2) + tp2 * Vy;
            if y(currentamount2) <= 0 || x(currentamount2) >= 97
                xfinal = x(currentamount2)
                yfinal = y(currentamount2)
                return
            end
            
           
        end
       
plot(x,y)
title('Path of ball with drag, 45 degrees, and 50 m/s')
xlabel('Distance(meters)')
ylabel('Height(metera)')