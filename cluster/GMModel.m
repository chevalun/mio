classdef GMModel < ClusterModel
    % gmm cluster algorithm
    
    properties (Access = private)
        k  % the number of clusters, k
        maxIter
    end
    
    methods
        function obj = GMModel(fea, options)  % initialize gmm model
            obj = obj@ClusterModel(fea);
            obj.k = options.k;
            obj.maxIter = options.maxIter;
        end
        
        function idx = cluster(obj)
            [~, obj.fea] = princomp(obj.fea,'econ');
            obj.fea = obj.fea(:,1:5);
			gm = gmdistribution.fit(obj.fea, obj.k);
			idx = cluster(gm, obj.fea);
        end
    end
end
