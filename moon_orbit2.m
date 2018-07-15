se = 10;	%地日距离
em = 1; 	%地月距离

%维持比例即可

earth_ang_speed = 1 / 365;	%地球公转角速度
moon_ang_speed = 1 / 30;      %月球公转角速度

sun = [0 0 0];
earth = [10 0 0];
moon = [11 0 0];

accuracy = 2400;

e_rad = 0;      %地球弧度初始为0
m_rad = 0;      %月球弧度初始为0

n=[5 5 1];      %月球轨道平面法向量n

Fig = figure;



filename = 'moon_orbit2.gif';

plot3(0, 0, 0, 'ro')
hold on

for i=1:accuracy
    
    axis equal;     %坐标等比例
    
    e_rad = e_rad + earth_ang_speed ;
    earth = [se * cos(e_rad) se * sin(e_rad) 0];
    
    m_rad = m_rad + moon_ang_speed;
    
    a = cross(n, [1 0 0]); 
    if ~any(a)      %如果a为零向量，将n与j叉乘
        a = cross(n, [0 1 0]);
    end
    
    b = cross(n, a);        %求取b向量
    a = a / norm(a);        %单位化a向量
    b = b / norm(b);        %单位化b向量
    
    c1 = earth(1) * ones(size(m_rad, 1), 1);
    c2 = earth(2) * ones(size(m_rad, 1), 1);
    c3 = earth(3) * ones(size(m_rad, 1), 1);
    
    
    %c1 = earth(1, 1);       %圆心坐标是地球坐标
    %c2 = earth(1, 2);
    %c3 = earth(1, 3);
    
    x = c1 + em * a(1) * cos(m_rad) + em * b(1) * sin(m_rad);      %圆上各点的x坐标
    y = c2 + em * a(2) * cos(m_rad) + em * b(2) * sin(m_rad);      %圆上各点的y坐标
    z = c3 + em * a(3) * cos(m_rad) + em * b(3) * sin(m_rad);      %圆上各点的z坐标
    
    moon = [x y z];
    %moon = moon + earth;
    plot3(earth(1, 1), earth(1, 2), earth(1, 3), 'b.')
    hold on
    plot3(moon(1, 1), moon(1, 2), moon(1, 3), 'g.')
    pause(0.000001)
    
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