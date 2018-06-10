%Aufgabe aus letztem ?ungsblatt:
x3=[-1,1,2];
f3=[2,6,4];
%L?sung: a = 2, 2, -4/3

%Beispielwerte aus dem Internet
x4=[1,2,3,4];
f4=[2,3,1,3];
%L?sung: a = 2, 1, -1.5, 7/6

plotCurves();

function plotCurves()
	x=-5:1/100:5;
	j=1;
	for n=4:2:10
		x1 = [];
		f1 = [];

		for k=0:n
			%xNeu = 10*k/n-5; %1. Datensatz
			xNeu = 5*cos((2*k+1)/(2*k+2)*pi); %2. Datensatz
			x1 = [x1, xNeu];
			f1 = [f1, 1/(xNeu^2+1)];
		end
		a1 = DivDiff(x1, f1);
		x1
		f(j,:) = Horner2(x1, a1, x)
		j=j+1;
	end
		plot(x, f(1,:), x, f(2,:), x, f(3,:), x, f(4,:));
end



function a = DivDiff(x,f)
	a(1) = f(1);

	%berechne a_i  's
	for n=2:size(f,2)
		temp = f(n);

		%berechne differenzen: a_0 - a_1*... -a_2* ...
		for j=1:n-1

			produktklammern = 1;
			%berechne produktklammern  (x3 - x1)(x3 - x2)...
			for i=2:j
				produktklammern = (x(n) - x(i-1))*produktklammern;
			end
			temp = temp - produktklammern * a(j);


		end
		a(n) = temp / deNenominator(x, n);
	end
end





function y = Horner(x,a)
    
    temp = a(size(a));
    
    for i = size(a)-1:1
        temp = temp * x +  a(i);
    end
    
    y = temp;
end

function y = Horner2(x,a,xsToEval)

	anzahlDerXs = size(xsToEval,2);

	for i=1:anzahlDerXs
		y(i) = HornerRecursive(x,a,1,xsToEval(i));
	end
end

function y = HornerRecursive(x,a,recStep,xToEval)
	if (recStep > size(a,2))
		y = 1;
	else
		y = a(recStep) + (xToEval - x(recStep)) * (HornerRecursive(x,a,recStep+1, xToEval));
	end
end

function denom = deNenominator(x, step)
	denom = 1;

	for i=1:step-1
		denom = denom * (x(step) - x(i));
	end

end

