for t = 1:10
    %load('~/code/mio/data/MNIST/MNIST.mat');
    load('~/code/mio/data/COIL20/COIL20.mat');
    %load(sprintf('~/code/mio/data/MNIST/5Class/%d.mat', t));
    load(sprintf('~/code/mio/data/COIL20/5Class/%d.mat', t));
    fea = fea(sampleIdx,:);
    gnd = gnd(sampleIdx,:);
    fea(:,zeroIdx) = [];
    data = struct('fea',fea,'gnd',gnd);
    opts = struct('k',5,'maxIter', 100, 'knn', 5);
    mAC = 0;
    for i = 1:10
        rst = ClusterEval(data,@SpectralClusterModel,opts);
        %rst = ClusterEval(data,@GMModel,opts);
        %rst = ClusterEval(data,@KMedoidsModel,opts);
        %rst = ClusterEval(data,@KMeansModel,opts);
        if rst.accuracy > mAC
            r = rst;
            mAC = rst.accuracy;
        end
    end
    fprintf('case%d\n', t);
    disp(r);
end