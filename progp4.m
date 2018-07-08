f = @(x)cos(x).*exp(sin(x));

quadratur(0,3,50,f,"Simpsonregel");

%quadratur(0,3,50,@(x)x,"Simpsonregel")

%integral_0^3 cos(x) e^sin(x) dx = e^sin(3) - 1≈0.15156
quad_plot(0,3,f)


function quad_plot(a,b,f)
	g = @(x)1/10.*x;
	h = @(x)x.^3;
	global genaueLoesung,g,h;

	N = [2,4,8,16,32,64];
	rechteckErgebnisse = [];
	trapezErgebnisse = [];
	simpsonErgebnisse = [];
	genaueLoesung = vpa(integral(f,a,b));

	for index = 1:numel(N)
		rechteckErgebnisse = [rechteckErgebnisse, quadratur(a,b,N(index),f,"Rechtecksregel")]
		trapezErgebnisse = [trapezErgebnisse, quadratur(a,b,N(index),f,"Trapezregel")]
		simpsonErgebnisse = [simpsonErgebnisse, quadratur(a,b,N(index),f,"Simpsonregel")]
	end

	x = (b-a)./N;

	rechteckFehler = calculateQuadError(rechteckErgebnisse);
	trapezFehler = calculateQuadError(trapezErgebnisse);
	simpsonFehler = calculateQuadError(simpsonErgebnisse);

	gFunction = g(x);
	hFunction = h(x);

	loglog(x,rechteckFehler, x,trapezFehler, x, simpsonFehler, x, gFunction, x, hFunction, '-s');
	%loglog(x,trapezFehler,'-s');
	%loglog(x,simpsonFehler,'-s');
	xlabel('Intervallgröße');
	ylabel('Fehler');
	grid on;


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

function quadError = calculateQuadError(quadValues)
	global genaueLoesung;
	quadError = [];
	for index = 1:numel(quadValues)
		quadError = [quadError, abs(genaueLoesung - quadValues(index)/genaueLoesung)];
	end
end