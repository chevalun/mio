classdef NaiveBayesModel < ClassficationModel
    
    properties (Access = private)
        model
    end
    
    methods
        function obj = NaiveBayesModel(fea, gnd, opts)  
            obj = obj@ClassficationModel(fea, gnd);
            %obj.model = NaiveBayes.fit(fea, gnd);
            obj.model = NaiveBayes.fit(fea, gnd, 'Distribution', 'mn');
        end
        
        function cls = predict(obj, samples)  % predict classes for given test samples
            cls = predict(obj.model, samples);
        end
        
    end
    
    methods (Access = protected)
        function predict_one(obj, sample)
        end
    end
end


