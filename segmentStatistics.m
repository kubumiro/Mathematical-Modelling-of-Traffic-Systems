clear all

load('MMDS_data.mat','time','velo','gap','delka','clearance')

M=50;
N=floor(length(time)/M);

I = nan(N,1); %tok
D = nan(N,1); %hustota
V = nan(N,1);
Vsave = nan(N,50);


for i=1:N
    V(i) = mean(velo(M*(i-1)+1:M*i));
    Vsave(i,:) = velo((M*(i-1)+1):M*i);
    I(i) = M/(time(M*i)-time(M*(i-1)+1))*3600;
    D(i) = I(i)/V(i);
end


%moje deleni segmentu
indI = [];indD = [];

for j=1:6
    indI(j) = 900*j-900;
end

for i=1:8
    indD(i) = 10*i-10;
end

ind = [];
for j=1:7
    for k=1:5
        ind(j,k,:) = (indD(j) <= D) & (D <= indD(j+1)) & (indI(k) <= I) & (I <= indI(k+1));
    end
end

%ukladani pozorovanych statistik pro dane segmenty
SegD=[];meanV=[];varV=[];h=[];p=[];numV = [];

for i=1:7
    for j=1:5
        %SegD(i,j,:) = D(logical(ind(i,j,:)));
%         meanV(i,j) = mean(V(logical(ind(i,j,:)))); %prumer
%         varV(i,j) = var(V(logical(ind(i,j,:)))); %rozptyl
%         numV(i,j) = numel(V(logical(ind(i,j,:)))); %pocet prvku
%         if numel(V(logical(ind(i,j,:))))<5 
%             h(i,j) = NaN;
%             p(i,j) = NaN;
%         else
%         [h(i,j),p(i,j)] = adtest(V(logical(ind(i,j,:)))); %p-value pro AD test
%         end
 %SegD(i,j,:) = D(logical(ind(i,j,:)));
        meanV(i,j) = mean(reshape(Vsave(logical(ind(i,j,:)),:),[1, numel(Vsave(logical(ind(i,j,:)),:))])); %prumer
        varV(i,j) = var(reshape(Vsave(logical(ind(i,j,:)),:),[1, numel(Vsave(logical(ind(i,j,:)),:))])); %rozptyl
        numV(i,j) = numel(reshape(Vsave(logical(ind(i,j,:)),:),[1, numel(Vsave(logical(ind(i,j,:)),:))])); %pocet prvku
        %num(i,j) = numel(Vsave(logical(ind(i,j,:)),:));
        if numel(Vsave(logical(ind(i,j,:)),:))<5 
            h(i,j) = NaN;
            p(i,j) = NaN;
        else
        [h(i,j),p(i,j)] = adtest(reshape(Vsave(logical(ind(i,j,:)),:),[1, numel(Vsave(logical(ind(i,j,:)),:))])); %p-value pro AD test
        end
    end
end


%plot fundamental diagram with selected (3,2) segment
figure;
scatter(D,I,'x');
hold on
scatter(D(logical(ind(3,2,:))),I(logical(ind(3,2,:))),'x','m')
xlim([0 70]);
ylim([0 4500]);
xlabel('Density $$\rho$$ [1/km]', 'interpreter', 'latex','FontSize',16);
ylabel('Itensity $$I$$ [1/h]', 'interpreter', 'latex','FontSize',16);
hold off

%vratim spravne rozmery matic ze segmentu
meanVr = rot90(meanV);
varVr = rot90(varV);
pr = rot90(p);
numV = rot90(numV);

%plot mean velocity color matrix
figure;
imagesc([5 65], [450 4050], flipud(meanVr),'AlphaData',~isnan(flipud(meanVr)))
cb=colorbar;
ylabel(cb,'Mean velocity $$\textrm{E}(V)$$ [km/h]', 'interpreter', 'latex','FontSize',17);
xlabel('Density $$\rho$$ [1/km]', 'interpreter', 'latex','FontSize',17);
ylabel('Itensity $$I$$ [1/h]', 'interpreter', 'latex','FontSize',17);
set(gca,'YDir','normal');


%plot variance of velocity color matrix
figure;
imagesc([5 65], [450 4050], flipud(varVr),'AlphaData',~isnan(flipud(varVr)))
cb=colorbar;
ylabel(cb,'Variance of velocity $$\textrm{Var}(V)$$  $$[km/h]^2$$', 'interpreter', 'latex','FontSize',17);
ylabel('Itensity $$I$$ [1/h]', 'interpreter', 'latex','FontSize',17);
xlabel('Density $$\rho$$ [1/km]', 'interpreter', 'latex','FontSize',17);
set(gca,'YDir','normal');

%plot mean velocity color matrix with fundamental diagram
figure;
scatter(D,I,'x','k');
hold on
im = imagesc([5 65], [450 4050], flipud(meanVr),'AlphaData',0.65);
im.AlphaData = ~isnan(flipud(meanVr))*0.65;
cb=colorbar;
ylabel(cb,'Mean velocity $$\textrm{E}(V)$$ [km/h]', 'interpreter', 'latex','FontSize',17);
xlabel('Density $$\rho$$ [1/km]', 'interpreter', 'latex','FontSize',17);
ylabel('Itensity $$I$$ [1/h]', 'interpreter', 'latex','FontSize',17);
set(gca,'YDir','normal');
hold off

%plot variance of velocity color matrix with fundamental diagram
figure;
scatter(D,I,'x','k');
hold on
im = imagesc([5 65], [450 4050], flipud(varVr),'AlphaData',0.65);
im.AlphaData = ~isnan(flipud(varVr))*0.65;
cb=colorbar;
ylabel(cb,'Variance of velocity $$\textrm{Var}(V)$$  $$[km/h]^2$$', 'interpreter', 'latex','FontSize',17);
xlabel('Density $$\rho$$ [1/km]', 'interpreter', 'latex','FontSize',17);
ylabel('Itensity $$I$$ [1/h]', 'interpreter', 'latex','FontSize',17);
set(gca,'YDir','normal');
hold off





