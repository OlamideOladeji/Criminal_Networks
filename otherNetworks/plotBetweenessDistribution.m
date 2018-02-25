function plotBetweenessDistribution(betweeness)
%given indegree vectors, outdegree vectors, and vector of nodeIDs, plot
%degree distribution
    %indegree
    %kinmax=max(degrees);
    kmax=max(betweeness);
    n=length(betweeness);
    %Pin=zeros(kinmax+1,1);
    P=zeros(kmax+1,1);
    
    %for k=0:kinmax
    %    %how many nodes have in-degree n?
    %    nkin=length(find(indegree==k));
    %    Pin(k+1)=nkin/n;
    %end
    
     for k=0:kmax
        %how many nodes have in-degree n?
        nk=length(find(betweeness==k));
        P(k+1)=nk/n;
     end
         
     %kvalin=0:kmax;
     %now we can plot Pin with k, and pout with k,
     %figure;
     %bar(kvalin,Pin)
     %title(['In-Degree Distribution for Phase ',num2str(phaseno)])
     %xlabel('Degree k')
     %ylabel('Fraction p_k of vertices with degree k')
     
     figure;
     kval=0:kmax;
     bar(kval,P);
     title(['Betweeness Distribution Of the Largest Connected Component of Co-Offending Network'])
     xlabel('Degree b')
     ylabel('Fraction p_b of nodes with Betweeness b')
     
end