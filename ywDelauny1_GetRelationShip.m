function[tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw)
    eqTime0=eqTime(1);
    eqLongi0=eqLongi(1);
    eqLati0=eqLati(1);
    
    x=(eqLongi-eqLongi0)*110;
    y=(eqLati-eqLati0)*110;
    z=(eqTime-eqTime0)*C;
    if(ywDraw==1)
        figure;
        subplot(221);hold on;
        plot3(x,y,z,'o');
        grid on;
        view([-46,38]);
    end
    tri=delaunay(x,y,z);
    if(ywDraw==1)
        subplot(222);
        h=trimesh(tri,x,y,z);
        set(h,'edgealpha',1,'facealpha',0) ;
        grid on;
        view([-46,38]);

        subplot(223);hold on;
        h=trisurf(tri,x,y,z);
        set(h,'edgealpha',0,'facealpha',0.3) ;
        h=trimesh(tri,x,y,z);
        set(h,'edgealpha',1,'facealpha',0) ;
        grid on;
        view([-46,38]);
    end

    %四面体的四个点号(x1,x2,x3,x4),(y1,y2,y3,y4) (z1,z2,z3,z4)
    x1=x(tri(:,1));    y1=y(tri(:,1));    z1=z(tri(:,1));
    x2=x(tri(:,2));    y2=y(tri(:,2));    z2=z(tri(:,2));
    x3=x(tri(:,3));    y3=y(tri(:,3));    z3=z(tri(:,3));
    x4=x(tri(:,4));    y4=y(tri(:,4));    z4=z(tri(:,4));
    
    %四面体的六条边的边长(x1,x2,x3,x4),(y1,y2,y3,y4) (z1,z2,z3,z4)
    [dis12]=ywGetDis3D(x1,y1,z1,x2,y2,z2);
    [dis23]=ywGetDis3D(x3,y3,z3,x2,y2,z2);
    [dis13]=ywGetDis3D(x1,y1,z1,x3,y3,z3);
    [dis14]=ywGetDis3D(x1,y1,z1,x4,y4,z4);
    [dis24]=ywGetDis3D(x4,y4,z4,x2,y2,z2);
    [dis34]=ywGetDis3D(x3,y3,z3,x4,y4,z4);
end
