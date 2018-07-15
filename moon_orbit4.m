sea = 12;	%地日椭圆长轴a参数
seb = 6;	%地日椭圆短轴轴b参数
secc = sqrt(sea.^2 - seb.^2);
ema = 6; 	%地月椭圆长轴a参数
emb = 4; 	%地月椭圆短轴b参数
emc = sqrt(ema.^2 - emb.^2);


%维持比例即可

earth_ang_speed =  2 * pi / 3650;	%地球公转角速度
moon_ang_speed = 2 * pi / 300;      %月球公转角速度

earth = [12 0 0];
moon = [6 0 0];
moon0 = moon;

accuracy = 3000;

e_rad = 0;      %地球弧度初始为0
m_rad = 0;      %月球弧度初始为0

n=[2 3 1];      %月球轨道平面法向量n

Fig = figure;



filename = 'moon_orbit4.gif';

plot3(-secc, 0, 0, 'ro')
hold on

e_rad = e_rad + earth_ang_speed;
m_rad = m_rad + moon_ang_speed;

for i=1:accuracy
    
    axis equal;     %坐标等比例
    
    earth0 = earth;
    
    earth = [sea * cos(e_rad) seb * sin(e_rad) 0];
    s_sec = 0;      %扇形面积
    
    while (s_sec < pi * sea * seb / 3650)
        e_rad = e_rad + earth_ang_speed;
        earth = [sea * cos(e_rad) seb * sin(e_rad) 0];
%         i;
        s_sec = fpoint_sec_area(sea, seb, earth0(1, 1), earth0(1, 2), earth(1, 1), earth(1, 2), 0.00001);
    end
    e_rad = e_rad - earth_ang_speed;
    
    
    moon = [ema * cos(m_rad) emb * sin(m_rad) 0];
    s_sec = 0;      %扇形面积
    
    while (s_sec < pi * ema * emb / 300)
        m_rad = m_rad + moon_ang_speed;
%         m_rad
%         moon0;
        moon = [ema * cos(m_rad) emb * sin(m_rad) 0];
%         i;
        s_sec = fpoint_sec_area(ema, emb, moon0(1, 1), moon0(1, 2), moon(1, 1), moon(1, 2), 0.00001);
    end
    
    moon0 = moon;
    
    
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
    
    x = c1 + ema * a(1) * cos(m_rad) + emb * b(1) * sin(m_rad);      %圆上各点的x坐标
    y = c2 + ema * a(2) * cos(m_rad) + emb * b(2) * sin(m_rad);      %圆上各点的y坐标
    z = c3 + ema * a(3) * cos(m_rad) + emb * b(3) * sin(m_rad);      %圆上各点的z坐标
    
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