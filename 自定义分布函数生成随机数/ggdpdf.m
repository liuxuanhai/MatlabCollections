function y = ggdpdf(x,b,s)
% 0��ֵ����Ϊs�Ĺ����˹�ֲ���ʵ�������pdf
a=sqrt(gamma(1/b)/gamma(3/b)*s);
y=b/(2*a*gamma(1/b))*exp(-(abs(x)/a).^b);
end