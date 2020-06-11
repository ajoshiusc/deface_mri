function autocrop_img(pngfilename)

img = im2double(imread(pngfilename)); % read image and convert it to double in range [0..1]
if img(1,1)>eps
    sgn=1;
else
    sgn=-1;
end

b = sum( (1-img).^2, 3 ); % check how far each pixel from "white"

% display

% use regionprops to get the bounding box
st = regionprops( double( sgn*b > sgn*.5 ), 'BoundingBox' ); % convert to double to avoid bwlabel of logical input

rect = st.BoundingBox; % get the bounding box

 
crop = imcrop(img,rect);
 
imwrite(crop,pngfilename);

