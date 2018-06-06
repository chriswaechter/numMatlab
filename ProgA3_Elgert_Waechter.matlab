DivDiff([-1, 1, 2], [2, 6, 4])

function a = DivDiff(x,f)

	a(1) = f(1);

	for n=2:length(f)

		for j = 1:n

		end

	end

end

function denom = denominator(x, step)

	denom = x(step) - x(1);

	for i=1:step
		denom = denom * (x(step)-x(i))
	end
end