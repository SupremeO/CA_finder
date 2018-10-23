%% Felix Agbavor (fa424@drexel.edu), v 1.0

%% FINDANGLES(X,FITRESULT)

function grad = findgrad(t,fitresult)

coeffvals = coeffvalues(fitresult); % get coeeficients of after fitting of curve

% establish function f(t) to be deferentiated
% f = (coeffvals(1)*t^5 + coeffvals(2)*t^4 + coeffvals(3)*t^3  + coeffvals(4)*t^2  +...
%         coeffvals(5)*t  + coeffvals(6))/( t^3  + coeffvals(7)*t^2 + coeffvals(8)*t^1  + coeffvals(9)); 

% get gradients
grad = (coeffvals(1)*5*t.^4 + coeffvals(2)*4*t.^3 + coeffvals(3)*3*t.^2 + coeffvals(4)*t+ coeffvals(5))./...
    (t.^3  + coeffvals(7)*t.^2 + coeffvals(8)*t  + coeffvals(9)) - ...
    ((3*t.^2 + coeffvals(7)*2*t + coeffvals(8)).*(coeffvals(1)*t.^5 + coeffvals(2)*t.^4 + coeffvals(3)*t.^3  + ...
    coeffvals(4)*t.^2  + coeffvals(5)*t  + coeffvals(6)))./(t.^3  + coeffvals(7)*t.^2 + coeffvals(8)*t.^1  + coeffvals(9)).^2;



