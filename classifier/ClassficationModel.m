classdef ClassficationModel
    % Interface for a ClassficationModel
    
   properties (Access = protected)
      fea
      gnd
      n
      m
   end
    
    methods (Abstract)
        cls = predict(sample);
    end
    
    methods (Access = protected)
        function obj = ClassficationModel(fea, gnd)
            obj.fea = fea;
            obj.gnd = gnd;
            [obj.n, obj.m] = size(fea);
        end
    end
    
end

