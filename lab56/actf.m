function res = actf(tact)
% sigmoid activation function
% tact - total activation 
	
  # res = 1./(1 + exp(-tact));
  
  # res = 2./(1 + exp(-tact)) - 1;
  
  res = atan(tact);
  
	%res = tact;
	% linear function is not what Tiggers like best