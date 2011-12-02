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
            pdis = zeros(obj.n, obj.n);
            for i = 1:obj.n
                for j = i:obj.n
                    pdis(i,j) = sum((obj.fea(i,:)-obj.fea(j,:)).^2);
                    pdis(j,i) = pdis(i,j);
                end
            end
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
                cdis = Inf(obj.k, 1);
                for c = 1:obj.k
                    pts = find(idx == c);
                    [sz ~] = size(pts);
                    for p = 1:sz
                        sdis = 0;
                        for q = 1:sz
                            sdis = sdis + pdis(pts(p), pts(q));
                        end
                        if(sdis < cdis(idx(pts(p))))
                            cdis(idx(pts(p))) = sdis;
                            ctrs(idx(pts(p)),:) = obj.fea(pts(p),:);
                        end
                    end
                end
            end
        end
    end
end
