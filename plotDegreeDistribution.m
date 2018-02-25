function plotDegreeDistribution(nodeid,indegree,outdegree,phaseno)
%given indegree vectors, outdegree vectors, and vector of nodeIDs, plot
%degree distribution
    %indegree
    kinmax=max(indegree);
    koutmax=max(outdegree);
    n=length(nodeid);
    Pin=zeros(kinmax+1,1);
    Pout=zeros(koutmax+1,1);
    
    for k=0:kinmax
        %how many nodes have in-degree n?
        nkin=length(find(indegree==k));
        Pin(k+1)=nkin/n;
    end
    
     for k=0:koutmax
        %how many nodes have in-degree n?
        nkout=length(find(outdegree==k));
        Pout(k+1)=nkout/n;
     end
         
     kvalin=0:kinmax;
     %now we can plot Pin with k, and pout with k,
     figure;
     bar(kvalin,Pin)
     title(['In-Degree Distribution for Phase ',num2str(phaseno)])
     xlabel('Degree k')
     ylabel('Fraction p_k of vertices with degree k')
     
     figure;
     kvalout=0:koutmax;
     bar(kvalout,Pout)
     title(['Out-Degree Distribution for Phase ',num2str(phaseno)])
     xlabel('Degree k')
     ylabel('Fraction p_k of vertices with degree k')
     
end