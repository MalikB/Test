%{
solve equations:

%}
syms x y;
%sym f(x);
f(x) = 5*x+9;
vpasolve(3==f, x)
% vpasolve(f, x) solves for 0

sym g(x);
g(x) = 9*x - 14;
vpasolve(g==f)

sym h(x, y);
h(x,y) = x + y;
vpasolve(3==h, x)

syms x y z
eqn1 = 2*x + y + z == 2;
eqn2 = -x + y - z == 3;
eqn3 = x + 2*y + 3*z == -10;

sol = solve([eqn1, eqn2, eqn3], [x, y, z]);
xSol = sol.x
ySol = sol.y
zSol = sol.z