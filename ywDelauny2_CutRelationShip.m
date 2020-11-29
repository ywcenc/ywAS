function[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw)
    % % %     %严格按照距离进行截取   20200810   效果和SLC基本一致。
    % % %     [sideIndex1,sideIndex2]=ywGetSideIndexUsing3DTri(tri);
    % % %     dis=ywGetDis3D(x(sideIndex1),y(sideIndex1),z(sideIndex1),x(sideIndex2),y(sideIndex2),z(sideIndex2));
    % % %     [dis,sIn]=sort(dis);
    % % %     sideIndex1=sideIndex1(sIn);
    % % %     sideIndex2=sideIndex2(sIn);
    % % %     sIn1=sideIndex1;
    % % %     sIn2=sideIndex2;
    % % %     m=find(dis>D);
    % % %     sIn1(m)=[];
    % % %     sIn2(m)=[];     
    % % %     sIn12=[sIn1;sIn2];
    % % %     ywJudgedResult=1:length(x);ywJudgedResult=ywJudgedResult';
    % % %     aa=ismember(ywJudgedResult,sIn12);
    % % %     m1=find(aa==1);
    % % %     ywAfterShockIndex=ywJudgedResult(m1);
    % % %     m0=find(aa==0);
    % % %     ywBGIndex=ywJudgedResult(m0);
    % % %     ywJudgedResult=aa;
    %-%-%----------------------------------------------------------------------------------------------------------------
    % % %     %按照三角形进行截取,以四面体为研究对象，如果本四面体中某条边存在超过阈值，则删除本四面体(，只删除对应的边）。
    newTri=tri;
    Lc=D;
    m12=find(dis12>=Lc);
    newTri(m12,1)=nan;
    newTri(m12,2)=nan;
    m23=find(dis23>=Lc);
    newTri(m23,2)=nan;
    newTri(m23,3)=nan;
    m13=find(dis13>=Lc);
    newTri(m13,1)=nan;
    newTri(m13,3)=nan;
    m14=find(dis14>=Lc);
    newTri(m14,1)=nan;
    newTri(m14,4)=nan;
    m24=find(dis24>=Lc);
    newTri(m24,2)=nan;
    newTri(m24,4)=nan;
    m34=find(dis34>=Lc);
    newTri(m34,3)=nan;
    newTri(m34,4)=nan;
    if(ywDraw==1)
        subplot(2,2,4);hold on;
        h=trisurf(newTri,x,y,z);
        set(h,'edgealpha',0,'facealpha',0.3);
        h=trimesh(newTri,x,y,z);
        set(h,'edgealpha',1,'facealpha',0);
        plot3(x,y,z,'.');
        grid on;view([-46,38]);
    end
    
    newTri1=newTri(:);
    newTri1(isnan(newTri1))=[];
    judgedProperty=x.*0;
    judgedProperty(newTri1)=1;
    ywJudgedResult=judgedProperty;
    ywAfterShockIndex=find(ywJudgedResult==1);
    ywBGIndex=find(ywJudgedResult==0);
end
