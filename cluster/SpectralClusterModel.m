classdef SpectralClusterModel < ClusterModel
    % spectral clustering algorithm
    
    properties (Access = private)
        k  % number of clusers, k
        maxIter
        knn
    end
    
    methods
        function obj = SpectralClusterModel(fea, options)  % initialize Spectral Clustering model
            obj = obj@ClusterModel(fea);
            obj.k = options.k;
            obj.maxIter = options.maxIter;
            obj.knn = options.knn;
        end
        
        function idx = cluster(obj)
            W = obj.constructGraph(obj.fea);
            D = diag(sum(W));
            L = D - W;
            opt = struct('issym', true);
            [V ~] = eigs(L, D, obj.k, 'sm', opt);  % normailized N-Cut, see A toutrial on spectral clustering
            kmeans = KMeansModel(V, struct('k', obj.k, 'maxIter', obj.maxIter));
            idx = kmeans.cluster;
        end
    end
    
    methods (Access = private)
        function W = constructGraph(obj, X)
            [n ~] = size(X);
            W = zeros(n, n);
            idx = knnsearch(X, X, 'K', obj.knn);
            for i = 1:n
                for j = 1:obj.knn
                    W(i, idx(i,j)) = 1;
                    W(idx(i,j), i) = 1;
                end
            end
        end
    end
end