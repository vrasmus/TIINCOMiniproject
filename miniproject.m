constraintLength = 3;
% trellis = poly2trellis(constraintLength,{'1 + x^2', '1 + x + x^2'});
% spect = distspec(trellis)

trellisGenerator

trellis = trellisList(1)

rng(0);
messageLength = 100;
tblen = 1;
CER = 0.04 %Channel Error Rate


msg = randi([0,1],messageLength,1);
code = convenc(msg,trellis);

codeLength = length(code);
errors = zeros(codeLength,1);
errors(1:CER*codeLength) = 1;
errors(randperm(codeLength)) = errors;

code_ = mod(code+errors,2)
msg_ = vitdec(code_, trellis, tblen,'trunc','hard');

BER = sum(xor(msg,msg_))/messageLength