%%funcao que retorna uma tupla com a n linha do triangulo de pascal
%%0 1
%%1 1 1
%%2 1 2 1
%%3 1 3 3 1
%%4 1 4 6 4 1
%%5 1 5 10 10 5 1
%%6 1 6 15 20 15 6 1
%%7 1 7 21 35 35 21 7 1
%%8 1 8 28 56 70 56 28 8 1
%%9 1 9 36 84 126 126 84 36 9 1
%%10 1 10 45 120 210 252 210 120 45 10 1
function [retval] = tpascal (n,s)
   if n < 0
      printf('O parametro n deve ser maior que 0\n')
      return
   end
   if n == 0
      [retval] = [1];
    elseif n == 1
      [retval] = [s,1];
    else
    v = [1];
      for i = 1:1:n
        v = conv(v,[s,1]);
      end
    [retval] = v;  
    end
end
