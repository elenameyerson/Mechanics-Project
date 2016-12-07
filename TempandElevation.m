clf;
clear;
a = 0;
b = 0;
tp = 50
tp2 = 1
for i = 0 : tp : 1700
    a = a+1;
    b =0;
    elevation(a) = i;
    for j = 0 + 273.15 : tp2 : 35 + 273.15
        b = b+1;
        temp(b) = j;
        P = ((1+ ((.0065 * elevation(a))/temp(b))) ^ 5.252) / 101300
        P = 1/P
        density = P/(287.05*temp(b));
        velocity(a,b) = 5.31 * density + 28.55; 
    end
end
velocity = velocity * 2.236;

temp = temp - 273.15
temp = (temp * 1.8) + 32

elevation = elevation * 3.28
pcolor( elevation,temp,velocity.')
ylabel('Tempurature (F)')
xlabel('Altitude (feet)')
c = colorbar;
c.Label.String = 'Velocity (mph)';