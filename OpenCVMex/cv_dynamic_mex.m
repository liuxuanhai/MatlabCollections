function cv_dynamic_mex(fname,varargin)
% ��̬������ҪPath����OpenCV��dll
libpath='D:\opencv2411\build\x64\vc12\lib';
includepath='D:\opencv2411\build\include';
opts=[{['-L',libpath];
    ['-I',includepath];};
    cellfun(@(x){sprintf('-l%s',x)},...
    getlib(libpath));];
mex(opts{:},varargin{:},fname);
end