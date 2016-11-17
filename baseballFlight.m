%function that calculates and plots the motion of a baseball hit through
%the air towards the stands.

function res = baseballFlight(angle, speed)

%global variables

m = .145;        %kg
g = 9.8;         %m/s^2
Cd = 0.3;        %no units
rho = 1.2;       %kg/m^3
A = .0004;       %m^2
wallDistance = 97;      %m
groundHeight = 0;       %m

r = .037;
revmin = -2500;
s = revmin / 60;
Cl = .15;
distancehome = 18.4;
shoulderheight = 1.47;
%G = 4 / 3 * 4 * pi ^ 2 * (r ^ 3) * s * p * Vtot)/m;

realAngle = angle * pi / 180;    %takes input angle and converts to radians

%initial conditions for x and y pos and velocities in x and y directions

xi = 0;
yi = 1;
v_xi = speed * cos(realAngle);
v_yi = speed * sin(realAngle);

%nested function calculates change in position and change in velocity and
%outputs dx/dt, dy/dt, dvx/dt, and dvy/dt for use in ode45

inputs = [xi, yi, v_xi, v_yi];

    function res = flowFunc(~, inputs)
    
        x = inputs(1);
        y = inputs(2);
        v_x = inputs(3);
        v_y = inputs(4);

        accel_x = (-0.5 * Cd * A * rho * ( (v_x^2) + (v_y^2) ) * (v_x/(sqrt((v_x^2) + (v_y^2))))) / m;
        accel_y = ((-m * g) + (-0.5 * Cd * A * rho * ( (v_x^2) + (v_y^2) ) * (v_y/(sqrt((v_x^2) + (v_y^2)))))) / m;
dxdt = v_x;
dydt = v_y;
        res = [dxdt; dydt; accel_x; accel_y];

    end

%ode45 calculates position and velocity at each point for a set amount of
%time using output from flowFunc and plots x and y position using comet function

options = odeset('Events', @events, 'RelTol', 1e-4);

timeStep = [0 10];
[T, R] = ode45(@flowFunc, [0, 10] , inputs, options);

clf
% xf = R(:,1);
% yf = R(:,2);
% plot(xf, yf);
% 
% hold on
% plot([0 350], [0 0])        %shows y=0 line (ground)
% xlabel('X Position')
% ylabel('Y Position')
% title(['Speed = ', num2str(speed), ', Angle = ', num2str(angle)])
% axes = gca;
% axes.XLim = [0 wallDistance]; % scale x axis from 0 to the wall
% axes.YLim = [0 wallDistance]; % make the axes equal

res = R(end,2);

%events function
    function [value, isterminal, direction] = events(~, inputs)
        x_current = inputs(1);
        y_current = inputs(2);

        value = [x_current - wallDistance; y_current - groundHeight];
        isterminal = [1; 1];
        direction = [0; 0];
    end

end