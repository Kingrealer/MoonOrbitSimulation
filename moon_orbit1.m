se = 10;	%地日距离
em = 1;	%地月距离

%earth_ang_speed = 2 * pi / (365 * 24 * 60 * 60); %地球公转角速度
%moon_ang_speed = 2 * pi / (30 * 24 * 60 * 60);   %月球公转角速度

%维持比例即可

earth_ang_speed = 1 / 365; %地球公转角速度
moon_ang_speed = 1 / 30;   %月球公转角速度

sun = [0 0];
earth = [10 0];
moon = [11 0];

accuracy = 2400;

e_rad = 0;   %地球弧度初始为0
m_rad = 0;   %月球弧度初始为0

Fig = figure;

filename = 'moon_orbit1.gif';

plot(0, 0, 'ro')
hold on

for i=1:accuracy
    
    axis equal;     %坐标等比例
    
    e_rad = e_rad + earth_ang_speed;
    earth = [se * cos(e_rad) se * sin(e_rad)];
    m_rad = m_rad + moon_ang_speed;
    moon = [em * cos(m_rad) em * sin(m_rad)];
    moon = moon + earth;
    plot(earth(1, 1), earth(1, 2), 'b.')
    hold on
    plot(moon(1, 1), moon(1, 2), 'g.')
    pause(0.0001)
    
    %生成gif
    
    frame = getframe(Fig); 

    im = frame2im(frame); 

    [imind,cm] = rgb2ind(im,256);

    if i == 1

        imwrite(imind,cm,filename,'gif','WriteMode','overwrite', 'Loopcount',inf);

   else

        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.02);

   end
end
