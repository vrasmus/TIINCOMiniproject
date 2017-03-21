clear all;
close all; 

messageLength = 10^6;
maxCER = 0.1;
CERLevels = 20;
simulationRuns = 25;
%% Simulation
rng(0);
trellisGenerator
CER = (0:CERLevels)/CERLevels*maxCER;
BER = zeros(length(trellisList),CERLevels+1,1);

for k=1:simulationRuns
    disp(sprintf('----- Simulation %i of %i -----', k,simulationRuns))
    msg = randi([0,1],messageLength,1);
    % tblen = 1;

    for j=1:length(trellisList)
        tblen = 5*(log2(trellisList(j).numStates)+1); %Traceback length for vitdec
        code = convenc(msg,trellisList(j));
        codeLength = length(code);

        for i=1:CERLevels+1
            errors = zeros(codeLength,1);
            errors(1:int32(CER(i)*codeLength)) = 1;
            errors(randperm(codeLength)) = errors;

            code_ = mod(code+errors,2);
            msg_ = vitdec(code_, trellisList(j), tblen,'trunc','hard');

            BER(j,i) = BER(j,i) + sum(xor(msg,msg_))/messageLength;
        end
    end
end
BER = BER ./ simulationRuns;
%% Create Figure
% Fig0 = figure;
% plot(errors)

Fig1 = figure('position', [0 0 400 300]);
a = axes;
semilogy(CER,BER,'-x')
leg = legend(trellisCodeLabels(1),trellisCodeLabels(2),trellisCodeLabels(3),'location','northwest');
title('Decoding after BSC')
ylabel('BER')
xlabel('CER')
grid on;

set(findall(Fig1, 'Type', 'Text'),'FontWeight', 'Normal','Interpreter','latex')
set(a,'TickLabelInterpreter', 'tex');
set(leg,'Interpreter','latex','FontSize',11)

print('randomErrors','-dpdf')
system ('/usr/bin/pdfcrop randomErrors.pdf'); 
system('rm randomErrors.pdf');