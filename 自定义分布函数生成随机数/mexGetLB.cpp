/*
function lb = getLB(ind,m,n)
�ҵ�С�����ݵ�����һ���ָ����±�
ind ��С���������ָ������
m	�ָ���ĸ���
n	���ݵ�ĸ���
*/
#include<mex.h>
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	int m = mxGetScalar(prhs[1]);
	int n = mxGetScalar(prhs[2]);
	double* ind = mxGetPr(prhs[0]);
	mxArray* mxLB = mxCreateDoubleMatrix(1, n, mxREAL);
	double* lb = mxGetPr(mxLB);
	double cind = 0;
	for (int k = 0; k < n + m; k++){
		if (ind[k] <= m){
			cind = ind[k];
		}
		else{
			lb[(int)ind[k] - m - 1] = cind;
		}
	}
	plhs[0] = mxLB;
}