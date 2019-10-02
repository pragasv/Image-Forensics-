A = 0.6777777
Ndecimals = 1 ;
f = 10.^Ndecimals ; 
A = round(f*A)/f ;

a = regexp(A,'[0].[0-9]+', 'match')
disp(A);