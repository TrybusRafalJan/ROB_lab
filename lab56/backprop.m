function [hidlw outlw terr] = backprop(tset, tslb, inihidlw, hiddrpout, inioutlw, lr)
% derivative of sigmoid activation function
% tset - training set (every row represents a sample)
% tslb - column vector of labels 
% inihidlw - initial hidden layer weight matrix
% inioutlw - initial output layer weight matrix
% lr - learning rate

% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix
% terr - total squared error of the ANN

% 1. Set output matrices to initial values
	hidlw = inihidlw;
	outlw = inioutlw;
	
% 2. Set total error to 0
	terr = 0;
	
  class_cnt = size(unique(tslb));
  
% foreach sample in the training set
		for i=1:rows(tset)
    
    #disp(i)
    % 3. Set desired output of the ANN (it depends on actf you use!)
    
    real_out = -ones(1, class_cnt);
    real_out(tslb(i)) = 1;

    % 4. Propagate input forward through the ANN

    hidL_activ = [tset(i, :) 1] * hidlw;
    hidL_activ_sig = [actf(hidL_activ).*hiddrpout 1];
    outL_activ = hidL_activ_sig * outlw;
    outL_activs_sig = actf(outL_activ);

    % 5. Adjust total error
    
    err_diffs = real_out - outL_activs_sig;
    errors = 0.5.*(err_diffs).^2;
    terr += sumsq(errors);
    
    % 6. Compute delta error of the output layer
    dOutErrSig = -(err_diffs); 
    dOutSigNet = actdf(outL_activ);
    
    delta = dOutErrSig.*dOutSigNet;
    
    dOutNetW = hidL_activ_sig';
    derivOutErrW = dOutNetW*delta;
        
    % 7. Compute delta error of the hidden layer
    derivErrSig = sum(outlw.*delta, 2)'(1:end-1);            
    derivSigNet = actdf(hidL_activ);
    derivNetW = [tset(i, :) 1]';
        
    derivHidErrW = derivNetW*(derivErrSig.*derivSigNet);
    
    outlw -= derivOutErrW.*lr;
    hidlw -= derivHidErrW.*lr;
    
	end
