classdef ClassficationModel
    % Interface for a ClassficationModel
    
    properties (Access = protected)
        fea  % features
        gnd  % ground truth
        n    % number of training samples
        m    % number of dimensions of feature
    end
    
    methods (Abstract, Access = protected)
        cls = predict_one(sample);  % predict classes for a given test sample
    end
    
    methods (Access = protected)
        function obj = ClassficationModel(fea, gnd)  % initialize features and ground truth
            obj.fea = fea;
            obj.gnd = gnd;
            [obj.n, obj.m] = size(fea);
        end
    end
    
    methods
        function cls = predict(obj, samples)  % predict classes for given test samples
            [nsamples, ~] = size(samples);
            cls = zeros(nsamples, 1);
            for col = 1:nsamples
                cls(col) = predict_one(obj, samples(col,:));
            end
        end
    end
end

