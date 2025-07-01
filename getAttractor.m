function [idState,aSize,vMu]=getAttractor(fStep,x0)

[vState,aSize,vMu]=cycleDetBrent(fStep,x0);

%get "highest" (as binary number) state as ID
currMax=vState;
for i=2:aSize
    vState=fStep(vState);
    if vState(find(xor(currMax,vState),1))
        currMax=vState;
    end
end
idState=currMax;