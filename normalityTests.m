load('MMDS_data.mat', 'velo');

subplot(1,2,1)
histogram(velo,60);
xlabel('Velocity $$V$$ [km/h]', 'interpreter','latex');
ylabel('Count', 'interpreter', 'latex');
set(gca,'FontSize',14);

subplot(1,2,2)
histogram(velo,180);
xlabel('Velocity $$V$$ [km/h]', 'interpreter','latex');
ylabel('Count', 'interpreter', 'latex');
set(gca,'FontSize',14);

%% plot QQ plot
% qq = qqplot(velo);
% set(gca,'FontSize',16);
% title(gca,' ');

%normality tests
% [h_l,p_l,kstat_l,cv_l] = lillietest(velo)
% [h_ad,p_ad,kstat_ad,cv_ad] = adtest(velo(1:150))





