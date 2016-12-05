clf
clear
a = 0;
b = 0;
for i = .47:.005:1.825
    b = b + 1;
    a = 0;
    
    for j = 29.6:.1:40.6
        
        a= a + 1;
        res = baseballPitch(i, j);
       
        %{
        speed(a) =j;
       
            strike(b,a) = abs(.56-res(1));
            
            density(b) = i;
       
        %}
        
        diff(a) = abs(.56-res(1));
        speed(a) = j;
    end
    [~,speedminI(b)] = min(diff);
    speedmin(b) = speed(speedminI(b));
    
    density(b) = i;
end

plot(density,speedmin);
coeffs = polyfit(density, speedmin, 1)
% Get fitted values
fittedX = linspace(min(density), max(density), 200);
fittedY = polyval(coeffs, fittedX);
% Plot the fitted line
hold on;
plot(fittedX, fittedY, 'r-', 'LineWidth', 3);
xlabel('Air Density (kg/m^3)')
ylabel('Baseball Speed (m/s)')
 title('Required Speed to Pass Through Bottom of Strike Zone vs Density')
%{
grid off
 pcolor(density,speed,  strike.');
xlabel('Air Density (kg/m^3)')
ylabel('Baseball Speed (m/s)')
c = colorbar
c.Label.String = 'Distance from bottom of strike zone (m)'
%}
