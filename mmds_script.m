load('MMDS_data.mat', 'time', 'velo', 'gap', 'delka', 'clearance');


% moje barvicky
color = [ 0 0.4470 0.7410;...
0.8500 0.3250 0.0980;...
0.9290 0.6940 0.1250;...
0.4940 0.1840 0.5560;...
0.4660 0.6740 0.1880;...
0.3010 0.7450 0.9330;...
0.6350 0.0780 0.1840 ];



M = 50; % pocet vozidel ve vzorku
N = floor(length(time)/M); % celkovy pocet vzorku
I = nan(N, 1);
D = nan(N, 1);
V = nan(N, 1);



for i = 1 : N
% indexy naseho i-teho vzorku
firstM = (i-1)*M + 1;
lastM = i*M;
indM = firstM:lastM;
% veliciny naseho i-teho vzorku
subT = time(indM);
subV = velo(indM);
% fazove veliciny
I(i) = M*3600/(subT(end) - subT(1)); % intenzita (tok)
V(i) = mean(subV); % rychlost
D(i) = I(i)/V(i); % hustota
end



% fazova mapa 1
figure(1);
plot(D, I, 'x')
xlabel('Density $$\rho$$ [1/km]', 'interpreter', 'latex')
ylabel('Intensity $$I$$ [1/h]', 'interpreter', 'latex')

% fazova mapa 2
figure(2);
plot(D, V, 'x')
xlabel('Density $$\rho$$ [1/km]', 'interpreter', 'latex')
ylabel('Velocity $$V$$ [km/h]', 'interpreter', 'latex')




ind = [];
segmentC = [];




% 2. segmentace
% nami zvoleny fazovy segment




indI = [];

for j=1:10
    indI(j) = 500*j-500; 
end


indD = [];

for i=1:8 
   indD(i) = 10*i-10;
end

ind = [];
for j=1:8
    for k=1:10
        ind(j,k) = (indD(j) <= D) & (D <= indD(j+1)) & (indI(k) <= I) & (I <= indI(k+1));
        
        %if D(i) >= indD(j) && D(i) <= indD(j+1) && I(i) >= indI(k) && I(i) <= indI(k+1)
        
    end
end


if D(i) >= 40 && D(i) <= 50 && I(i) >= 1000 && I(i) <= 2000
    ind = [ind, indM];
    subC = clearance(indM);
    % 3. skalovani (pro kazdy vzorek zvlast)
    segmentC = [segmentC; subC./mean(subC)];
    clear subC
end

