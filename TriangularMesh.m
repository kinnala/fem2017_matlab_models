classdef TriangularMesh
    %TRIANGULARMESH A collection of triangle elements
    %   The mesh can be visualized and refined.
    
    properties
        p % points, size Ndim x Npoints
        t % triangles, size 3 x Nelems
    end
    
    methods
        %% The constructor
        % Creates a Mesh object with the specified points and triangles.
        % If no points and triangles are given, creates a square mesh
        % with four elements.
        function obj = TriangularMesh(varargin)
            if nargin == 0
                % simple mesh with four elements
                obj.p = [0 1 1 0 0.5;
                         0 0 1 1 0.5];
                obj.t = [1 2 3 1;
                         2 3 4 4;
                         5 5 5 5];
            else
                obj.p = varargin{1};
                obj.t = varargin{2};
            end
        end
        
        %% Visualize the mesh
        % Draw the mesh. Return a handle to the plot.
        function h = draw(obj)
            % TODO
            % see help(figure)
            % see help(line)
            h = 0;
            %% <MODEL>
            X = obj.p(1, :);
            Y = obj.p(2, :);
            X = X([obj.t; obj.t(1,:)]);
            Y = Y([obj.t; obj.t(1,:)]);
            h = line(X, Y);
            %% </MODEL>
        end
        
        %% Refine the mesh
        % Split each triangle into four subtriangles.
        function refine(obj)
            % TODO
            %% <MODEL>
            % create new points: edge midpoints
            new_p = 0.5*(obj.p(1, :) + obj.p(2, :));
            new_p = [new_p 0.5*(obj.p(2, :) + obj.p(3, :))];
            new_p = [new_p 0.5*(obj.p(1, :) + obj.p(3, :))];
            unique(new_p', 'rows')'
            % create new triangles
            Npoints = size(obj.p, 2);
            new_ix1 = (Npoints+1):(2*Npoints);
            new_ix2 = (2*Npoints+1):(3*Npoints);
            new_ix3 = (3*Npoints+1):(4*Npoints);
            new_t = [obj.t(1, :);
                     new_ix1
            %% </MODEL>
        end
    end
    
end

