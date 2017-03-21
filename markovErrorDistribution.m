close all;
clear all;

p = 0.05;

k = 1:75;
Pr = (1-p).^(k-1)*p;

Fig1 = figure('position', [0 0 400 250]);
a = axes;
stem(k,Pr);
% leg = legend(trellisCodeLabels(1),trellisCodeLabels(2),trellisCodeLabels(3),'location','northwest');
title('Distribution of bursts in Markov channel')
ylabel('Probability')
xlabel('Burst Length')
xlim([0,75])
grid on;

set(findall(Fig1, 'Type', 'Text'),'FontWeight', 'Normal','Interpreter','latex')
set(a,'TickLabelInterpreter', 'tex');
% set(leg,'Interpreter','latex','FontSize',11)
