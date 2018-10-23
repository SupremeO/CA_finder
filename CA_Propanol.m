%% Felix Agbavor (fa424@drexel.edu), v 1.0

%% Function to determine contact angle to Propanol
function angle = CA_Propanol()
% CA_PROPANOL()
    handle = findobj('tag','B08'); % get object handle for BW3 figure
    BW3 = get(handle,'Userdata'); % get data of BW3
    
    % second Pre-processing
    L2 = bwlabeln(BW3);
    S2 = regionprops(BW3,'Area');
    BW4 = ismember(L2, find([S2.Area] == max( [S2.Area]) ));
    [B,L] = bwboundaries(BW4,'noholes');
    imshow(label2rgb(L))
    hold on
    boundary = B{1};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
    
    uiwait(msgbox({'Click and drag mouse to';'zoom on area of droplet'},'Action','modal'));
    rect = getrect;
    figure
    imshow(BW3(rect(2):(rect(2)+rect(4)),rect(1):(rect(1)+rect(3))));
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    uiwait(msgbox({'Select points on the';'edge of droplet'},'Action','modal'));
    [x, yy, ~] = impixel;
    hold on
    x1 = x;
    y = smooth(x,yy,0.1,'rloess'); % smooth data to remove outliers
    plot(x,y,'o')
    
    [f,~,~]=fit(x,y,'poly2'); % fit curve
    h = plot(f,x,y); 
    set(h,'linewidth',2);
    
    uiwait(msgbox({'Click and drag to draw horizontal line'},'Action','modal'));
    [cx,cy,~] = improfile;
    p = polyfit(cx,cy,1);
    yy = polyval(p,cx);
    plot(cx,yy,'b','LineWidth',2)
    m1 = p(1);
    
    m2 = 2*f.p1.*x1 + f.p2;
    angles = atand((m1 - m2)./(1+(m1.*m2)));
    CA = abs(angles);
    
    angle = max(CA);
    
return 


