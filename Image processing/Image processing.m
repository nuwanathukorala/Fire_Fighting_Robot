 img=imread('building-on-fire-1.jpg');
 img=imgaussfilt(img,[3 3]);
 t=40;
 
 red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
hsv=rgb2hsv(img); 

y=rgb2ycbcr(img);
 Y=y(:,:,1);
 Cb=y(:,:,2);
 Cr=y(:,:,3);

 [a,b]=size(Y);
 Sum=sum(Y);
 total=sum(Sum);
 Y1=total/(a*b);
  [a,b]=size(Cb);
 Sum=sum(Cb);
 total=sum(Sum);
 CbMean=total/(a*b);

  [a,b]=size(Cr);
 Sum=sum(Cr);
 total=sum(Sum);
 CrMean=total/(a*b);

h=hsv(:,:,1);
 h=round(h,2);
 s=hsv(:,:,2);
 s=round(s,2);
 v=hsv(:,:,3);
 v=round(v,2);
[l,c]=size(s);
test=ones(l,c)*255;
for i=1:l
    for j=1:c
        ss=1-3.0*min(red(i,j),min(green(i,j),red(i,j)))/(red(i,j) +green(i,j)+blue(i,j));
        if(~(abs(Cb(i,j)-Cr(i,j)<t)&&red(i,j)>180 && red(i,j)>=green(i,j) && green(i,j)>blue(i,j) && ss>=((255-red(i,j))*0.2/180) &&(v(i,j)>0.8 && v(i,j)<1)&& (Y(i,j)>=Y1) && (Cb(i,j)<=CbMean) && (Cr(i,j)>=CrMean)))
            test(i,j)=0;
              
        end
    end
end
BW2 = bwareaopen(test,100);
test=imclearborder(test);
stats = struct2table(regionprops(test,{'Area','Solidity','PixelIdxList'}));
idx = stats.Solidity < 0.9 | stats.Area <350;
for kk = find(idx)'
  test(stats.PixelIdxList{kk}) = true;
end

subplot(2,2,1);
 imshow(img);

 subplot(2,2,2);
 imshow(test);
