function res = actdf(sfvalue)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!!!)

  #expo = exp(-sfvalue);
  #res = expo./((1 + expo).^2);

  #expo = exp(-sfvalue);
  #res = 2*expo./((1 + expo).^2);
  
  res = 1./(sfvalue.^2 + 1);
  
	#res = ones(size(sfvalue));

