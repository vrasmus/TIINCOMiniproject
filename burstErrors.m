clear all;
close all; 

simulationRuns = 1;

messageLength = 10^6;
BurstLevels = 50; %50 burst lenghts. ex: 1 bit, 2 bits, 3 consecutive bits.
nBursts = 400; %How many bursts of that lenghts we are in the message.
burstSep = 5000; %separation between bursts.

%% Simulation
rng(0);
trellisGenerator

BE = zeros(length(trellisList),BurstLevels,1);
for k=1:simulationRuns
    disp(sprintf('----- Simulation %i of %i -----', k,simulationRuns))
    msg = randi([0,1],messageLength,1);
    for j=1:length(trellisList)
        tblen = 10*(log2(trellisList(j).numStates)+1); %Traceback length for vitdec
        code = convenc(msg,trellisList(j));
        codeLength = length(code);

        for i=1:BurstLevels % start with no bursts and increase.
            burstLength=i-1;
            errors = zeros(codeLength,1);
            for n = 0:nBursts-1
                errors(1+(n*burstSep):(n*burstSep) + burstLength) = 1; % Separate each burst by using the separator
            end 
            code_ = mod(code+errors,2);
            msg_ = vitdec(code_, trellisList(j), tblen,'trunc','hard');

            BE(j,i) = BE(j,i) + sum(xor(msg,msg_))/nBursts; %calculate how many errors (bits) were received in error
        end
    end
end
BE = BE ./ simulationRuns;

%% Create Figure
% Fig0 = figure;
% plot(errors)

Fig1 = figure('position', [0 0 400 250]);
a = axes;
plot(0:BurstLevels-1,BE,'-x')
leg = legend(trellisCodeLabels(1),trellisCodeLabels(2),trellisCodeLabels(3),'location','northwest');
title('Decoding after Burst Errors')
ylabel('Bit Errors per Burst')
xlabel('Burst Length')
grid on; 

set(findall(Fig1, 'Type', 'Text'),'FontWeight', 'Normal','Interpreter','latex')
set(a,'TickLabelInterpreter', 'tex');
set(leg,'Interpreter','latex','FontSize',11)


print('burstErrors','-dpdf')
system ('/usr/bin/pdfcrop burstErrors.pdf'); 
system('rm burstErrors.pdf');