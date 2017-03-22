clear all;
close all; 

messageLength = 10^6;

burstProbabilityMax = 0.005;
burstProbabilityLevels = 20;

p10 = 0.05;
eps1 = 0.0;
eps2 = 0.0;

simulationRuns = 2; %How many different messages are sent in the simulation.
%% Simulation
rng(0); % seed.
trellisGenerator
p12 = (0:burstProbabilityLevels)/burstProbabilityLevels*burstProbabilityMax; % Splitting the error rates levels.
BER = zeros(length(trellisList),burstProbabilityLevels+1,1); %Bit error rate - 0 in the beggining
CER = zeros(length(trellisList),burstProbabilityLevels+1,1); %Channel error rate - 0 in the beggining

for k=1:simulationRuns
    disp(sprintf('----- Simulation %i of %i -----', k,simulationRuns))
    msg = randi([0,1],messageLength,1); %generate random message of the given message length.

    for j=1:length(trellisList)
        tblen = 5*(log2(trellisList(j).numStates)+1); %Traceback length for vitdec
        code = convenc(msg,trellisList(j)); %Encoding using convolutional code
        codeLength = length(code);

        for i=1:burstProbabilityLevels+1 %go through all the error rates. Simulating the generated message with different error rates.
            
            %Simulates the channel
            errors = markovErrorGenerator(codeLength,p12(i),p10,eps1,eps2);
            CER(j,i) = CER(j,i) + sum(errors)/codeLength;
            
            code_ = mod(code+errors,2); %Received code
            msg_ = vitdec(code_, trellisList(j), tblen,'trunc','hard'); %decode the received message

            BER(j,i) = BER(j,i) + sum(xor(msg,msg_))/messageLength; %Bit error rate. Comparing the sent message and decoded.
        end
    end
end
BER = BER ./ simulationRuns; %Get the average error rate if we have more simulations runs.
CER = mean(CER) ./ simulationRuns; %Get the average error rate if we have more simulations runs.
%% Create Figure
% Fig0 = figure;
% plot(errors)

Fig1 = figure('position', [0 0 400 300]);
a = axes;
semilogy(p12,BER,'-x')
leg = legend(trellisCodeLabels(1),trellisCodeLabels(2),trellisCodeLabels(3),'location','northwest');
title('Decoding after Markov channel')
ylabel('BER')
xlabel('Burst probability')
grid on;

set(findall(Fig1, 'Type', 'Text'),'FontWeight', 'Normal','Interpreter','latex')
set(a,'TickLabelInterpreter', 'tex');
set(leg,'Interpreter','latex','FontSize',11)

print('markovErrors','-dpdf')

Fig2 = figure('position', [0 0 400 300]);
a = axes;
semilogy(CER,BER,'-x')
leg = legend(trellisCodeLabels(1),trellisCodeLabels(2),trellisCodeLabels(3),'location','northwest');
title('Decoding after Markov channel')
ylabel('BER')
xlabel('CER')
grid on;

set(findall(Fig2, 'Type', 'Text'),'FontWeight', 'Normal','Interpreter','latex')
set(a,'TickLabelInterpreter', 'tex');
set(leg,'Interpreter','latex','FontSize',11)

print('markovErrors','-dpdf')

system ('/usr/bin/pdfcrop markovErrors.pdf'); 
system('rm markovErrors.pdf');