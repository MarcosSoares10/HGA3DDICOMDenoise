function [] = runhga3d()
%close all;
clc;

%fprintf('Parâmetros:\n');
%fprintf('- SizePop: tamanho da população\n')
%fprintf('- LocalSearchRate: taxa de busca local\n')
%fprintf('- MaxTime: O tempo maximo de evolução\n')
%fprintf('- NumIter: Maximo número de iterações sem melhorar o melhor indivíduo\n')
%fprintf('	   sem antes reiniciar a população\n')
%fprintf('- Beta: valor Beta\n')
%fprintf('- TournSize: tamanho do Torneio\n')

%fprintf('Exemplo:\n')

%fprintf('sizePop = 15;\n')
%fprintf('localSearchRate = 0.6;\n')
%fprintf('maxTime = 300;\n')
%fprintf('numIter = 5\n')
%fprintf('beta = 1.5;\n')
%fprintf('tournSize = 3;')
%fprintf('\n');

image = dicom23D();
%tic;
ruido = noise(image,'ag', '2%');
noisyImage = ruido;


mediancompare = medfilt3(noisyImage);	
 h = fspecial3('ellipsoid', [3 3 3]);
       tmp = imfilter(noisyImage,h,'replicate');
ellipsoidcompare = tmp;


%figure; imshow3D(image);
%figure; imshow3D(ruido);
%figure; imshow3D(ellipsoidcompare);
%figure; imshow3D(mediancompare);

msemedian = immse(uint8(mediancompare), uint8(image));
psnrmedian = calc_psnr(uint8(mediancompare), uint8(image));
ssimmedian = ssim(uint8(mediancompare), uint8(image));
clear mediancompare;
mseelipsoid = immse(uint8(ellipsoidcompare), uint8(image));
psnrelipsoid = calc_psnr(uint8(ellipsoidcompare), uint8(image));
ssimelipsoid = ssim(uint8(ellipsoidcompare), uint8(image));
clear ellipsoidcompare;
mseinicial = immse(uint8(noisyImage), uint8(image));
psnrinicial = calc_psnr(uint8(noisyImage), uint8(image));
ssiminicial = ssim(uint8(noisyImage), uint8(image));





%fprintf('----------------------------------------------------------\n');
%sizePop = input('Digite o tamanho da população\n');
sizePop = 15;
%fprintf('----------------------------------------------------------\n');
%localSearchRate = input('Digite a taxa de busca local\n');
localSearchRate = 0.6;
%fprintf('----------------------------------------------------------\n');
%maxTime = input('Digite O tempo maximo de evolução\n');
maxTime = 300;
%fprintf('----------------------------------------------------------\n');
%numIter = input('Digite O numero de iterações\n');
numIter = 5;
%fprintf('----------------------------------------------------------\n');
%beta = input('Digite O valor de beta\n');
beta = 1.5;
%fprintf('----------------------------------------------------------\n');
%tournSize = input('Digite O tamanho do torneio\n');
tournSize = 3;
%fprintf('----------------------------------------------------------\n');
fprintf('Executando Algoritmo.\n');

%figure,imshow(noisyImage);

f = execHGA(sizePop, noisyImage, localSearchRate, maxTime, numIter, beta, tournSize);


psnr = calc_psnr(uint8(f), uint8(image));
ssim1 = ssim(uint8(f), uint8(image));
mse = immse(uint8(f), uint8(image));

%t=toc;
fprintf('Execução Finalizada.\n');
fprintf('\n');

figure; imshow3D(f);

fprintf(' PSNR Inicial: %.2f \n', psnrinicial);
fprintf(' SSIM Inicial: %.2f \n', ssiminicial);
fprintf(' MSE Inicial: %.2f \n', mseinicial);

fprintf(' PSNR Median: %.2f \n', psnrmedian);
fprintf(' SSIM Median: %.2f \n', ssimmedian);
fprintf(' MSE Median: %.2f \n', msemedian);

fprintf(' PSNR Ellipsoid: %.2f \n', psnrelipsoid);
fprintf(' SSIM Ellipsoid: %.2f \n', ssimelipsoid);
fprintf(' MSE Ellipsoid: %.2f \n', mseelipsoid);

fprintf(' PSNR Final: %.2f \n', psnr);
fprintf(' SSIM Final: %.2f \n', ssim1);
fprintf(' MSE Final: %.2f \n', mse);

%fprintf(' Time if execute: %.2f \n', t);

%figure,imshow(f); 
return;
end



