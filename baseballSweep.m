clf
clear
a = 0;
b = 0;
for i = 1.007:.01:1.225
    b = b + 1;
    a = 0;
    
    for j = 32.6:.1:36.6
        
        a= a + 1;
        res = baseballPitch(i, j)
       
        speed(a) =j;
       
            strike(b,a) = abs(.56-res(1));
            
            density(b) = i;
       
        %}
    end
    
end
 

 pcolor(speed,density,  strike,[.56]);

