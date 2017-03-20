clear all;
close all; 

messageLength = 10^6;
maxCER = 0.5;
CERLevels = 20;

%% Simulation
rng(0);
trellisGenerator
CER = (0:CERLevels)/CERLevels*maxCER;

msg = randi([0,1],messageLength,1);
tblen = 1;
BER = zeros(length(trellisList),CERLevels+1,1);

for j=1:length(trellisList)
    code = convenc(msg,trellisList(j));
    codeLength = length(code);
    
    for i=1:CERLevels+1
        errors = zeros(codeLength,1);
        errors(1:int32(CER(i)*codeLength)) = 1;
        errors(randperm(codeLength)) = errors;

        code_ = mod(code+errors,2);
        msg_ = vitdec(code_, trellisList(j), tblen,'trunc','hard');

        BER(j,i) = sum(xor(msg,msg_))/messageLength;
    end
end

%% Create Figure
Fig = figure;
plot(CER,BER,'-x')
leg = legend('$C_{1}(2,1,6)$','$C_{2}(3,1,3)$','$C_{3}(4,1,2)$','location','northwest')
title('Random Errors')
ylabel('BER')
xlabel('CER')

set(findall(Fig, 'Type', 'Text'),'FontWeight', 'Normal')
set(leg,'Interpreter','latex','FontSize',11)