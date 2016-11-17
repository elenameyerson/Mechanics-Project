clear
clf
p = 1.2;
C = .3;
A = .0043;
m = .145;
g = 9.8;
r = .037;
I = 2/5  * m * r ^2;
revmin = -2500;
s = revmin / 60;
Cl = .15;
distancehome = 18.4;
shoulderheight = 1.47;
%G = 4 / 3 * 4 * pi ^ 2 * (r ^ 3) * s * p * Vtot)/m;



tp0 =.2;
tp = .002;
tp2 = .001;
offset0 = 10;
offset1 = - pi / 24;


for k = offset0 + tp0: tp0: 50
    
    currentamount0 = (k - offset0)/tp0;
    currentamount0 = round(currentamount0);

    Vinit(currentamount0) = k;

    
    for i = offset1 + tp:tp: (pi/12)
        x = 0;
        y = 2;



        currentamount = (i - offset1)/tp;
        currentamount = round(currentamount);


        theta(currentamount) = i - tp;

        Vx = cos(theta(currentamount)) * Vinit(currentamount0);
        Vy = sin(theta(currentamount)) * Vinit(currentamount0);
        Vyi = sin(theta(currentamount)) * Vinit(currentamount0);
        x = x + tp2 * Vx;
        y = y + tp2 * Vy;
       
        s = revmin / 60;
        for j = tp2 + tp2:tp2:50

            currentamount2 = (j)/tp2;
            currentamount2 = round(currentamount2);
            pastamount2 = (j)/tp2 - 1;
            pastamount2 = round(pastamount2);
            Vtot = sqrt(Vx^2 + Vy^2);

            Gx = Cl * (4 / 3 * 4 * pi ^ 2 * (r ^ 3) * s * p * Vx)/m;
            Gy = Cl * (4 / 3 * 4 * pi ^ 2 * (r ^ 3) * s * p * Vy)/m;
            s = s - s * .01 * tp2;
            if s < 0
                s=0;
            end
            Vy = Vy - g * tp2 - (1/2 * p * C * A * (Vtot ^2) * (Vy / Vtot) * tp2)/m + Gx * tp2;

            Vx = Vx - (1/2 * p * C * A * (Vtot ^2) * (Vx / Vtot) * tp2)/m - Gy * tp;
            x = x + tp2 * Vx;
            y = y + tp2 * Vy;

            if x > distancehome && x < distancehome + .1 
                
                if y < shoulderheight || y > shoulderheight + .1
                    
                    t(currentamount0,currentamount) = 0;
                    break;
                end
                    
               
                
                
                
                    
                
                
                
            end
            if x > distancehome + 1.5
                        if y < shoulderheight
                            t(currentamount0,currentamount) = 1000 * (shoulderheight - y);
                        end



                        break;
            end
            
          

        end

    end
end
pcolor(Vinit,theta,t.')