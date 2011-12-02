classdef LinearSVMModel < ClassficationModel
    % k-nearest neighbor classifier
    
    properties (Access = private)
        model  % the svm model
    end
    
    methods
        function obj = LinearSVMModel(fea, gnd, opts)  % initialize kNN model
            obj = obj@ClassficationModel(fea, gnd);
            obj.model = train(gnd, sparse(fea), '-q');
        end
        
        function cls = predict(obj, samples)  % predict classes for given test samples
            [nsample ~] = size(samples);
            cls = predict(rand(nsample, 1), sparse(samples), obj.model);
        end
        
    end
    
    methods (Access = protected)
        function predict_one(obj, sample)
        end
    end
end


