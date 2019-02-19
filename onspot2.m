I = imread('coins.jpg');
G = rgb2gray(I);
[row, col] = size(G);
K = zeros(row,col);
nk = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256:1);
out_nk = zeros(256,1);
out_pdf = zeros(256,1);
out_cdf = zeros(256:1);
l = zeros(256:1);
t=1:256;
n=0:255;
count=0;

%calculating histogram
for z=1:256
    for i=1:row
        for j=1:col
            
            if G(i,j)==z-1
                count=count+1;
            end
        end
    end
            nk(z)=count;
            count=0;
end

%calculating pdf
total = sum(nk);
for i = 1:256
    pdf(i) = nk(i)/total;
end
figure;
bar(n,pdf)

%calculating cdf
cdf(1) = pdf(1);
for i = 2:256
    cdf(i) = cdf(i-1) + pdf(i);
end
figure;
bar(n,cdf)

%calculate L-1*CDF
for i = 1:256
    l(i) = 255 * cdf(i);
end
 R = round(l);
 
 %mapping output image
 
 for z= 1:256
     for i = 1:row
         for j = 1:col
            if G(i,j) == z-1
                K(i,j) = R(z);
            end
         end
     end
 end
 
figure;
imshow(uint8(K));

%calculatig output image histogram
for z=1:256
    for i=1:row
        for j=1:col
            
            if K(i,j)==z-1
                count=count+1;
            end
        end
    end
            out_nk(z)=count;
            count=0;
end

%calculate output_pdf
total = sum(out_nk);
for i = 1:256
    out_pdf(i) = out_nk(i)/total;
end
figure;
bar(n,out_pdf)

%calculate output_cdf
out_cdf(1) = out_pdf(1);
for i = 2:256
    out_cdf(i) = out_cdf(i-1) + out_pdf(i);
end
figure;
bar(n,out_cdf)