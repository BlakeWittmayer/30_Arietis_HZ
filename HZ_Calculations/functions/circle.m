function circle(x,y,r,color)
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp,LineWidth=1,Color=color);
end
