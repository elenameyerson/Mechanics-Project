%function that calculates and plots the motion of a baseball hit through
%the air towards the stands.

function res = baseballFlight(angle, speed)

%global variables

m = .145;        %kg
g = 9.8;         %m/s^2
Cd = 0.3;        %no units
rho = 1.2;       %kg/m^3
A = .0004;       %m^2
plateDistance = 18.4;%m
catcherDistance = 20.4;
groundHeight = 0;       %m

r = .037; %radius of ball in meters
revmin = 2250; % revolutions per minute
s = revmin / 60; %convert to rev per second
Cl = .15; %magnus coefficient for baseball
shoulderheight = 1.47; %m


%G = Cl * 4 / 3 * 4 * pi ^ 2 * (r ^ 3) * s * p * Vtot)/m; 
% above is the equation for acceleration from magnus affect

realAngle = angle * pi / 180;    %takes input angle and converts to radians

%initial conditions for x and y pos and velocities in x and y directions

xi = 0;
yi = 2;
v_xi = speed * cos(realAngle);
v_yi = speed * sin(realAngle);

%nested function calculates change in position and change in velocity and
%outputs dx/dt, dy/dt, dvx/dt, and dvy/dt for use in ode45

inputs = [xi, yi, v_xi, v_yi,s];

    function res = flowFunc(~, inputs)
    
        x = inputs(1);
        y = inputs(2);
        v_x = inputs(3);
        v_y = inputs(4);
        w = inputs(5);
        v_tot = (sqrt((v_x^2) + (v_y^2)));
        Gx = Cl * (4 / 3 * 4 * pi ^ 2 * (r ^ 3) * w * rho * v_x); %this is magnus force with respect to x, it impacts y
        Gy = Cl * (4 / 3 * 4 * pi ^ 2 * (r ^ 3) * w * rho * v_y); %this is magnus force with respect to y, it impacts x
        Dragx = (-0.5 * Cd * A * rho * ( v_tot^2 ) * (v_x/v_tot));
        Dragy = (-0.5 * Cd * A * rho * ( v_tot^2 ) * (v_y/v_tot));
        accel_x = (Dragx + Gy) / m;
        accel_y = ((-m * g) + Dragy + Gx ) / m;
        dxdt = v_x;
        dydt = v_y;
        changeInW = 0; %w/s ; im leaving it at 0 for now but I may change it if it becomes impactful
        res = [dxdt; dydt; accel_x; accel_y;changeInW];

    end

%ode45 calculates position and velocity at each point for a set amount of
%time using output from flowFunc and plots x and y position using comet function

options = odeset('Events', @events, 'RelTol', 1e-4);

timeStep = [0 10];
[T, R, te, ye, ie] = ode45(@flowFunc, [0, 10] , inputs, options);

ye
clf
 xf = R(:,1);
 yf = R(:,2);
 plot(xf, yf);
 
 hold on
 plot([0 350], [0 0])        %shows y=0 line (ground)
 xlabel('X Position')
 ylabel('Y Position')
 title(['Speed = ', num2str(speed), ', Angle = ', num2str(angle)])
 axes = gca;
 axes.XLim = [0 catcherDistance]; % scale x axis from 0 to the wall
 axes.YLim = [0 3]; % make the axes equal

res = R(end,2);

%events function
    function [value, isterminal, direction] = events(~, inputs)
        x_current = inputs(1);
        y_current = inputs(2);

        value = [y_current * (x_current - plateDistance); x_current - catcherDistance];
        isterminal = [0; 1];
        direction = [0; 0];
    end

end