sea = 10;	%������Բ����a����
seb = 5;	%������Բ������b����
secc = sqrt(sea.^2 - seb.^2);
ema = 4; 	%������Բ����a����
emb = 3; 	%������Բ����b����
emc = sqrt(ema.^2 - emb.^2);

%ά�ֱ�������

earth_ang_speed = 1 / 365;	%����ת���ٶ�
moon_ang_speed = 1 / 30;      %����ת���ٶ�

sun = [0 0 0];
earth = [10 0 0];
moon = [11 0 0];

accuracy = 2400;

e_rad = 0;      %���򻡶ȳ�ʼΪ0
m_rad = 0;      %���򻡶ȳ�ʼΪ0

n=[5 10 1];      %������ƽ�淨����n

ii = n(1, 1);
jj = n(1, 2);
kk = n(1, 3);

Fig = figure;



filename = 'moon_orbit3.gif';

plot3(-secc, 0, 0, 'ro')
hold on

for i=1:accuracy
    
    axis equal;     %����ȱ���
    
    e_rad = e_rad + earth_ang_speed;
    earth = [sea * cos(e_rad) seb * sin(e_rad) 0];
    
    m_rad = m_rad + moon_ang_speed;
    
    a = cross(n, [1 0 0]); 
    if ~any(a)      %���aΪ����������n��j���
        a = cross(n, [0 1 0]);
    end
    
    b = cross(n, a);        %��ȡb����
    a = a / norm(a);        %��λ��a����
    b = b / norm(b);        %��λ��b����
    
    
    ii = a(1, 1);
    jj = a(1, 2);
    kk = a(1, 3);
    
    earth11 = earth(1, 1);
    earth12 = earth(1, 2);
    earth13 = earth(1, 3);
    
    r = emc;
    
    xx = (-earth12*ii+earth11*jj+(earth12*ii^3)/(ii^2+jj^2+kk^2)+(earth12*ii*jj^2)/(ii^2+jj^2+kk^2)+(earth12*ii*kk^2)/(ii^2+jj^2+kk^2)-(ii*sqrt(ii^2*jj^2*r^2+jj^4*r^2+jj^2*kk^2*r^2))/(ii^2+jj^2+kk^2))/jj;
    yy = (earth12*ii^2+earth12*jj^2+earth12*kk^2-sqrt(ii^2*jj^2*r^2+jj^4*r^2+jj^2*kk^2*r^2))/(ii^2+jj^2+kk^2);
    zz = -((-earth13*jj+earth12*kk-(earth12*ii^2*kk)/(ii^2+jj^2+kk^2)-(earth12*jj^2*kk)/(ii^2+jj^2+kk^2)-(earth12*kk^3)/(ii^2+jj^2+kk^2)+(kk*sqrt(ii^2*jj^2*r^2+jj^4*r^2+jj^2*kk^2*r^2))/(ii^2+jj^2+kk^2))/jj);
    
    
    c1 = xx * ones(size(m_rad, 1), 1);
    c2 = yy * ones(size(m_rad, 1), 1);
    c3 = zz * ones(size(m_rad, 1), 1);
    
     
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