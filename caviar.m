clear;
%See publicly available caviar data set at https://sites.google.com/site/ucinetsoftware/datasets/covert-networks/caviar
%initialize Matrix of actors under_investigation
%first col is index of actors;    2 to 12th column is phase degrees;
investMat = NaN(23,12);
investMat(:,1)= [1;3;83;86;85;6;11;88;106;89;84;5;8;76;77;87;82;96;12;17;80;33;16];
investIDs=investMat(:,1);
investMatBtwn = NaN(23,12);
investMatindeg = NaN(23,12);
investMatoutdeg = NaN(23,12);
investMatEigen = NaN(23,12);

investMatBtwn(:,1)= [1;3;83;86;85;6;11;88;106;89;84;5;8;76;77;87;82;96;12;17;80;33;16];
investMatEigen(:,1)= [1;3;83;86;85;6;11;88;106;89;84;5;8;76;77;87;82;96;12;17;80;33;16];
investMatindeg(:,1)= [1;3;83;86;85;6;11;88;106;89;84;5;8;76;77;87;82;96;12;17;80;33;16];
investMatoutdeg(:,1)= [1;3;83;86;85;6;11;88;106;89;84;5;8;76;77;87;82;96;12;17;80;33;16];




M1=csvread('phase1.csv',1,0);
ids1=M1(:,1);
%M2mat=zeros(110,110);
M1noID=M1(:,2:end);
G1=digraph(M1noID);
indeg1=indegree(G1);
outdeg1=outdegree(G1);
wbc1 = centrality(G1,'betweenness', 'Cost',G1.Edges.Weight);  %betweeness
wec1 = centrality(G1,'pagerank', 'Importance',G1.Edges.Weight);
for i=1:length(investIDs)
    if length(find(ids1==investIDs(i)))>0
        location=find(ids1==investIDs(i));
        investMatindeg(i,2)=indeg1(location);
        investMatoutdeg(i,2)=outdeg1(location);
        investMat(i,2)=outdeg1(location)+indeg1(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,2)=wbc1(location);
        investMatEigen(i,2)=wec1(location);
        
    end
end 

M2=csvread('phase2.csv',1,0);
ids2=M2(:,1);
%M2mat=zeros(110,110);
M2noID=M2(:,2:end);
G2=digraph(M2noID);
indeg2=indegree(G2);
outdeg2=outdegree(G2);
wbc2 = centrality(G2,'betweenness', 'Cost',G2.Edges.Weight);  %betweeness
wec2 = centrality(G2,'pagerank', 'Importance',G2.Edges.Weight);
for i=1:length(investIDs)
    if length(find(ids2==investIDs(i)))>0
        location=find(ids2==investIDs(i));
        investMatindeg(i,3)=indeg2(location);
        investMatoutdeg(i,3)=outdeg2(location);
        investMat(i,3)=outdeg2(location)+indeg2(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,3)=wbc2(location);
        investMatEigen(i,3)=wec2(location);
    end
end 

M3=csvread('phase3.csv',1,0);
ids3=M3(:,1);
%M2mat=zeros(110,110);
M3noID=M3(:,2:end);
G3=digraph(M3noID);
indeg3=indegree(G3);
outdeg3=outdegree(G3);
wbc3 = centrality(G3,'betweenness', 'Cost',G3.Edges.Weight);  %betweeness
wec3 = centrality(G3,'pagerank', 'Importance',G3.Edges.Weight);
for i=1:length(investIDs)
    if length(find(ids3==investIDs(i)))>0
        location=find(ids3==investIDs(i));
        investMatindeg(i,4)=indeg3(location);
        investMatoutdeg(i,4)=outdeg3(location);
        investMat(i,4)=outdeg3(location)+indeg3(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,4)=wbc3(location);
        investMatEigen(i,4)=wec3(location);
    end
end 


%%%%%%

M4=csvread('phase4.csv',1,0);
ids4=M4(:,1);
%M2mat=zeros(110,110);
M4noID=M4(:,2:end);
G4=digraph(M4noID);
indeg4=indegree(G4);
outdeg4=outdegree(G4);
wbc4 = centrality(G4,'betweenness', 'Cost',G4.Edges.Weight);  %betweeness
wec4 = centrality(G4,'pagerank', 'Importance',G4.Edges.Weight);
for i=1:length(investIDs)
    if length(find(ids4==investIDs(i)))>0
        location=find(ids4==investIDs(i));
        investMatindeg(i,5)=indeg4(location);
        investMatoutdeg(i,5)=outdeg4(location);
        investMat(i,5)=outdeg4(location)+indeg4(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,5)=wbc4(location);
        investMatEigen(i,5)=wec4(location);
    end
end       
        
%plotDegreeDistribution(ids4,indeg4,outdeg4,4)


%5
M5=csvread('phase5.csv',1,0);
ids5=M5(:,1);
%M2mat=zeros(110,110);
M5noID=M5(:,2:end);
G5=digraph(M5noID);
indeg5=indegree(G5);
outdeg5=outdegree(G5);
wbc5 = centrality(G5,'betweenness', 'Cost',G5.Edges.Weight);  %betweeness
wec5 = centrality(G5,'pagerank', 'Importance',G5.Edges.Weight);
%plotDegreeDistribution(ids5,indeg5,outdeg5,5)
for i=1:length(investIDs)
    if length(find(ids5==investIDs(i)))>0
        location=find(ids5==investIDs(i));
        investMatindeg(i,6)=indeg5(location);
        investMatoutdeg(i,6)=outdeg5(location);
        investMat(i,6)=outdeg5(location)+indeg5(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,6)=wbc5(location);
        investMatEigen(i,6)=wec5(location);
    end
end       
    

%6
M6=csvread('phase6.csv',1,0);
ids6=M6(:,1);
%M2mat=zeros(110,110);
M6noID=M6(:,2:end);
G6=digraph(M6noID);
indeg6=indegree(G6);
outdeg6=outdegree(G6);
wbc6 = centrality(G6,'betweenness', 'Cost',G6.Edges.Weight);  %betweeness
wec6 = centrality(G6,'pagerank', 'Importance',G6.Edges.Weight);
%plotDegreeDistribution(ids6,indeg6,outdeg6,6)
for i=1:length(investIDs)
    if length(find(ids6==investIDs(i)))>0
        location=find(ids6==investIDs(i));
        investMatindeg(i,7)=indeg6(location);
        investMatoutdeg(i,7)=outdeg6(location);
        investMat(i,7)=outdeg6(location)+indeg6(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,7)=wbc6(location);
        investMatEigen(i,7)=wec6(location);
    end
end       
    

%7
M7=csvread('phase7.csv',1,0);
ids7=M7(:,1);
%M2mat=zeros(110,110);
M7noID=M7(:,2:end);
G7=digraph(M7noID);
indeg7=indegree(G7);
outdeg7=outdegree(G7);
wbc7 = centrality(G7,'betweenness', 'Cost',G7.Edges.Weight);  %betweeness
wec7 = centrality(G7,'pagerank', 'Importance',G7.Edges.Weight);
%plotDegreeDistribution(ids7,indeg7,outdeg7,7)
for i=1:length(investIDs)
    if length(find(ids7==investIDs(i)))>0
        location=find(ids7==investIDs(i));
        investMatindeg(i,8)=indeg7(location);
        investMatoutdeg(i,8)=outdeg7(location);
        investMat(i,8)=outdeg7(location)+indeg7(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,8)=wbc7(location);
        investMatEigen(i,8)=wec7(location);
    end
end       
    

%8
M8=csvread('phase8.csv',1,0);
ids8=M8(:,1);
%M2mat=zeros(110,110);
M8noID=M8(:,2:end);
G8=digraph(M8noID);
indeg8=indegree(G8);
outdeg8=outdegree(G8);
wbc8 = centrality(G8,'betweenness', 'Cost',G8.Edges.Weight);  %betweeness
wec8 = centrality(G8,'pagerank', 'Importance',G8.Edges.Weight);
%plotDegreeDistribution(ids8,indeg8,outdeg8,8)
for i=1:length(investIDs)
    if length(find(ids8==investIDs(i)))>0
        location=find(ids8==investIDs(i))
        investMatindeg(i,9)=indeg8(location);
        investMatoutdeg(i,9)=outdeg8(location);
        investMat(i,9)=outdeg8(location)+indeg8(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,9)=wbc8(location);
        investMatEigen(i,9)=wec8(location);
    end
end       
    

%9
M9=csvread('phase9.csv',1,0);
ids9=M9(:,1);
%M2mat=zeros(110,110);
M9noID=M9(:,2:end);
G9=digraph(M9noID);
indeg9=indegree(G9);
outdeg9=outdegree(G9);
wbc9 = centrality(G9,'betweenness', 'Cost',G9.Edges.Weight);  %betweeness
wec9 = centrality(G9,'pagerank', 'Importance',G9.Edges.Weight);
%plotDegreeDistribution(ids9,indeg9,outdeg9,9)
for i=1:length(investIDs)
    if length(find(ids9==investIDs(i)))>0
        location=find(ids9==investIDs(i));
        investMatindeg(i,10)=indeg9(location);
        investMatoutdeg(i,10)=outdeg9(location);
        investMat(i,10)=outdeg9(location)+indeg9(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,10)=wbc9(location);
        investMatEigen(i,10)=wec9(location);
    end
end       
    

%10
M10=csvread('phase10.csv',1,0);
ids10=M10(:,1);
%M2mat=zeros(110,110);
M10noID=M10(:,2:end);
G10=digraph(M10noID);
indeg10=indegree(G10);
outdeg10=outdegree(G10);
wbc10 = centrality(G10,'betweenness', 'Cost',G10.Edges.Weight);  %betweeness
wec10 = centrality(G10,'pagerank', 'Importance',G10.Edges.Weight);
%plotDegreeDistribution(ids10,indeg10,outdeg10,10)
for i=1:length(investIDs)
    if length(find(ids10==investIDs(i)))>0
        location=find(ids10==investIDs(i));
        investMatindeg(i,11)=indeg10(location);
        investMatoutdeg(i,11)=outdeg10(location);
        investMat(i,11)=outdeg10(location)+indeg10(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,11)=wbc10(location);
        investMatEigen(i,11)=wec10(location);
    end
end       
    

%11
M11=csvread('phase11.csv',1,0);
ids11=M11(:,1);
%M2mat=zeros(110,110);
M11noID=M11(:,2:end);
G11=digraph(M11noID);
indeg11=indegree(G11);
outdeg11=outdegree(G11);
wbc11 = centrality(G11,'betweenness', 'Cost',G11.Edges.Weight);  %betweeness
wec11 = centrality(G11,'pagerank', 'Importance',G11.Edges.Weight);
%plotDegreeDistribution(ids11,indeg11,outdeg11,11)
for i=1:length(investIDs)
    if length(find(ids11==investIDs(i)))>0
        location=find(ids11==investIDs(i));
        investMatindeg(i,12)=indeg11(location);
        investMatoutdeg(i,12)=outdeg11(location);
        investMat(i,12)=outdeg11(location)+indeg11(location);    %the degree of the ith Invest ID  in fourth face is xyz
        investMatBtwn(i,12)=wbc11(location);
        investMatEigen(i,12)=wec11(location);
    end
end       
    


%%extract active people in all phases.
%1. Degree centrality 
%deg=indeg11 + outdeg11
k=sum(wec11>0.03);
[B,I]=maxk(wec11,k);
el=0
for i=1:length(I)
    asa=I(i); %get in
    el(i)=ids11(asa);  %get IDs of the nonzeros.
end
C = setdiff(el,investIDs) %returns the data in A that is not in B, with no repetitions. C is in sorted order.
C = C';

figure
%LWidths = 5*G1.Edges.Weight/max(G1.Edges.Weight);
plot(G1,'NodeLabel',ids1,'EdgeLabel',G1.Edges.Weight)
title('Graph of Phase 1')


figure
plot(G2,'NodeLabel',ids2,'EdgeLabel',G2.Edges.Weight)
title('Graph of Phase 2')
figure
plot(G3,'NodeLabel',ids3,'EdgeLabel',G3.Edges.Weight)
title('Graph of Phase 3')
figure
plot(G4,'NodeLabel',ids4,'EdgeLabel',G4.Edges.Weight)
title('Graph of Phase 4')
figure
plot(G5,'NodeLabel',ids5,'EdgeLabel',G5.Edges.Weight)
title('Graph of Phase 5')
figure
plot(G6,'NodeLabel',ids6,'EdgeLabel',G6.Edges.Weight)
title('Graph of Phase 6')
figure
plot(G7,'NodeLabel',ids7,'EdgeLabel',G7.Edges.Weight)
title('Graph of Phase 7')
figure
plot(G8,'NodeLabel',ids8,'EdgeLabel',G8.Edges.Weight)
title('Graph of Phase 8')
figure
plot(G9,'NodeLabel',ids9,'EdgeLabel',G9.Edges.Weight)
title('Graph of Phase 9')
figure
plot(G10,'NodeLabel',ids10,'EdgeLabel',G10.Edges.Weight)
title('Graph of Phase 10')
figure
plot(G11,'NodeLabel',ids11,'EdgeLabel',G11.Edges.Weight)
title('Graph of Phase 11')

%LWidths = 5*G.Edges.Weight/max(G.Edges.Weight);
%plot(G,'EdgeLabel',G.Edges.Weight,'LineWidth',LWidths)


% 


    
