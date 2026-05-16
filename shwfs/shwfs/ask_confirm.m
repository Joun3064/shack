function ask_confirm(s)
str = input(sprintf('USER INPUT: %s [yn] ', s), 's');
if ~strcmp(str, 'y')
    throw(MException('VerifyOutput:IllegalInput', 'Stop'));
end
end


