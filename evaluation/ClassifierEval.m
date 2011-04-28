classdef ClassifierEval
    % class for classifier evaluation
    
    properties
        accuracy
        training_time
        testing_time
    end
    
    methods
        function obj = ClassifierEval(train, test, algorithm, options)
            tic
            model = algorithm(train.fea, train.gnd, options);
            obj.training_time = toc;
            tic
            rst = model.predict(test.fea);
            obj.testing_time = toc;
            [nsamples, ~]= size(test.gnd);
            [ncorrect, ~] = size(find(rst == test.gnd));
            obj.accuracy = ncorrect / nsamples;
        end
    end
    
end