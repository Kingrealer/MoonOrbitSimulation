se = 10;	%���վ���
em = 1; 	%���¾���

%ά�ֱ�������

earth_ang_speed = 1 / 365;	%����ת���ٶ�
moon_ang_speed = 1 / 30;      %����ת���ٶ�

sun = [0 0 0];
earth = [10 0 0];
moon = [11 0 0];

accuracy = 2400;

e_rad = 0;      %���򻡶ȳ�ʼΪ0
m_rad = 0;      %���򻡶ȳ�ʼΪ0

n=[5 5 1];      %������ƽ�淨����n

Fig = figure;



filename = 'moon_orbit2.gif';

plot3(0, 0, 0, 'ro')
hold on

for i=1:accuracy
    
    axis equal;     %����ȱ���
    
    e_rad = e_rad + earth_ang_speed ;
    earth = [se * cos(e_rad) se * sin(e_rad) 0];
    
    m_rad = m_rad + moon_ang_speed;
    
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
    
    x = c1 + em * a(1) * cos(m_rad) + em * b(1) * sin(m_rad);      %Բ�ϸ����x����
    y = c2 + em * a(2) * cos(m_rad) + em * b(2) * sin(m_rad);      %Բ�ϸ����y����
    z = c3 + em * a(3) * cos(m_rad) + em * b(3) * sin(m_rad);      %Բ�ϸ����z����
    
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