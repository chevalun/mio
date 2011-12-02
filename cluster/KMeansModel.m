classdef KMeansModel < ClusterModel
    % k-means cluster algorithm
    
    properties (Access = private)
        k  % the KMeans parameter, k
        maxIter
    end
    
    methods
        function obj = KMeansModel(fea, options)  % initialize KMeans model
            obj = obj@ClusterModel(fea);
            obj.k = options.k;
            obj.maxIter = options.maxIter;
        end
        
        function idx = cluster(obj)
            idx = zeros(obj.n, 1);
            ctrs = obj.fea(randsample(obj.n, obj.k),:);
            t = 0;
            oidx = zeros(obj.n, 1);
            while true
                for p = 1:obj.n
                    dis = zeros(obj.k, 1);
                    for c = 1:obj.k
                        dis(c,:) = sum((ctrs(c,:)-obj.fea(p,:)).^2);
                    end
                    [~, idx(p)] = min(dis);
                end
                t = t + 1;
                if t > obj.maxIter || isequal(idx, oidx)
                    break;
                end
                oidx = idx;
                ctrs = zeros(obj.k, obj.m);
                num = zeros(obj.k, 1);
                for p = 1:obj.n
                    ctrs(idx(p),:) = ctrs(idx(p),:) + obj.fea(p,:);
                    num(idx(p)) = num(idx(p)) + 1;
                end
                for i = 1:obj.k
                    ctrs(i,:) = ctrs(i,:) / num(i);
                end
            end
        end
    end
end
