function [tortoise,vLambda,vMu]=cycleDetBrent(f,x0)
    %1: looking for repetition
    vPower=1;
    vLambda=1;
    tortoise=x0;
    hare=f(x0);
    while ~isequal(tortoise,hare)
        if vPower==vLambda
            tortoise=hare;
            vPower=vPower*2;
            vLambda=0;
        end
        hare=f(hare);
        vLambda=vLambda+1;
    end

    %2: find the first cycle
    tortoise=x0;
    hare=x0;
    for i=1:vLambda
        hare=f(hare);
    end
    %effective dist of T and H is vLambda
    %move parallel:
    vMu=0;
    while ~isequal(tortoise,hare)
        tortoise=f(tortoise);
        hare=f(hare);
        vMu=vMu+1;
    end
    
end