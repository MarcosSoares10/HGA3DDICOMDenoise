
function f = crossover(p1, p2)

r = randi(3);
[linhas, colunas,z] = size(p1); % Dimensão da Imagem (height, width)
if (linhas == 0 || colunas == 0)
    fprinf('Error\n');
end

switch r
    
    case 1
        idx = randi(linhas); 
        tmp = vertcat(p1(1:idx,:,:), p2(idx+1:linhas,:,:));
    case 2
        idx = randi(colunas);
        tmp = horzcat(p1(:,1:idx,:,:), p2(:,idx+1:colunas,:,:));
    case 3
        tmp = zeros(linhas, colunas);
        for i = 1: linhas
            for j = 1:colunas
                if(rand < 0.5)
                    tmp(i,j,z) = p1(i,j,z);
                else
                    tmp(i,j,z) = p2(i,j,z);
                end
            end
        end
        
end

f = tmp;
end