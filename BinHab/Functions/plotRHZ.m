function plotRHZ(z_in,z_out,n)
phi = 0:pi()/n:pi()/2-pi()/n;
theta = 0:pi()/n:pi()-pi()/n;
rhz = zeros(1,4);
in = z_in(1,1:length(phi));
out = z_out(2,1:length(phi));
rhz(1) = max(abs(in));
rhz(3) = min(abs(out));
rhz(2) = find(in(1,:) == rhz(1));
rhz(4) = find(out(1,:) == rhz(3));
polarplot(theta(rhz(2)),rhz(1),'diamond','Color','b','MarkerFaceColor','b');
polarplot(theta(rhz(4)),rhz(3),'diamond','Color','r','MarkerFaceColor','r');
end
