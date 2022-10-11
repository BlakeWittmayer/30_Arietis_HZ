function genPlot(d_in,z_in,z_out,n,a)
% Calculate RHL's
t = linspace(0,2*pi,n);

RHZ_in = max(abs(z_in(1,1:n)));                         % Equation (39a)
RHZ_out = min(abs(z_out(1,1:n)));                       % Equation (39b)
R = RHZ_out.*ones(length(t),1);
r = RHZ_in.*ones(length(t),1);

fprintf("RHZ inner limit = %.4f\n",RHZ_in);
fprintf("RHZ outer limit = %.4f\n",RHZ_out);

% Generate plot
phi = linspace(0,pi,n);
polarplot(phi,d_in,'--k','LineWidth',1.5);
hold on
polarplot(phi,z_in,'-r');
polarplot(phi,z_out,'-b');
polarplot(pi,a,'.',Color='#EDB120',MarkerSize=30);
polarplot(0,a,'.',Color='#EDB120',MarkerSize=15);
text(pi,a,'Ba',HorizontalAlignment='center', ...
    VerticalAlignment='top');
text(0,a,'Bb',HorizontalAlignment='center', ...
    VerticalAlignment='top');

polarplot(phi,-d_in,'--k',Linewidth=1.5);

polarplot(t,R,Color='#808080');
polarplot(t,r,Color='#808080');

polarplot(pi,RHZ_in,'diamond',Color='r',MarkerFaceColor='r');
polarplot(0,RHZ_out,'diamond',Color='b',MarkerFaceColor='b');

% polarplot(phi,d_out,'--b'); % Outer stability limit, unused
hold off
end
