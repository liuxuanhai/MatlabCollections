clc,clear,close all;
% �ٷ��ĵ��Ƽ���������� blas ������ѡ�� -largeArrayDims
if isunix
    mex -largeArrayDims -lmwblas gemm.cpp
else
    mex -largeArrayDims -llibmwblas.lib gemm.cpp
end
A=rand(3,500);
B=rand(500,3);
disp(gemm(A,B)-A*B)