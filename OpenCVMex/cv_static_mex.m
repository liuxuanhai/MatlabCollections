function cv_static_mex(fname,varargin)
% ����Visual Stdio��/MTѡ����о�̬����
libpath='D:\opencv2411\build\x64\vc12\staticlib';
includepath='D:\opencv2411\build\include';
opts=[{['-L',libpath];
    ['-I',includepath];
    'COMPFLAGS="/Zp8 /GR /W3 /EHs /nologo /MT"';};
    cellfun(@(x){sprintf('-l%s',x)},...
    getlib(libpath));];
mex(opts{:},varargin{:},fname);
end