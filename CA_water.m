%% Felix Agbavor (fa424@drexel.edu), v 1.0


function [angle] = CA_water()
    handle = findobj('tag','B08');
    BW3 = get(handle,'Userdata');
    L2 = bwlabeln(BW3);
    S2 = regionprops(BW3,'Area');
    BW4 = ismember(L2, find([S2.Area] == max( [S2.Area]) ));
    [B,L] = bwboundaries(BW4,'noholes');
    imshow(label2rgb(L))
    hold on
    % detect boundary of image
    boundary = B{1};
    fig1 = plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2); % plot edge boundary detected 

    uiwait(msgbox({'Click and drag mouse to';'zoom on area of droplet'},'Action','modal'));
    
    % zoom in on image
    rect = getrect; 
    figure
    imshow(BW3(rect(2):(rect(2)+rect(4)),rect(1):(rect(1)+rect(3)))); 
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    % Two stage fiting of data
   m2 = [];
    for i = 1:2
        if i == 1
            msg = sprintf('%s \n %s','Select points on','half edge of droplet');
            uiwait(msgbox( msg,'Action','modal'));
            [x, y, ~] = impixel;
            [fitresult, ~,xData] = createFit1(x, y);
            m2 = [m2;findgrad(xData,fitresult)];
        else
            msg = sprintf('%s \n %s','Select points on other','half edge of droplet');
            uiwait(msgbox( msg,'Action','modal'));
            [x, y, ~] = impixel;
            [fitresult, ~,xData] = createFit1(x, y);
            m2 = [m2;findgrad(xData,fitresult)];
        end
    end
    
    uiwait(msgbox({'Click and drag to draw horizontal line'},'Action','modal'));
    [cx,cy,~] = improfile;
    p = polyfit(cx,cy,1);
    yy = polyval(p,cx);
    plot(cx,yy,'b','LineWidth',2)
    m1 = p(1);
   
    angles = atand((m1 - m2)./(1+(m1.*m2)));
    CA = abs(angles);
    
    angle = max(CA);
return 





