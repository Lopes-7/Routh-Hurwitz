function [linha3] = proximalinha (linha1, linha2)

i = 1:1:length(linha1) - 1;
resultado(i) = (linha2(1)*linha1(1+i)- linha2(i+1)*linha1(1))/linha2(1);

linha3 = [resultado, 0];
end
