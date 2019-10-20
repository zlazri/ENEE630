function ImVec = Huff_decoder2(code, dict, origsz)

codekeys = keys(dict);
minCodeL = min(strlength(codekeys));
maxCodeL = max(strlength(codekeys));
ImVec = [];
while ~isempty(code)
    for i = 0:(maxCodeL - minCodeL)
        if ~any(strcmp(codekeys, code(1:minCodeL+i)))
            continue
        else
            ImVec = [ImVec dict(code(1:minCodeL+i))];
            code = code(minCodeL+i+1:end);
            break
        end
    end
end