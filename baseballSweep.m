a = 0;
b = 0;
for i = 1.007:.01:1.225
    b = b + 1;
    for j = 32.6:.1:36.6
        
        a= a + 1;
        res = baseballPitch(i, j)
        if (res(1) < .56 || res(1) < 1.56 )
            strike(b,a) = 1;
        else
            strike(b,a) = abs(.56-res(1));
        end
    end
    
end
        

 
 pcolor(strike)