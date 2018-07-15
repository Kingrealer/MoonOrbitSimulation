se = 10;	%���վ���
em = 1;	%���¾���

%earth_ang_speed = 2 * pi / (365 * 24 * 60 * 60); %����ת���ٶ�
%moon_ang_speed = 2 * pi / (30 * 24 * 60 * 60);   %����ת���ٶ�

%ά�ֱ�������

earth_ang_speed = 1 / 365; %����ת���ٶ�
moon_ang_speed = 1 / 30;   %����ת���ٶ�

sun = [0 0];
earth = [10 0];
moon = [11 0];

accuracy = 2400;

e_rad = 0;   %���򻡶ȳ�ʼΪ0
m_rad = 0;   %���򻡶ȳ�ʼΪ0

Fig = figure;

filename = 'moon_orbit1.gif';

plot(0, 0, 'ro')
hold on

for i=1:accuracy
    
    axis equal;     %����ȱ���
    
    e_rad = e_rad + earth_ang_speed;
    earth = [se * cos(e_rad) se * sin(e_rad)];
    m_rad = m_rad + moon_ang_speed;
    moon = [em * cos(m_rad) em * sin(m_rad)];
    moon = moon + earth;
    plot(earth(1, 1), earth(1, 2), 'b.')
    hold on
    plot(moon(1, 1), moon(1, 2), 'g.')
    pause(0.0001)
    
    %����gif
    
    frame = getframe(Fig); 

    im = frame2im(frame); 

    [imind,cm] = rgb2ind(im,256);

    if i == 1

        imwrite(imind,cm,filename,'gif','WriteMode','overwrite', 'Loopcount',inf);

   else

        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.02);

   end
end
