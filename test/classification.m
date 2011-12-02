%train = load('~/code/mio/data/ORL_train.mat');
%test = load('~/code/mio/data/ORL_test.mat');
%train = load('~/code/mio/data/USPS_train.mat');
%test = load('~/code/mio/data/USPS_test.mat');
train = load('~/code/mio/data/Reuters_train.mat');
test = load('~/code/mio/data/Reuters_test.mat');


%mAC = 0;
for i = 0:1:100
opts = struct('k',1, 'lambda', i);
%rst = ClassifierEval(train, test, @LinearSVMModel,opts);
rst = ClassifierEval(train, test, @RidgeRegressionModel, opts);
%rst = ClassifierEval(train, test, @NaiveBayesModel, opts);
%rst = ClassifierEval(train, test,@KNNModel,opts);
fprintf('lambda=%d\n',i);
disp(rst);

end