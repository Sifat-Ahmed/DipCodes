%% create a new figure to show the image . 
    A = imread('rice.png');
    figure(1);
    %% show the loaded image.
    imshow(A);
    
    %% dilation affect.
    B = ordfilt2(A,25,true(5));
    figure(2),imshow(B)
    
    %% erosion affect.
    B = ordfilt2(A,1,true(5));
    figure(3),imshow(B)
