classdef BayesPICDSC < handle
    properties
        constellation {mustBeNumeric}
        MMSE = true
        VarUpdate = false
        min_var {mustBeNumeric} = eps       % the default minimal variance is 2.2204e-16
        iter_num = 10                       % maximal iteration
    end
    methods
        % init
        % @constellation:       the constellation
        % @MMSE:                whether use MMSE or not
        % @min_var
        function self = BayesPICDSC(constellation, varargin)
            % Inputs Name-Value Pair 
            inPar = inputParser;
            % Set default values                                    
            % Register names
            addParameter(inPar,'MMSE', self.MMSE, @islogical);
            addParameter(inPar,'VarUpdate', self.VarUpdate, @islogical);
            addParameter(inPar,'min_var', self.min_var, @isnumeric);
            addParameter(inPar,'iter_num', self.iter_num, @isnumeric);
            % Allow unmatched cases
            inPar.KeepUnmatched = true;
            % Allow capital or small characters
            inPar.CaseSensitive = false;
            % Try to load those inputs 
            parse(inPar, varargin{:});
            
            % take inputs
            if ~isvector(constellation)
                error("The constellation must be a vector.");
            else
                self.constellation = constellation;
            end
            self.MMSE = inPar.Results.MMSE;
            self.VarUpdate = inPar.Results.VarUpdate;
            self.min_var = inPar.Results.min_var;
            self.iter_num = inPar.Results.iter_num;
            if self.iter_num < 1
                error("The iteration number must be positive.")
            end
        end
        
        % detect
        % @y:       the received signal
        % @H:       the channel matrix
        % @noPow:   the noise (linear) power
        function x = detect(self, y, H, noPow)
            % input check
            if isscalar(y) 
                error("The received signal must be a vector.")
            elseif ~isvector(y)
                error("The received signal must be a vector.")
            end
            if isscalar(H) 
                error("The received signal must be a vector.")
            elseif ~ismatrix(H)
                error("The channel must be a matrix.")
            end
            [H_row_num, ~] = size(H);
            if H_row_num ~= length(y)
                error("The channel row number does not equal to the signal number.");
            end
            if ~isscalar(noPow)
                error("The noise power must be a scalar.");
            end
            
            % generate variables
            [~, x_num] = size(H);
            Ht = H';
            x_app = zeros(x_num, 1);
            w = ((eye(x_num)+1) - eye(x_num).*2);
            if self.MMSE
                inv_H = inv(Ht*H + noPow*diag(ones(x_num, 1)));
            else
                inv_H = inv(Ht*H);
            end
            inv_H_D = inv(diag(diag(Ht*H)));
            
            % iterative detection
            for t = 1:self.iter_num
                % BSO
                % BSE
                % DSC
            end
        end
    end
end