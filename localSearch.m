
% Escolher o algoritmo de filtro - busca local aleatoriamente
function g = localSearch(img)
num_iter = 4;
    delta_t = 3/44;
    kappa = 70;
    option = 2;
    voxel_spacing = ones(3,1);
r = randi(3);

switch r 
   
    case 1
        tmp = bm4d(img, 'Gauss'); %BM4D
    case 2
        tmp = medfilt3(img);	%Mediana
    case 3
       h = fspecial3('ellipsoid', [3 3 3]);
        tmp = imfilter(img,h,'replicate');
end

g = uint8(tmp);

end