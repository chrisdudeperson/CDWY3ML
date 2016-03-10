% Your 2D arrays:
x1 = [1 2; 3 4];
x2 = [2 3; 4 5];
% Concatenate:
x = cat(3,x1,x2);
% Permute to get interpolated dimension first:
x = permute(x,[3 1 2])
% Define arbitrary unit for time slices:
t0 = [1 2];
% Interpolate to time slice at t=1.5:
x_interp = interp1(t0,x,1.5)

figure
mesh(x1)
figure
mesh(x2)
figure
plot3(x(:,1),x(:,2),x(:,3));