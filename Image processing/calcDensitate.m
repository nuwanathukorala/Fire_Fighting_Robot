function densitate=calcDensitate(test,densitate,ksize)
 r=(ksize-1)/2;
 [linii,coloane]=size(densitate);
 rowBound=linii-r;
 colBound=coloane-r;
 for j=r+1:colBound
     col1=j-r;
     col2=j+r;
     delta=1;
     for k=1:ksize
         delta=delta+test(k,col2)-test(k,col1);
     end
     densitate(r,j)=densitate(r,j-1)+delta/255;
 end
 for i=r+1:rowBound
     row1=i-r;
     row2=i+r;
     delta=1;
     for k=1:ksize
         delta=delta+test(row2,k)+test(row1,k);
     end
     densitate(i,r)=densitate(i-1,r)+delta/255;
 end
 for i=r+1:rowBound
     for j=r+1:colBound
         delta=(test(r+i,j+r)-test(i-r,j+r)-test(i+r,j-r)+test(i-r,j-r))/255;
         densitate(i,j)=densitate(i-1,j)+densitate(i,j-1)-densitate(i-1,j-1)+delta;
     end
 end 
 