%{

Offline 1: Histogram Specification
Name: Asif Imtiaz Shaafi
ID: 15.01.04.136

%}

% img = imread('cameraman.png');
% target_img = imread('coins.jpg');

img = imread('tr.jpg');
target_img = imread('cameraman.png');


final_img = img;

% ********* Working with source image ***********
[sr_row, sr_col] = size(img);

sr_histogram = 1 : 256;

% calculating histogram
for index = 1 : 256
    count = 0;
    for i = 1 : sr_row
        for j = 1 : sr_col
            if img(i, j) == index - 1
                count = count + 1;
            end
        end
    end
    sr_histogram(index) = count;
end 

figure('name', 'Source image histogram'); bar(sr_histogram);

total_pixel = sr_row * sr_col;

sr_PDF = 1 : 256;
% calculating PDF
for i = 1 : 256
    sr_PDF(i) = sr_histogram(i) / total_pixel;
end

% figure('name','Source image PDF bar chart'); bar(sr_PDF);

prev_value = 0;
sr_CDF = 1:256;

for i = 1:256
    sr_CDF(i) = sr_PDF(i) + prev_value;
    prev_value = sr_CDF(i);
end

% figure('name','Source image CDF bar chart'); bar(sr_CDF);


% ********* Working with target image ***********
[tr_row, tr_col] = size(target_img);

tr_histogram = 1 : 256;
count = 0;

% calculating histogram
for index = 1 : 256
    count = 0;
    for i = 1 : tr_row
        for j = 1 : tr_col
            if target_img(i, j) == index - 1
                count = count + 1;
            end
        end
    end
    tr_histogram(index) = count;
end 

figure('name', 'Target image histogram'); bar(tr_histogram);

tr_total_pixel = tr_row * tr_col;

tr_PDF = 1 : 256;
% calculating PDF
for i = 1 : 256
    tr_PDF(i) = tr_histogram(i) / tr_total_pixel;
end

% figure('name','Target image PDF bar chart'); bar(tr_PDF);

prev_value = 0;
tr_CDF = 1:256;

for i = 1:256
    tr_CDF(i) = tr_PDF(i) + prev_value;
    prev_value = tr_CDF(i);
end

% figure('name','Target image CDF bar chart'); bar(tr_CDF);

% ********* Mapping the histogram values ***********
look_up_table = 1 : 256;

for i = 1 : 256 % looping through the source image histogram CDF
    smallest = max(sr_histogram);
    index = i;
    for j = 1 : 256 % looping through the target image histogram CDF
        diff = abs(sr_CDF(i) - tr_CDF(j));
        if(diff < smallest)
            smallest = diff;
            index = j;
        end
    end
    
    look_up_table(i) = index;
end

% figure('name','Lookup table bar chart'); bar(look_up_table);

% assigning the new histogram into the source image
for index = 1 : 256
    for i = 1 : sr_row
        for j = 1 : sr_col
            if img(i, j) == index - 1
                final_img(i, j) = look_up_table(index);
            end
        end
    end
end 
figure("name", "output image"); imshow(uint8(final_img));

new_histogram = 1 : 256;

for index = 1 : 256
    count = 0;
    for i = 1 : sr_row
        for j = 1 : sr_col
            if final_img(i, j) == index - 1
                count = count + 1;
            end
        end
    end
    new_histogram(index) = count;
end 
figure('name', 'Final image histogram'); bar(new_histogram);

%{
histogram_copy = 1 : 256;

for index = 1 : 256
    count = 0;
    for i = 1 : row
        for j = 1 : col
            if img_copy(i, j) == index - 1
                count = count + 1;
            end
        end
    end
    histogram_copy(index) = count;
end 
figure; bar(histogram_copy);
PDF_copy = 1 : 256;

for i = 1 : 256
    PDF_copy(i) = histogram_copy(i) / total_pixel;
end

% figure; bar(PDF);

prev_value_copy = 0;
CDF_copy = 1 : 256;

for i = 1:256
    CDF_copy(i) = PDF_copy(i) + prev_value_copy;
    prev_value_copy = CDF_copy(i);
end

CDF_copy = CDF_copy * 255;

for i = 1:256
    CDF_copy(i) = round(CDF_copy(i));
end
figure; plot(CDF_copy);

%}
