function [data] = loadData(dataset)
load(dataset);
data.X = MatX;
data.Y = MatY;

disp('dataset loaded');
end