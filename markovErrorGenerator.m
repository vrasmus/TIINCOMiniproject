function [errors] = markovErrorGenerator(length, p12, p21, eps1, eps2)
%{
length: Length of error vector to be created
p     : Probability of changing states
eps   : Probability of having an "unexpected" result
%}

errors = zeros(length,1);

state = 0;
for i=1:length
    if state == 0
        if rand < eps1
            errors(i) = 1;
        end
        if rand < p12
            state = 1;
        end
    elseif state == 1
        if rand > eps2
            errors(i) = 1;
        end
        if rand < p21
            state = 0;
        end
    end
end