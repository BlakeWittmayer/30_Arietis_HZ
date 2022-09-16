% Housekeeping
clear; 
clc;
close all

% Input Data
Star.A.Name = '30 Arietis Aa';
Star.A.HZ = HZ_Dist(8647.00,4.165); % HZ distances for 30 Ari Aa [AU]
Star.B.Name = '30 Arietis Ba';
Star.B.HZ = HZ_Dist(6211.27,2.396); % HZ distances for 30 Ari Ba [AU]

% Graphical settings
figure('Name','30 Arietis Habitable Zones','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
tiledlayout(2,1);

% Top plot
nexttile
plot(0,0,'.','Color','#EDB120','MarkerSize',30); % Star at origin
hold on
formatPlot(Star.A);
hold off

% Bottom plot
nexttile
plot(0,0,'.','Color','#EDB120','MarkerSize',30); % Star at origin 
hold on
formatPlot(Star.B);
hold off

function circle(x,y,r,color)
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp,LineWidth=1,Color=color);
end

function formatPlot(s)
title(append(s.Name,' Habitable Zone'));
circle(0,0,s.HZ(1),'#FF0000');
circle(0,0,s.HZ(2),'#EDB120');
circle(0,0,s.HZ(3),'#77AC30');
circle(0,0,s.HZ(4),'#0072BD');
text(s.HZ(1)-0.025,0.15,'Recent Venus','Color','#FF0000','FontSize',15,'HorizontalAlignment','right');
text(s.HZ(2),0.25,'Runaway Greenhouse','Color','#EDB120','FontSize',15);
text(s.HZ(3)-0.025,0.15,'Maximum Greenhouse','Color','#77AC30','FontSize',15,'HorizontalAlignment','right');
text(s.HZ(4),0.25,'Early Mars','Color','#0072BD','FontSize',15);
text(0,0.1,s.Name,'FontSize',15);
ax = gca; % Get handle to current axes.
ax.XAxisLocation = 'origin';
ax.TitleFontSizeMultiplier = 2.25;
ax.YLim = [-0.5 0.5];
ax.XLim = [-0.5 5];
ax.YAxis.Visible = 'off';
ax.FontSize = 15;
xlabel('Astronomical Units [au]','FontSize',15);
end
