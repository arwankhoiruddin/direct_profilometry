function extr = findextrema(yref)
tsign = sign(yref(2)-yref(1));
extr=[];
i=1;
while i<length(yref)-1
    if (tsign ~= sign(yref(i+1)-yref(i)))
        % nek neng extrema ki ono lebih dari satu nilai
        if (sign(yref(i+1)-yref(i)) == 0) 
            i = i+1;
        else
            tsign = sign(yref(i+1)-yref(i));
            extr = [extr i];
        end
    end
    i=i+1;
end