% Transform symmetric matrix to triangular matrix and collect coefficients
% of all subjects

%% initialize

inCoefsCollect = [];
intCoefsCollect = [];

%%

inCoefTriMat = triu(corrcoefMatInput);
inCoefIdxs = find(inCoefTriMat~=0 & inCoefTriMat~=1);
inCoefs = inCoefTriMat(inCoefIdxs)';

intCoefTriMat = triu(corrcoefMatIntWMs);
intCoefIdxs = find(intCoefTriMat~=0 & intCoefTriMat~=1);
intCoefs = intCoefTriMat(intCoefIdxs)';

inCoefsCollect = [inCoefsCollect;inCoefs];
intCoefsCollect = [intCoefsCollect;intCoefs];