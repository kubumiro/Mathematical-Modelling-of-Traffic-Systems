clear all

load('MMDS_data.mat','time','velo','gap','delka','clearance')

M=50;
N=floor(length(time)/M);

I = nan(N,1); %tok
D = nan(N,1); %hustota
V = nan(N,1);




for i=1:N
V(i) = mean(velo(M*(i-1)+1:M*i));
I(i) = M/(time(M*i)-time(M*(i-1)+1))*3600;
D(i) = I(i)/V(i);
    
end

ind = (40 <= D) & (D <= 50) & (1000 <= I) & (I <= 2000);


D = D(ind);
I = I(ind); 
V = V(ind);

clseg = [];

for i=1:N
    if ind(i)==1
        clpom = clearance((i-1)*M+1:i*M);
        clpom = clpom/mean(clpom);
        clseg = [clseg;clpom];
    end
    
    clear clpom
    
end

histogram(clseg,80)





