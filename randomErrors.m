clear all;
close all; 

messageLength = 10^6;
maxCER = 0.1; %Max channel error rate
CERLevels = 20; %Number of levels to put on the figure. In this case, between 0 and 0.1 - range split in 20 parts.
simulationRuns = 1; %How many different messages are sent in the simulation.
%% Simulation
rng(0); % seed.
trellisGenerator
CER = (0:CERLevels)/CERLevels*maxCER; % Splitting the error rates levels.
BER = zeros(length(trellisList),CERLevels+1,1); %Bit error rate - 0 in the beggining

for k=1:simulationRuns
    disp(sprintf('----- Simulation %i of %i -----', k,simulationRuns))
    msg = randi([0,1],messageLength,1); %generate random message of the given message length.
    % tblen = 1;

    for j=1:length(trellisList)
        tblen = 5*(log2(trellisList(j).numStates)+1); %Traceback length for vitdec
        code = convenc(msg,trellisList(j)); %Encoding using convolutional code
        codeLength = length(code);

        for i=1:CERLevels+1 %go through all the error rates. Simulating the generated message with different error rates.
            
            %Simulates the channel
            errors = zeros(codeLength,1);
            errors(1:int32(CER(i)*codeLength)) = 1;
            errors(randperm(codeLength)) = errors;

            code_ = mod(code+errors,2); %Received code
            msg_ = vitdec(code_, trellisList(j), tblen,'trunc','hard'); %decode the received message

            BER(j,i) = BER(j,i) + sum(xor(msg,msg_))/messageLength; %Bit error rate. Comparing the sent message and decoded.
        end
    end
end
BER = BER ./ simulationRuns; %Get the average error rate when there are more simulations runs.
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
% system ('/usr/bin/pdfcrop randomErrors.pdf'); 
% system('rm randomErrors.pdf');