classdef kNNModel < ClassficationModel
    % k-nearest neighbor algorithm
    
    properties (Access = private)
        k         % the kNN parameter
    end
    
    methods
        function obj = kNNModel(fea, gnd, options)
            obj = obj@ClassficationModel(fea, gnd);
            obj.k = options.k;
        end
        
        function cls = predict(obj, samples)
            [nsamples, ~] = size(samples);
            cls = zeros(nsamples, 1);
            for col = 1:nsamples 
                dis = sum((repmat(samples(col,:), obj.n, 1) -  obj.fea).^2, 2);  % compute distances
                [~, ix] = sort(dis);
                s = zeros(obj.m,1);
                for i = 1:obj.k   % find k points with shortest distance to vote for the predicted class
                    s(obj.gnd(ix(i))) = s(obj.gnd(ix(i))) + 1;
                end
                [~, cls(col)] = max(s);
            end
        end
    end
    
end

