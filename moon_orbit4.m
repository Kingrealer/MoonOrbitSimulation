sea = 12;	%������Բ����a����
seb = 6;	%������Բ������b����
secc = sqrt(sea.^2 - seb.^2);
ema = 6; 	%������Բ����a����
emb = 4; 	%������Բ����b����
emc = sqrt(ema.^2 - emb.^2);


%ά�ֱ�������

earth_ang_speed =  2 * pi / 3650;	%����ת���ٶ�
moon_ang_speed = 2 * pi / 300;      %����ת���ٶ�

earth = [12 0 0];
moon = [6 0 0];
moon0 = moon;

accuracy = 3000;

e_rad = 0;      %���򻡶ȳ�ʼΪ0
m_rad = 0;      %���򻡶ȳ�ʼΪ0

n=[2 3 1];      %������ƽ�淨����n

Fig = figure;



filename = 'moon_orbit4.gif';

plot3(-secc, 0, 0, 'ro')
hold on

e_rad = e_rad + earth_ang_speed;
m_rad = m_rad + moon_ang_speed;

for i=1:accuracy
    
    axis equal;     %����ȱ���
    
    earth0 = earth;
    
    earth = [sea * cos(e_rad) seb * sin(e_rad) 0];
    s_sec = 0;      %�������
    
    while (s_sec < pi * sea * seb / 3650)
        e_rad = e_rad + earth_ang_speed;
        earth = [sea * cos(e_rad) seb * sin(e_rad) 0];
%         i;
        s_sec = fpoint_sec_area(sea, seb, earth0(1, 1), earth0(1, 2), earth(1, 1), earth(1, 2), 0.00001);
    end
    e_rad = e_rad - earth_ang_speed;
    
    
    moon = [ema * cos(m_rad) emb * sin(m_rad) 0];
    s_sec = 0;      %�������
    
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
    if ~any(a)      %���aΪ����������n��j���
        a = cross(n, [0 1 0]);
    end
    
    b = cross(n, a);        %��ȡb����
    a = a / norm(a);        %��λ��a����
    b = b / norm(b);        %��λ��b����
    
    c1 = earth(1) * ones(size(m_rad, 1), 1);
    c2 = earth(2) * ones(size(m_rad, 1), 1);
    c3 = earth(3) * ones(size(m_rad, 1), 1);
    
    
    %c1 = earth(1, 1);       %Բ�������ǵ�������
    %c2 = earth(1, 2);
    %c3 = earth(1, 3);
    
    x = c1 + ema * a(1) * cos(m_rad) + emb * b(1) * sin(m_rad);      %Բ�ϸ����x����
    y = c2 + ema * a(2) * cos(m_rad) + emb * b(2) * sin(m_rad);      %Բ�ϸ����y����
    z = c3 + ema * a(3) * cos(m_rad) + emb * b(3) * sin(m_rad);      %Բ�ϸ����z����
    
    moon = [x y z];
    %moon = moon + earth;
    plot3(earth(1, 1), earth(1, 2), earth(1, 3), 'b.')
    hold on
    plot3(moon(1, 1), moon(1, 2), moon(1, 3), 'g.')
    pause(0.000001)
    
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