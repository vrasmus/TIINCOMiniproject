trellis1 = poly2trellis(7,{'1 + x + x^2 + x^3 + x^6', '1 + x^2 + x^3 + x^5 + x^6'});
trellis2 = poly2trellis(4,{'1 + x^2 + x^3', '1 + x + x^3', '1+x+x^2+x^3'});
trellis3 = poly2trellis(3,{'1 + x^2', '1+x+x^2','1+x+x^2','1+x+x^2'});
trellisList = [trellis1,trellis2,trellis3];

for i=1:3
    distspec(trellisList(i));
end
