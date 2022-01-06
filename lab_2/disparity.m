
%%
close all
%%
templateSize=11;
templateMid = ceil(templateSize/2)
templateOffset = templateMid-1;
figure('Name','left')
leftImg = imread('images\corridorl.jpg');
leftImg = rgb2gray(leftImg);
imshow(leftImg);
figure('Name','right')
rightImg = imread('images\corridorr.jpg');
rightImg = rgb2gray(rightImg);
imshow(rightImg);
map =disparity_map(leftImg,rightImg,11,11);
figure('Name','test')
imshow(map,[-15 15]);
disp("end");
%%
%c triclops
templateSize=11;
templateMid = ceil(templateSize/2)
templateOffset = templateMid-1;
figure('Name','left')
leftImg = imread('images\triclopsi2l.jpg');
leftImg = rgb2gray(leftImg);
imshow(leftImg);
figure('Name','right')
rightImg = imread('images\triclopsi2r.jpg');
rightImg = rgb2gray(rightImg);
imshow(rightImg);
map =disparity_map(leftImg,rightImg,11,11);
figure('Name','test')
imshow(map,[-15 15]);
disp("end");


%%
function template= disparity_map(imLeft,imRight,xTemp,yTemp)

templateSize=11;
templateMid = ceil(templateSize/2);
templateOffset = templateMid-1;
[leftRow leftCol] = size(imLeft);
template = ones(leftRow-xTemp+1, leftCol-yTemp+1);


for x = templateMid : leftRow-templateMid+1
    for y = templateMid : leftCol-templateMid+1
        leftSlice = imLeft(x-templateOffset:x+templateOffset,y-templateOffset:y+templateOffset);
        leftSliceRotated = rot90(leftSlice,2);
        %global variable
        min_coord = y;
        min_diff = inf;
        for z = max(templateMid, y-14) :y
            sliceTemplate = imRight(x-templateOffset:x+templateOffset,z-templateOffset:z+templateOffset);
            sliceTemplateRotated = rot90(sliceTemplate,2);
            %correlate sliceTemplate with rotated slices to do matching 
            %and calculate SSD
            convresult1 = conv2(sliceTemplate,sliceTemplateRotated);
            convresult2 = conv2(sliceTemplate,leftSliceRotated);
            ssd = convresult1(xTemp,yTemp)-2*convresult2(xTemp,yTemp);
            if ssd<min_diff
                min_diff = ssd;
                min_coord = z;
            end
            
        end
    template(x-templateOffset,y-templateOffset) =  y-min_coord;
end
end
end
%%

