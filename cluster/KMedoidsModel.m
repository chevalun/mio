classdef KMedoidsModel < ClusterModel
    % k-medois cluster algorithm
    
    properties (Access = private)
        k  % the k-medoids parameter, k
        maxIter
    end
    
    methods
        function obj = KMedoidsModel(fea, options)  % initialize KMedoids model
            obj = obj@ClusterModel(fea);
            obj.k = options.k;
            obj.maxIter = options.maxIter;
        end
        
        function idx = cluster(obj)
            idx = zeros(obj.n, 1);
            ctrs = obj.fea(randsample(obj.n, obj.k),:);
            for t = 1:obj.maxIter
                for p = 1:obj.n
                    dis = zeros(obj.k, 1);
                    for c = 1:obj.k
                        dis(c) = (ctrs(c)-obj.fea(p)).^2;
                    end
                    [~, idx(p)] = min(dis);
                end
                ctrs = zeros(obj.k, obj.m);
				cdis = Inf(obj.k, 1);
				for p = 1:obj.n
					pdis = 0;
					for q = 1:obj.n
						if idx(p) == idx(q)
							pdis = pdis + (obj.fea(p)-obj.fea(q)).^2;
						end
					end
					if(pdis < cdis(idx(p)))
						cdis(idx(p)) = pdis;
						ctrs(idx(p)) = obj.fea(p);
					end
				end
            end
        end
    end
end
