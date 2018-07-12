
%%Guilherme Lopes RA168936
%%parametros: 
%%L string que define se e discreto ou continuo
%%v vetor com os coeficientes do polinomio
function [retval] = routh (L, v) 
  ordem = length(v)-1;
  
  %%completa o vetor com zero se necessario
  if mod(ordem+1,2) == 1
    v = [v , 0];
  end

  i_impares = 1:2:ordem+1;
  i_pares = 2:2:ordem+2;
  linhas = ordem+1;
  colunas = ceil((ordem+1)/2);
  t = 1:1:colunas;

  
  %%se a opcao por continua
  if L == 'c' || L == 'C'
    %%calculando tabela de Routh-Hurwitz
    tabela = zeros(linhas,colunas);
    tabela(1,:) = v(i_impares(t));  
    tabela(2,:) = v(i_pares(t));
    %%calcula as linhas seguintes a partir das duas primeiras, com a ajuda da 
    %%rotina proximalinha
    for j = 3:1:linhas
      tabela(j,:) = proximalinha(tabela(j-2,:),tabela(j-1,:));
    end
    
    instavel = 0;
    %%verifica se os elementos da primeira coluna sao positivos
    for j = 1:1:linhas
      if tabela(j,1) <= 0
        instavel = 1;
      end
    end
    if instavel == 0
      printf('O sistema e estavel\n')
    else
      printf('O sistema e instavel\n')
    end
    [retval] = instavel;

    
  %%se a opcao for discreto e preciso calcular o polinomio equivalente
  elseif L == 'd' || L == 'D'
    o = ordem+1;
    polinomio = zeros(1,o);
    
    %%o polinomio equivalente e obtido substituindo z por (s+1)/(-s+1)
    %%assim o minimo multiplo comum dos termos sera (-s+1)^ordem-1
    %%para calcular os termos do polinomio basta fazer convlucao entre os
    %%coeficientes.
    for i = 1:1:o
      %%a calcula a potencia de (s+1) : (s+1)^i
      a = tpascal(o-i,1);
      %%b calcula a potencia de (-s+1): (-s+1)^i
      b = tpascal(i-1,-1);
      %% c = v(i)*(s+1)^i*(-s+1)^i 
      c = conv(v(i),a);
      c = conv(c,b);
      %%c e um vetor com os coeficientes de cada potencia
      for j = 1:1:o
        %%soma-se os coeficientes de cada potencia em um vetor
        polinomio(j) = polinomio(j)+c(j);
      end
     end
     %%depois que o polinomio equivalente esta pronto basta chamar esta rotina
     %%passando como parametros 'c' para ser tratado como um polinomio continuo
     %%e o proprio polinomio equivalente
     printf('O polinomio continuo equivalente:\n')
     polinomio
     routh('c',polinomio)
  
  else
    printf("Opcao invalida: o primeiro parametro deve ser 'C' ou 'D'\n")
    return
  end
end
