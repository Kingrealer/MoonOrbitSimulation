% 焦点扇形面积
% 以(-c, 0) (x1, y1) (x0, y0) 围成的扇形面积
% accuracy是计算精度
function s = fpoint_sec_area(a, b, x0, y0, x1, y1, accuracy)
%     x0
%     y0
%     x1
%     y1
    
    c = sqrt(a^2 - b^2);
    
    if (x0 >= -c && y0 >= 0 && x1 >= -c && y1 >= 0)
        x = -c:accuracy:x1;
        y = (y1 / (x1 + c)) * (x + c);
        s1 = trapz(x, y, 2);
        x = x1:accuracy:x0;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s2 = trapz(x, y, 2);
        x = -c:accuracy:x0;
        y = (y0 / (x0 + c)) * (x + c);
        s0 = trapz(x, y, 2);
        s = abs(s1 + s2 -s0);
    elseif (x0 >= 0 && y0 >=0  && x1 <= -c && y1 <= 0)
        y0 = abs(y0);
        x = -b:accuracy:x1;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s1 = trapz(x, y, 2);
        x = x1:accuracy:0;
        y = (y1 / (x1 + c)) * (x + c);
        s2 = trapz(x, y, 2);
        x = 0:accuracy:x0;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s3 = trapz(x, y, 2);
        s = abs(s1 + s2 +s3 - x0 * y0 / 2 + pi* a * b / 4);
    elseif (x0 >= -c && y0 >= 0 && x1 <= -c && y1 >= 0)
        x = x1:accuracy:x0;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s0 = trapz(x, y, 2);
        x = x1:accuracy:-c;
        y = (y1 / (x1 + c)) * (x + c);
        s1 = trapz(x, y, 2);
        x = -c:accuracy:x0;
        y = (y0 / (x0 + c)) * (x + c);
        s2 = trapz(x, y, 2);
        s = abs(s0 - s1 - s2);
    elseif (x0 <=-c && y0 >= 0 && x1 <= -c && y1 >= 0)
        x = x1:accuracy:x0;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s1 = trapz(x, y, 2);
        x = x0:accuracy:-c;
        y = (y0 / (x0 + c)) * (x + c);
        s2 = trapz(x, y, 2);
        x = x1:accuracy:-c;
        y = (y1 / (x1 + c)) * (x + c);
        s0 = trapz(x, y, 2);
        s = abs(s1 + s2 -s0);
    elseif (x0 <= -c && y0 >= 0 && x1 <= -c && y1 <= 0)
        y1 = abs(y1);
        x = -b:accuracy:x0;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s1 = trapz(x, y, 2);
        x = x0:accuracy:-c;
        y = (y0 / (x0 + c)) * (x + c);
        s2 = trapz(x, y, 2);
        x = -b:accuracy:x1;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s3 = trapz(x, y, 2);
        x = x1:accuracy:-c;
        y = (y1 / (x1 + c)) * (x + c);
        s4 = trapz(x, y, 2);
        s = abs(s1 + s2 + s3 + s4);
    elseif (x0 <= -c && y0 >= 0 && x1 >= -c && y1 <= 0)
        y1 = abs(y1);
        x = -b:accuracy:x0;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s1 = trapz(x, y, 2);
        x = x0:accuracy:-c;
        y = (y0 / (x0 + c)) * (x + c);
        s2 = trapz(x, y, 2);
        x = -b:accuracy:x1;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s3 = trapz(x, y, 2);
        x = -c:accuracy:x1;
        y = (y1 / (x1 + c)) * (x + c);
        s4 = trapz(x, y, 2);
        s = abs(s1 + s2 + s3 - s4);
    elseif (x0 <=-c && y0 <= 0 && x1 <= -c && y1 <= 0)
        y0 = abs(y0);
        y1 = abs(y1);
        x = x0:accuracy:x1;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s1 = trapz(x, y, 2);
        x = x1:accuracy:-c;
        y = (y1 / (x1 + c)) * (x + c);
        s2 = trapz(x, y, 2);
        x = x0:accuracy:-c;
        y = (y0 / (x0 + c)) * (x + c);
        s0 = trapz(x, y, 2);
        s = abs(s1 + s2 -s0);
    elseif (x0 <= -c && y0 <= 0 && x1 >= -c && y1 <= 0)
        y0 = abs(y0);
        y1 = abs(y1);
        x = x0:accuracy:x1;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s0 = trapz(x, y, 2);
        x = x0:accuracy:-c;
        y = (y0 / (x0 + c)) * (x + c);
        s1 = trapz(x, y, 2);
        x = -c:accuracy:x1;
        y = (y1 / (x1 + c)) * (x + c);
        s2 = trapz(x, y, 2);
        s = abs(s0 - s1 - s2);
    elseif (x0 >= -c && y0 <= 0 && x1 >= -c && y1 <= 0)
        y0 = abs(y0);
        y1 = abs(y1);
        x = -c:accuracy:x0;
        y = (y0 / (x0 + c)) * (x + c);
        s1 = trapz(x, y, 2);
        x = x0:accuracy:x1;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s2 = trapz(x, y, 2);
        x = -c:accuracy:x1;
        y = (y1 / (x1 + c)) * (x + c);
        s0 = trapz(x, y, 2);
        s = abs(s1 + s2 -s0);
    elseif (x0 >= -c && y0 <= 0 && x1 >= -c && y1 >= 0)
        y0 = abs(y0);
        x = x1:accuracy:b;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s1 = trapz(x, y, 2);
        x = -c:accuracy:x1;
        y = (y1 / (x1 + c)) * (x + c);
        s2 = trapz(x, y, 2);
        x = x0:accuracy:b;
        y = b .* sqrt(1 - x.^2 ./ a.^2);
        s3 = trapz(x, y, 2);
        x = -c:accuracy:x0;
        y = (y0 / (x0 + c)) * (x + c);
        s4 = trapz(x, y, 2);
        s = abs(s1 + s2 + s3 + s4);
    end
    
    