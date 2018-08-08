function dbn = pretrain_dnn(dbn, V, opts)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deep Neural Network:                                     %
% Copyright (C) 2013 Masayuki Tanaka. All rights reserved. %
%                    mtanaka@ctrl.titech.ac.jp             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LayerNum = numel( dbn.rbm );
DropOutRate = zeros(LayerNum,1);

X = V;

if( exist('opts' ) )
    if( isfield(opts,'LayerNum') )
        LayerNum = opts.LayerNum;
    end
    if( isfield(opts,'DropOutRate') )
        DropOutRate = opts.DropOutRate;
        if( numel( DropOutRate ) == 1 )
            DropOutRate = ones(LayerNum,1) * DropOutRate;
        end
    end
    
else
    opts = [];
end

for i=1:LayerNum
    opts.DropOutRate = DropOutRate(i);
    dbn.rbm{i} = pretrain_rbm(dbn.rbm{i}, X, opts);
    X0 = X;
    X = v2h( dbn.rbm{i}, X0 );
end
