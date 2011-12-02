classdef RidgeRegressionModel < ClassficationModel
    
    properties (Access = private)
        beta
    end
    
    methods
        function obj = RidgeRegressionModel(fea, gnd, opts)  
            obj = obj@ClassficationModel(fea, gnd);
            ncates = length(unique(gnd));
            
            
            Y = zeros(obj.n, ncates);
            for i = 1:obj.n
                Y(i,gnd(i)) = 1;
            end
            X = fea;
            obj.beta = (X'*X + opts.lambda * eye(obj.m))\X'*Y;
        end
        
        function cls = predict(obj, samples)  % predict classes for given test samples
            rst = samples * obj.beta;
            nsample = size(samples, 1);
            cls = zeros(nsample, 1);
            for i = 1:nsample
                [dummy cls(i)] = max(rst(i,:));
            end
        end
        
    end
    
    methods (Access = protected)
        function predict_one(obj, sample)
        end
    end
end


