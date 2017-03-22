%{
Pick the trellises wanted for the other simulations by commenting in
the corresponding trellisList (+ codeLabels for plot).
%}

%% The trellises from the assigment.
trellis1 = poly2trellis(7,{'1 + x + x^2 + x^3 + x^6', '1 + x^2 + x^3 + x^5 + x^6'});
trellis2 = poly2trellis(4,{'1 + x^2 + x^3', '1 + x + x^3', '1+x+x^2+x^3'});
trellis3 = poly2trellis(3,{'1 + x^2', '1+x+x^2','1+x+x^2','1+x+x^2'});
% 
% trellisList = [trellis1,trellis2,trellis3];
% trellisCodeLabels = [string('$C_{1}(2,1,6)$'),string('$C_{2}(3,1,3)$'),string('$C_{3}(4,1,2)$')];

%% Extra trellises with code rate 1/2:
trellis4 = poly2trellis(4,{'1 + x^2 + x^3', '1+x+x^2+x^3'});
trellis5 = poly2trellis(3,{'1 + x^2', '1+x+x^2'});
% 
% trellisList = [trellis1,trellis4,trellis5];
% trellisCodeLabels = [string('$C_{1}(2,1,6)$'),string('$C_{4}(2,1,3)$'),string('$C_{5}(2,1,2)$')];

%% Extra trellises with code rate 1/3:
trellis6 = poly2trellis(7,{'1 + x + x^2 + x^3 + x^6', '1 + x^2 + x^3 + x^5 + x^6','1 + x + x^2 + x^3 + x^4 + x^5 + x^6'});
trellis7 = poly2trellis(3,{'1 + x^2', '1+x+x^2','1+x+x^2'});

% trellisList = [trellis2,trellis6,trellis7];
% trellisCodeLabels = [string('$C_{2}(3,1,3)$'),string('$C_{4}(3,1,6)$'),string('$C_{5}(3,1,2)$')];

%% Extra trellises with code rate 1/4:
trellis8 = poly2trellis(7,{'1 + x + x^2 + x^3 + x^6','1 + x + x^3 + x^4 + x^6', '1 + x^2 + x^3 + x^5 + x^6','1 + x + x^2 + x^3 + x^4 + x^5 + x^6'});
trellis9 = poly2trellis(4,{'1 + x^2 + x^3', '1 + x + x^3', '1+x+x^2+x^3', '1+x+x^2+x^3'});

% trellisList = [trellis3,trellis8,trellis9];
% trellisCodeLabels = [string('$C_{3}(4,1,3)$'),string('$C_{8}(4,1,7)$'),string('$C_{9}(4,1,4)$')];

%% Constant constaint lenght (3), different code rates
% trellisList = [trellis3,trellis5,trellis7];
% trellisCodeLabels = [string('$C_{3}(2,1,3)$'),string('$C_{5}(3,1,3)$'),string('$C_{7}(4,1,3)$')];

%% Constant constraint lenght (4), different code rates
trellisList = [trellis2,trellis4,trellis9];
trellisCodeLabels = [string('$C_{2}(3,1,3)$'),string('$C_{4}(2,1,3)$'),string('$C_{9}(4,1,3)$')];

%% Constant constraint lenght (7), different code rates
% trellisList = [trellis1,trellis6,trellis8];
% trellisCodeLabels = [string('$C_{1}(2,1,7)$'),string('$C_{6}(3,1,7)$'),string('$C_{8}(4,1,7)$')];

%% Prints free distance:
for i=1:3
    distspec(trellisList(i))
end