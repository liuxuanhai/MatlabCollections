clc,clear,close all;
% �ٷ��ĵ��Ƽ���������� blas ������ѡ�� -largeArrayDims
% mex -llibmwblas.lib -output gemm gemm.cpp
mex  -largeArrayDims  -llibmwblas.lib -output gemm gemm.cpp
A=rand(3,500);
B=rand(500,3);
disp(gemm(A,B)-A*B)