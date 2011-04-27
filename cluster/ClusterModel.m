classdef ClusterModel
    % Interface for a ClusterModel
    
    properties (Access = protected)
        fea  % feature points
        n    % number of training samples
        m    % number of dimensions of feature
    end
    
    properties (Dependent = true)
        idx  % cluster index
    end
    
    methods (Abstract)
        idx = cluster(obj);  % predict classes for a given test sample
    end
    
    methods (Access = protected)
        function obj = ClusterModel(fea)  % initialize features and ground truth
            obj.fea = fea;
            [obj.n, obj.m] = size(fea);
        end
    end
end
