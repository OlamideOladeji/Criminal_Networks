T = readtable('Anonymous.csv');  %cooffending data set with structure according to datadescription.txt
noOfCases = height(T);
noOfOffenders=height(unique(T(:,1)));
noOfCrimeEvents=height(unique(T(:,4)));

%
noOfCrimeVec=[];
for year=2003:2010
   Ttemp = T(T.annee==year,:);
   noOfCrimeVal = height(unique(Ttemp(:,4)));
   noOfCrimeVec = [noOfCrimeVec noOfCrimeVal];
end

% get number of unique crimes groups. %Partition or Split into T 
G = findgroups(T(:,4));


%find the number of elements per group of criminal events see https://www.mathworks.com/help/matlab/ref/findgroups.html#buxwasl
offendercount = splitapply(@numel,T.SeqE,G);

%
%offendercountfake = offendercount;
offendercountfake = unique(offendercount);
[sortedValues,sortIndex] = sort(offendercountfake,'descend');  %# Sort the values in   descending order
%sortedValues = unique(sortedValues);
maxIndex = sortedValues(1:10); 
crimeList=[];
crimeMunList=[];
numOffendersInv = [];
for idx = 1:numel(maxIndex)
    offenderNum = maxIndex(idx);  %offender count value
    %index = max(offendercount);
    val = find(offendercount==offenderNum);
    if length(val)>1 
        for j=1:length(val)
            value=val(j);
            indexListinT=find(G==value);
            indexinT = indexListinT(1);
            crimeEventNumber = T.SeqE(indexinT);
            crimeMunicipality = T.MUN(indexinT);
            crimeList = [crimeList;crimeEventNumber]; 
            crimeMunList = [crimeMunList; crimeMunicipality];
            numOffendersInv = [numOffendersInv; offenderNum];
        end
    else
        indexListinT=find(G==val);
        indexinT = indexListinT(1);
        crimeEventNumber = T.SeqE(indexinT);
        crimeMunicipality = T.MUN(indexinT);
        crimeList = [crimeList;crimeEventNumber]; 
        crimeMunList = [crimeMunList; crimeMunicipality];
        numOffendersInv = [numOffendersInv; offenderNum];
    end
    
    
end

overallTopCrimeData = [crimeList numOffendersInv  crimeMunList];

%Initialize sparse Matrix of KxN
M = sparse(noOfOffenders,noOfCrimeEvents);

Tunique = unique(T);


idx = ismissing(T(:,{'ED1'}));
T{:,{'ED1'}}(idx) = 0;
%idx = ismissing(T(:,{'SEXE','SeqE','dateInf','NCD1','NCD2','NCD3','NCD4','MUN','ED1','Jeunes','Adultes','Date','annee'}));
 %T{:,{'SEXE','SeqE','dateInf','NCD1','NCD2','NCD3','NCD4','MUN','ED1','Jeunes','Adultes','Date','annee'}}(idx) = 0;

 %%%%start from here

l=length(Tunique.SeqE);
x=ones(l,1);
ivalues=Tunique.NoUnique;
jvalues=Tunique.SeqE;
A = sparse(ivalues,jvalues,x);
C=A*A';
C(logical(speye(size(C)))) = 0;

GG=graph(C);
Ggfake=graph(C);
deg=degree(GG);
vec2=find(deg==0);
vec = find(deg<1);
Cnew =C;
Cnew(vec,:)=[];
Cnew(:,vec)=[];

%
GraphOffend=graph(Cnew);
degfin= degree(GraphOffend);
plotDegreeDistribution(degfin)
compList=conncomp(GraphOffend);
nLargestComp=length(find(compList==mode(compList)));
largestCompnodes=find(compList==mode(compList));
GGsubgraph=subgraph(GraphOffend,largestCompnodes);
degsubgraph=degree(GGsubgraph);
plotDegreeDistribution(degsubgraph)
[sortedValuessub,sortdegsub] = sort(degsubgraph,'descend'); 
maxvalsub = sortedValuessub(1:5)

wbcsubgraph=centrality(GGsubgraph,'betweenness','Cost',GGsubgraph.Edges.Weight);
[sortedValwbcsub,sortwbcsub] = sort(wbcsubgraph,'descend'); 
maxvalwbcsub = sortedValwbcsub(1:5);
histograph(wbcsubgraph)
plot(wbcsubgraph)
plotBetweenessDistribution(wbcsubgraph)

wecsubgraph=centrality(GGsubgraph,'eigenvector','Importance',GGsubgraph.Edges.Weight);
[sortedValwecsub,sortwecsub] = sort(wecsubgraph,'descend'); 
maxvalwecsub = sortedValwecsub(1:5);
histogram(wecsubgraph)
figure
plot(wecsubgraph)
%plotBetweenessDistribution(wecsubgraph)


%Free form investigation.

%young = T(T.Adultes== 0,:);
%young = T(T.Adultes> 0,:);
young = T(T.Adultes> 0 & T.Jeunes>0,:);
youngv2= unique(young.SeqE);
adult=unique(young.NoUnique);
youngkilleddual=unique(young);




l=length(Tunique.SeqE);
x=ones(l,1);
ivalues=Tunique.NoUnique;
jvalues=Tunique.SeqE;
A = sparse(ivalues,jvalues,x);
C=A*A';
C(logical(speye(size(C)))) = 0;

GG=graph(C);
Ggfake=graph(C);
deg=degree(GG);
vec2=find(deg==0);
vec = find(deg<1);
Cnew =C;
Cnew(vec,:)=[];
Cnew(:,vec)=[];

%
GraphOffend=graph(Cnew);
degfin= degree(GraphOffend);
%find(T.SeqE==crimeEventNumber)  %gives list of indices of offenders who participated in crime with event no = crimeEventNumber