function b = mrvFileNameExt(f)

% Bastard version of this function since it got kicked out for some reason

[p,n,e] = fileparts(f);
b = [n e];

return