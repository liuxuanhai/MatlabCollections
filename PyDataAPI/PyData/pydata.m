classdef pydata
    % Matlab �� NumPy ����ת���Ľӿ�
    methods(Static)
        function y = toPy(x,dtype)
            % �� Matlab ����ת��Ϊ NumPy ����
            if nargin<2
                dtype='double';
            end
            y = py.PyData.DataParser.mx2py(mat2py(x),dtype);
        end
        function y = fromPy(x)
            % �� NumPy ����ת��Ϊ Matlab ����
            y = py2mat(py.PyData.DataParser.mxArray(x));
        end
        function savePy(x,fname,dtype)
            % �� Matlab ����ת��Ϊ NumPy ����
            if nargin<3
                dtype='double';
            end
            py.numpy.save(fname,pydata.toPy(x,dtype));
        end
        function x = loadPy(fname)
            % �� Numpy ��ʽ�������ݶ�ȡΪ MATLAB ����
            x = pydata.fromPy(py.numpy.load(fname));
        end
        function y = imgsToPy(x)
            % �� MATLAB �� ͼƬ cell ת��Ϊ BatchSize*M*N*3 �ĸ�ʽ
            % ����������ʲô������Ķ��� uint8 ��ʽ��
            % �Զ�ɾ���� cell 
            x=x(:);
            x(cellfun(@isempty,x))=[];
            x=cellfun(@(t){reshape(im2uint8(t),[1,size(t)])},x);
            y=cat(1,x{:});
        end
    end
end
function z = mat2py(x)
% �� MATLAB ����ת��Ϊһ���ṹ��
z.data=x(:)';
z.shape=size(x);
end
function y = py2mat(x)
% �� Python �е�  mxArray ����ת��Ϊ MATLAB ����
sz=cellfun(@double,cell(x.shape));
y=cellfun(@double,cell(x.data));
y=reshape(y,sz);
end