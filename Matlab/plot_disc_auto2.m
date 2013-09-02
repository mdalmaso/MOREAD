function plot_disc_auto(in,out,sym)
% make_figs


a = [out.time(:) out.concs];

nus = in.nucsize;
% Dp = ((1:1000).*(6.*8.89e-29.*3./(4.*pi))).^(1./3); 
Dp = out.wetdiam; 
Dpdry = out.drydiam; 

[ro co]  = size(a);

i1 = 1; 
i2 = floor(ro./4);
i3 = floor(ro./2);
i4 = floor(ro.*0.75);
i5 = ro;

sc = 1e6;

% figure
% plot(Dp(nus:1000),a(i1,nus:1000)./sc,'m*')
% hold on
% plot(Dp(nus:1000),a(i2,nus:1000)./sc,'r*')
% plot(Dp(nus:1000),a(i3,nus:1000)./sc,'g*')
% plot(Dp(nus:1000),a(i4,nus:1000)./sc,'b*')
% plot(Dp(nus:1000),a(i5,nus:1000)./sc,'k*')
% 
% l1 = sprintf('T = %4.1f',a(i1,1));
% l2 = sprintf('T = %4.1f',a(i2,1));
% l3 = sprintf('T = %4.1f',a(i3,1));
% l4 = sprintf('T = %4.1f',a(i4,1));
% l5 = sprintf('T = %4.1f',a(i5,1));
% 
% legend({l1 l2 l3 l4 l5})
% %set(gca,'xscale', 'log')
% set(gca,'yscale', 'log')
% %set(gca,'ylim',[1 1e4])



% get the nuc rates at different sizes...


dp1 = min(find(Dp>=1e-9))
dp2 = min(find(Dp>=2e-9))
dp3 = min(find(Dp>=3e-9))
dp4 = min(find(Dp>=4e-9))

Ntot = sum(a(:,nus:end),2);
N1 = sum(a(:,dp1:end),2);
N2 = sum(a(:,dp2:end),2);
N3 = sum(a(:,dp3:end),2);
N4 = sum(a(:,dp4:end),2);

dtim = a(2:end,1)-diff(a(:,1))./2;
dNtotdt = diff(Ntot)./diff(a(:,1));
dN1dt = diff(N1)./diff(a(:,1));
dN2dt = diff(N2)./diff(a(:,1));
dN3dt = diff(N3)./diff(a(:,1));
dN4dt = diff(N4)./diff(a(:,1));




figure(1)
hold on
plot(a(:,1),Ntot./sc,['m' sym])
plot(a(:,1),N1./sc,['k' sym])
plot(a(:,1),N2./sc,['b' sym])
plot(a(:,1),N3./sc,['r' sym])
plot(a(:,1),N4./sc,['g' sym])

%legend('Ntot', 'N1', 'N2', 'N3', 'N4')

figure(2)
hold on
plot(dtim,dNtotdt./sc,['m' sym])
plot(dtim,dN1dt./sc,['k' sym])
plot(dtim,dN2dt./sc,['b' sym])
plot(dtim,dN3dt./sc,['r' sym])
plot(dtim,dN4dt./sc,['g' sym])

%legend('dNtot', 'dN1', 'dN2', 'dN3', 'dN4')



return

b = a(:,2:end)./sc;
figure
pcolor(a(:,1),Dp(nus:end),real(log10(b(:,nus:end)')))
set(gca,'yscale','log')
shading flat
set(gca,'ylim',[1e-9 5e-9])
caxis([0 4])


[rr rc] = size(b);
for i = 1:rr,
	[Dpn dN(i,:)] = disc_conv(Dp(nus:end),b(i,nus:end));
end

figure
pcolor(a(:,1),Dpn,real(log10(dN')))
set(gca,'yscale','log')
shading flat
set(gca,'ylim',[1e-9 5e-9])
caxis([0 4])
