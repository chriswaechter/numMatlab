f = @(x)cos(x).*exp(sin(x));
quadratur(0,3,50,f,"Simpsonregel");

%quadratur(0,3,50,@(x)x,"Simpsonregel")

%integral_0^3 cos(x) e^sin(x) dx = e^sin(3) - 1≈0.15156
quad_plot(0,3,f)

function quad_plot(a,b,f)
	N = [2,4,8,16,32,64];

	for index = numel(N)
		quadratur(a,b,N(index),f,"Rechtecksregel");
		quadratur(a,b,N(index),f,"Trapezregel");
		quadratur(a,b,N(index),f,"Simpsonregel");
	end

end
function integral = quadratur(a,b,N,f,regel)
	integral = 0;
	teilIntervallgroesse = (b-a)/N;

 	for i = 1:N
 		integral = integral + calculateSubIntegral(a+(i-1)*teilIntervallgroesse, a+i*teilIntervallgroesse, f, regel);
 	end
end



function subIntegral = calculateSubIntegral(a,b,f,regel)
	switch regel
		case 'Rechtecksregel'
			subIntegral = (b-a) * f(a);
		case 'Trapezregel'
			subIntegral = (b-a) * (f(a) + f(b))/2;
		case 'Simpsonregel'
			subIntegral = (b-a)/6 * (f(a) + 4*f((a+b)/2) + f(b));
		otherwise
			throwRegelDoesNotExistExeption(regel);
	end

end



function throwRegelDoesNotExistExeption(regel)
	throw(MException('calculateSubIntegral:regel','regel: "%s" does not exist, choose "Rechtecksregel", "Trapezregel", or "Simpsonregel"', regel));
end