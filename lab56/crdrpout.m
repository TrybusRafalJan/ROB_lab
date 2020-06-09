function [dropout_layer] = crdrpout(size, dropout)
% generates dropout layer of given size and probaility
% dropout probability

% hl - hidden layer weight matrix
% ol - output layer weight matrix

% ATTENTION: we assume that constant value IS NOT INCLUDED

  dropout_layer = ones(1, size);
  
  for i = 1:size;
    random = rand(1);
    if random < dropout
      dropout_layer(i) = 0;
    else
      dropout_layer(i) = 1./(1-dropout);
    endif
  endfor
