%Aufgabe aus letztem ?ungsblatt:
x=[-1,1,2]
f=[2,6,4] 
%L?sung: a = 2, 2, -4/3

%Beispielwerte aus dem Internet
x2=[1,2,3,4]
f2=[2,3,1,3]
%L?sung: a = 2, 1, -1.5, 7/6

disp(Horner2(x2,DivDiff(x2,f2)));
DivDiff(x, f);




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

function y = Horner2(x,a)

	anzahlDerAs = size(a,2);

	for i=1:anzahlDerAs
		y(i) = HornerRecursive(x,a,1,x(i));
	end
end

function y = HornerRecursive(x,a,recStep,xToEval)
	if (recStep > size(a,2))
		y = 1;
	else
		y = a(recStep) + (xToEval - x(recStep)) * HornerRecursive(x,a,recStep+1, xToEval);
	end
end

function denom = deNenominator(x, step)
	denom = 1;

	for i=1:step-1
		denom = denom * (x(step) - x(i))
	end

end

