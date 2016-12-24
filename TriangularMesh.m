classdef TriangularMesh < handle
    % TRIANGULARMESH A collection of triangular elements
    % The mesh can be visualized and refined.
    %
    % TRIANGULARMESH Properties:
    %    p - The points, size 2 x number-of-points
    %    t - The triangles, size 3 x number-of-elements
    %
    % TRIANGULARMESH Methods:
    %    draw - Visualize the mesh
    %    refine - Split each triangle into four subtriangles1
    
    properties
        p
        t
    end
    
    methods
        function obj = TriangularMesh(varargin)
            % Creates a Mesh object with the specified points and triangles.
            % If no points and triangles are given, creates a square mesh
            % with four elements.
            if nargin == 0
                % simple mesh with four elements
                obj.p = [0 1 1 0 0.5;
                         0 0 1 1 0.5];
                obj.t = [1 2 3 1;
                         2 3 4 4;
                         5 5 5 5];
            elseif nargin == 2
                obj.p = varargin{1};
                obj.t = sort(varargin{2});
            else
                error(['TriangularMesh constructor accepts either two',
                       ' or zero arguments.']);
            end
        end
        
        function h = draw(obj)
            % Draw the mesh. Return a handle to the plot.

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
        
        function obj = refine(obj)
            % Split each triangle into four subtriangles.
            edges = [];
            edges = [edges sort([obj.t(1, :); obj.t(2, :)], 1)];
            edges = [edges sort([obj.t(2, :); obj.t(3, :)], 1)];
            edges = [edges sort([obj.t(1, :); obj.t(3, :)], 1)];

            edges = sort(edges, 1);
       
            [~, ~, t2e] = unique(edges', 'rows');
            t2e = t2e(:)';

            t2e = reshape(t2e, size(obj.t, 2), 3)';
            
            % refine
            Np = size(obj.p, 2);
            
            for n=1:2
                e_nodes(n, :) = sum([obj.p(n, edges(1, :)); obj.p(n, edges(2, :))])/2;
            end

            % Create new mesh
            new_p = [obj.p e_nodes];


            % Edges as n1->n2, n2->n3, n1->n3.
            new_t = [obj.t(1,:) ; t2e(1,:)+Np ; t2e(3,:)+Np ];
            new_t = [new_t [obj.t(2,:) ; t2e(1,:)+Np ; t2e(2,:)+Np ]];
            new_t = [new_t [obj.t(3,:) ; t2e(3,:)+Np ; t2e(2,:)+Np ]];
            new_t = [new_t [t2e(1,:)+Np ; t2e(2,:)+Np ; t2e(3,:)+Np ]];
            
            obj.p = new_p;
            obj.t = new_t;
        end
    end
    
end

