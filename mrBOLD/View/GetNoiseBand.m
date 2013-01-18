function noiseBand = GetNoiseBand(view, scan)
%
% noiseBand = GetNoiseBand(view, scan)
%
% Gets the noise band, the frequency-domain indices of that
%
% Ress, 8/30/02
global dataTYPES;
if ~exist('scan', 'var')
    if isfield(view, 'ui')
        scan = getCurScan(view);
    else
        scan = 1;
    end
end
if isfield(dataTYPES(view.curDataType).blockedAnalysisParams(scan), 'noiseBand')

