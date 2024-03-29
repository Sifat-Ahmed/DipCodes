%Gaussian filter using MATLAB built_in function
%Read an Image
Img1 = imread('coins.png');
A1 = imnoise(Img1,'Gaussian',0.04,0.003);
%Image with noise
figure,imshow(A1);

H = fspecial('Gaussian',[9 9],1.76);
GaussF = imfilter(A1,H);
figure,imshow(GaussF);
%--------------------------------------------------------------------------

%MATLAB CODE for Gaussian blur WITHOUT built_in function:
%Read an Image
Img2 = imread('coins.png');
A2 = imnoise(Img2,'Gaussian',0.04,0.003);
%Image with noise
figure,imshow(A2);
 
I = double(A2);

%Design the Gaussian Kernel
%Standard Deviation
sigma = 1.7;
%Window size
sz = 4;
[x,y]=meshgrid(-sz:sz,-sz:sz);

M = size(x,1)-1;
N = size(y,1)-1;
Exp_comp = -(x.^2+y.^2)/(2*sigma*sigma);
Kernel= exp(Exp_comp)/(2*pi*sigma*sigma);
 
%Initialize
Output=zeros(size(I));
%Pad the vector with zeros
I = padarray(I,[sz sz]);

%Convolution
for i = 1:size(I,1)-M
    for j =1:size(I,2)-N
        Temp = I(i:i+M,j:j+M).*Kernel;
        Output(i,j)=sum(Temp(:));
    end
end
%Image without Noise after Gaussian blur
Output = uint8(Output);
figure,imshow(Output);
