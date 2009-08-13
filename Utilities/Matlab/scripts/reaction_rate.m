% McGrattan
% 8-10-09
% reaction_rate.m
%
% input:
% T = Temperature (K)
% Y = mass fraction
%
% output:
% r = Reaction rate
%

function r = reaction_rate(T,Y)

dTdt = 5./60.;
R0 = 8314.3;
T_0 = 300.+273.;
delta_T = 80.;
r_0=2*dTdt/delta_T;
E=r_0*R0*T_0*T_0/(dTdt*0.4);
A=(E./(R0.*T_0.*T_0))*dTdt*exp(E./(R0.*T_0));

r = -A.*Y*exp(-E./(R0.*T))./dTdt;

