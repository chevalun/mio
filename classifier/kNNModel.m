classdef kNNModel < ClassficationModel
    % k-nearest neighbor classifier

    properties (Access = private)
        k  % the kNN parameter, k
    end
    
    methods
        function obj = kNNModel(fea, gnd, options)  % initialize kNN model
            obj = obj@ClassficationModel(fea, gnd);
            obj.k = options.k;
        end
        
        function cls = predict(obj, samples)  % predict classes for given test samples
            cls = predict@ClassficationModel(obj, samples);
        end
    end
    
    methods (Access = protected)
        function cls = predict_one(obj, sample)
            dis = sum((repmat(sample, obj.n, 1) -  obj.fea).^2, 2);  % compute distances
            [~, ix] = sort(dis);
            s = zeros(obj.n, 1);
            for i = 1:obj.k   % find k points with shortest distance to vote for the predicted class
                s(obj.gnd(ix(i))) = s(obj.gnd(ix(i))) + 1;
            end
            [~, cls] = max(s);
        end
    end
end
