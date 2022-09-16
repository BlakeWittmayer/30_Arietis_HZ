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
text(-0.25,0.1,s.Name,'FontSize',15);
ax = gca; % Get handle to current axes.
ax.XAxisLocation = 'origin';
ax.TitleFontSizeMultiplier = 2.25;
ax.YLim = [-0.5 0.5];
ax.XLim = [-0.5 5];
ax.YAxis.Visible = 'off';
ax.FontSize = 15;
xlabel('Astronomical Units [au]','FontSize',15);
end
