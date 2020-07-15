%{
Método que executa o algoritmo genético híbrido e retorna a melhor imagem encontrada.

Parâmetros:
- SizePop: tamanho da população
- NoisyImage: A imagem ruidosa (matriz de uint8)
- LocalSearchRate: taxa de busca local
- MaxTime: O tempo gasto na execução
- NumIter: Max número de iterações sem melhorar o melhor indivíduo
sem antes de reiniciar a população
- Beta: valor Beta
- TournSize: tamanho do Torneio
%}

function [f, bestAG] = execHGA(sizePop, noisyImage, localSearchRate, maxTime, numIter, beta, tournSize)
num_iter = 4;
    delta_t = 3/44;
    kappa = 70;
    option = 2;
    voxel_spacing = ones(3,1);


lambda = 1/sqrt(estimateVariance(noisyImage));
 
   
denoisedImages(3).img = [];

denoisedImages(1).img = bm4d(noisyImage, 'Gauss'); %BM4D
denoisedImages(2).img = medfilt3(noisyImage);	%Mediana
 h = fspecial3('ellipsoid', [3 3 3]);
        tmp = imfilter(noisyImage,h,'replicate');
denoisedImages(3).img = tmp;

pop = createPop(sizePop, noisyImage, denoisedImages, beta, lambda); %Cria população

s = tic;

while(toc(s) < maxTime)
    
    pop = evolveHGA(pop, sizePop, localSearchRate, beta, lambda, noisyImage, maxTime, numIter, tournSize);  % Eunção evoluir algoritmo genético  
    if(toc(s) < maxTime)
        pop = restartPop(pop,sizePop,denoisedImages, noisyImage, beta, lambda); % Reiniciar População
    end
    
end

bestAG = pop(1).cromo;

f = bestAG;

end
