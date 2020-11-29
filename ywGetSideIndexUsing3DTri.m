function[sideIndex1,sideIndex2]=ywGetSideIndexUsing3DTri(tri)
    index1=tri(:,1);
    index2=tri(:,2);
    index3=tri(:,3);
    index4=tri(:,4);
    
    sideIndex1=[index1;index2;index3;index4;index2;index3;];
    sideIndex2=[index2;index3;index4;index1;index4;index1;];
    
    for(i=1:length(sideIndex1))
        if(sideIndex1(i)<sideIndex2(i))
            continue;
        else
            tmp=sideIndex1(i);
            sideIndex1(i)=sideIndex2(i);
            sideIndex2(i)=tmp;
        end
    end
    A=[sideIndex1,sideIndex2];
    A=unique(A,'rows');
   
    sideIndex1=A(:,1);
    sideIndex2=A(:,2);
%     figure;plot(sideIndex1);hold on;plot(sideIndex2);   

end