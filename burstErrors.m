clear all;
close all; 

messageLength = 10^6;
BurstLevels = 50;
nBursts = 50;
burstSep = 1000;

%% Simulation
rng(0);
trellisGenerator

msg = randi([0,1],messageLength,1);
tblen = 1;
BE = zeros(length(trellisList),BurstLevels,1);

for j=1:length(trellisList)
    code = convenc(msg,trellisList(j));
    codeLength = length(code);
    
    for i=1:BurstLevels
        burstLength=i-1;
        errors = zeros(codeLength,1);
        for n = 0:nBursts-1
            errors(1+(n*burstSep):(n*burstSep) + burstLength) = 1;
        end 
        code_ = mod(code+errors,2);
        msg_ = vitdec(code_, trellisList(j), tblen,'trunc','hard');

        BE(j,i) = sum(xor(msg,msg_))/nBursts;
    end
end

%% Create Figure
Fig = figure;
plot(0:BurstLevels-1,BE,'-x')
leg = legend('$C_{1}(2,1,6)$','$C_{2}(3,1,3)$','$C_{3}(4,1,2)$','location','northwest');
title('Random Errors')
ylabel('Bit Errors per Burst')
xlabel('Burst Length')

set(findall(Fig, 'Type', 'Text'),'FontWeight', 'Normal')
set(leg,'Interpreter','latex','FontSize',11)