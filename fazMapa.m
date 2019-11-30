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

figure;
scatter(D,I);
figure;
scatter(V,I);