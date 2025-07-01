function sOut=networkTrial(fixedInput,numStarts,startFreq,showTimer)
global theta thetaCurrent
%input: fixed states, num(random starting states), W(eighted rel table, global),
%theta (thresholds)

if nargin<4, showTimer=true; end

tic;

numNodes=length(theta);

%add fixed points to threshold vector
thetaCurrent=theta;
thetaCurrent(fixedInput>0)=-100;
thetaCurrent(fixedInput<0)=100;

if showTimer, wb=waitbar(0,'Running networkTrial'); end
rng(startFreq*100); %for repeatability %
expectedMax=200;
attractors=false(numNodes,expectedMax);
attractorFreq=zeros(expectedMax,1);
attractorSize=zeros(expectedMax,1);
attractorTrip=zeros(expectedMax,1);
numAttractors=0;
idFullZero=0;
%vTrip=NaN(numStarts,1);
for i=1:numStarts
    x0=rand(numNodes,1)<startFreq; %get random starting state
    x0(fixedInput>0)=1; x0(fixedInput<0)=0;
    [idState,vLambda,vMu]=getAttractor(@ppiStep,x0);
    if sum(idState)==0
        if ~idFullZero
            numAttractors=numAttractors+1;
            attractorFreq(numAttractors)=1;
            attractorSize(numAttractors)=vLambda;
            attractorTrip(numAttractors)=vMu;
            idFullZero=numAttractors;
        else
            attractorFreq(idFullZero)=attractorFreq(idFullZero)+1;
        end
    else
        %vTrip(i)=vMu;
        isKnown=find(ismember(idState',attractors','rows'),1);
        if isKnown
            attractorFreq(isKnown)=attractorFreq(isKnown)+1;
        else
            numAttractors=numAttractors+1;
            attractors(:,numAttractors)=idState;
            attractorFreq(numAttractors)=1;
            attractorSize(numAttractors)=vLambda;
            attractorTrip(numAttractors)=vMu;
        end
    end
    if showTimer, waitbar(i/numStarts,wb); end
end

%create output
sOut=struct('idState',mat2cell(attractors(:,1:numAttractors),numNodes,ones(1,numAttractors))', ...
            'size',num2cell(attractorSize(1:numAttractors)), ...
            'freq',num2cell(attractorFreq(1:numAttractors)), ...
            'trip',num2cell(attractorTrip(1:numAttractors)));
        
if showTimer
    close(wb);
    disp(['Run took ',datestr(toc/86400,'HH:MM:SS')]);
end
