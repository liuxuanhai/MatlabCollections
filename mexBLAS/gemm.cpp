#include <mex.h>
#include <blas.h>
// ����ʵ������ĳ˷�
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){// ���ϸ�Ķ���
	// N ��ʾ��ת�ã�T����C��ʾת��
	char t[] = "N";// C++11 ��ֹ���ַ���ת��Ϊָ��
	const mxArray* A = prhs[0];
	const mxArray* B = prhs[1];
	if (mxGetNumberOfDimensions(A) != 2 || mxGetNumberOfDimensions(B) != 2){
		mexErrMsgTxt("input is not maxtrix");
	}
	if (mxIsComplex(A) || mxIsComplex(B)){
		mexErrMsgTxt("do not support complex matrix");
	}
	if (mxGetN(A) != mxGetM(B)){
		mexErrMsgTxt("matrix dimensions do not match");
	}
	// ���� size(A)=[m,k] size(B)=[k,n]
	ptrdiff_t m = mxGetM(A);
	ptrdiff_t k = mxGetN(A);
	ptrdiff_t n = mxGetN(B);
	mxArray* C = plhs[0] = mxCreateDoubleMatrix(m, n, mxREAL);
	double alpha = 1;
	double beta = 0;
	double* mA = mxGetPr(A);
	double* mB = mxGetPr(B);
	double* mC = mxGetPr(C);
	// C=alpha*A*B+beta*C
	dgemm(
		t,// transA
		t,// transB
		&m,// size(A,1)
		&n,// size(B,2)
		&k,// size(A,2)=size(B,1)
		&alpha,
		mA,// A
		&m,// size(A,1)
		mB,// B
		&k,// size(B,1)
		&beta,
		mC,// C
		&m// size(C,1)
	);
}