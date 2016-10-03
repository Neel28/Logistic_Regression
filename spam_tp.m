load xtr_1

NrGrid = 2;                                 % Number Of Grids
x = linspace(-2, 2,NrGrid+1);
[X,Y] = meshgrid(x);
figure(1)
plot(X,Y,'k')
hold on
plot(Y,X,'k')
hold on
for row=1:size(xTr_1,1)
    if yTr_1(row,1)==1
        plot(xTr_1(row,1),xTr_1(row,2),'r:')
    else 
        plot(xTr_1(row,1),xTr_1(row,2),'b:')
    end 
end
hold off
set(gca, 'Box','off', 'XTick',[], 'YTick',[])
axis square


%{

m = norm_train(:,3);
 
m=sort(m);
t=length(m)/10;
t=int8(t);
s=reshape(m,t,[]);
%}
%{
% Normal distribution
ages=randn(10000,1)';

% Use to make ages where 0<age<100
ages=ages-min(ages);
ages=ages/max(ages)*100;

% Hist them
figure(1)
hist(ages,10)
                 
% Split into similarly sized groups and hist again
s=sort(ages);
figure(2)
hist(ages,s(500:1000:10000))
%}

%{
%# compute bins
nbins = 10;
binEdges = linspace(min(M),max(M),nbins+1);
aj = binEdges(1:end-1);     %# bins lower edge
bj = binEdges(2:end);       %# bins upper edge
cj = ( aj + bj ) ./ 2;      %# bins center

%# assign values to bins
[~,binIdx] = histc(M, [binEdges(1:end-1) Inf]);

%# count number of values in each bin
nj = accumarray(binIdx, 1, [nbins 1], @sum);

%# plot histogram
bar(cj,nj,'hist')
set(gca, 'XTick',binEdges, 'XLim',[binEdges(1) binEdges(end)])
xlabel('Bins'), ylabel('Counts'), title('histogram of measured bacterial')

%}
%{
F = ceil(10 * tiedrank(M) / length(M));
tabulate(F)
%}
%{
M=f;
K=10;
[n,m]=size(M);
np=(n-rem(n,K))/K;
B=M;
[c,idx]=sort(rand(n,1));
C=M(idx,:);
i=1;
j=1;
ptrA={};
idxo={};
n-mod(n,K)
while i<n-mod(n,K)
    prtA{j}=C(i:i+np-1,:);
    idxo{i}=idx(i:i+np-1,1);
    i=i+np;
    j=j+1;
end
prtA{j}=C(i:n,:);
%}

