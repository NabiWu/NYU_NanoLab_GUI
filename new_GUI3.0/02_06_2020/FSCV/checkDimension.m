
function [obj] = checkDimension(obj)

% checkDimension.m does three things:
%   1. check if the arrays in an obj are empty
%   2. change arrays into column arrays if they are row arrays; if both
%   dimensions are 1 or both are not 1, print error message
%   3. check if the row numers are the same


if isempty(obj.timeMs) || isempty(obj.subtractedCurr) || isempty(obj.FSCVvolt)
    fprintf("Empty array!! (checkDimension)\n\n")
else
    [obj.timeRow,obj.timeCol] = size(obj.timeMs);
    [obj.subCurrRow,obj.subCurrCol] = size(obj.subtractedCurr);
    [obj.voltRow,obj.voltCol] = size(obj.FSCVvolt);
end

if obj.timeCol ~= 1 && obj.timeRow == 1
    obj.timeMs = obj.timeMs';
    obj.timeRow = obj.timeCol;
    obj.timeCol = 1;
elseif (obj.timeCol == 1 && obj.timeRow == 1) && (obj.timeCol ~= 1 && obj.timeRow ~= 1)
    fprintf('Incorrect time dimension!! (checkDimension)\n\n')
end

if obj.subCurrCol ~= 1 && obj.subCurrRow == 1
    obj.subtractedCurr = obj.subtractedCurr';
    obj.subCurrRow = obj.subCurrCol;
    obj.subCurrCol = 1;
elseif (obj.subCurrCol == 1 && obj.subCurrRow == 1) && (obj.subCurrCol ~= 1 && obj.subCurrRow ~= 1)
    fprintf('Incorrect current dimension!! (checkDimension)\n\n')
end

if obj.voltCol ~= 1 && obj.voltRow == 1
    obj.FSCVvolt = obj.FSCVvolt';
    obj.voltRow = obj.voltCol;
    obj.voltCol = 1;
elseif (obj.voltCol == 1 && obj.voltRow == 1) && (obj.voltCol ~= 1 && obj.voltRow ~= 1)
    fprintf('Incorrect voltage dimension!! (checkDimension)\n\n')
end

if (obj.timeRow ~= obj.subCurrRow) || (obj.subCurrRow ~= obj.voltRow)
    fprintf("Please check timeMs, subtractedCurr, or FSCVvolt length!! (checkDimension)\n\n")
    disp(size(obj.timeMs))
    disp(size(obj.subtractedCurr))
    disp(size(obj.FSCVvolt))
%     disp(size(obj.timeRow))
%     fprintf(obj.timeRow)
%     fprintf('Number of rows of current is '+obj.subCurrRow+'\n\n')
%     fprintf('Number of rows of voltage is '+obj.voltRow+'\n\n')
end


end

