function[homeIndexArr]=ywGetHomeIndexArr(indexArr1,indexArr2,index)
    homeIndexArr(1)=indexArr1(index);
    homeIndexArr=[homeIndexArr;indexArr2(index)];
    
%     for(ii=1:5)
        for(i=1:length(indexArr1))
            ywIsIn1=ywIsInArray(indexArr1(i),homeIndexArr);
            ywIsIn2=ywIsInArray(indexArr2(i),homeIndexArr);
            if(ywIsIn1==1)
                homeIndexArr=[homeIndexArr;indexArr2(i)];
            end
            if(ywIsIn2==1)
                homeIndexArr=[homeIndexArr;indexArr1(i)];
            end
        end
%     end
     homeIndexArr=unique(homeIndexArr);
end

            
        