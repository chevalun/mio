classdef ClusterEval
    % class for cluster evaluation
    
    properties
        accuracy
        mutual_info
        time
    end
    
    methods
        function obj = ClusterEval(data, algorithm, options)
            tic
            model = algorithm(data.fea, options);
            idx = model.cluster;
            obj.time = toc;
            res = bestMap(data.gnd, idx);
            obj.accuracy = length(find(data.gnd==res))/length(data.gnd);
            obj.mutual_info = MutualInfo(data.gnd, res);
        end
    end  
end