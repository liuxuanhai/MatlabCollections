classdef Robot < handle
    % ������������
    properties(Access=private)
        r
    end
    methods
        function r = Robot()
            javaaddpath('RBT.jar');
            r.r=rbt.Rbt();
        end
        function type(r,varargin)
            % ��������ֵΪ�ַ�����
            % ��java.awt.event.KeyEvent�еĳ�����Ϊ׼
            % ���簴�� 'A' ��Ӧjava�е�'VK_A'��ʹ��ʱΪ
            %       r.type('A')
            % ֧��ͬʱ�������������
            %       r.type('CONTROL','A')
            n=length(varargin);
            for i=1:n
                r.r.press(varargin{i});
            end
            for i=1:n
                r.r.release(varargin{i});
            end
        end
        function click(r,p)
            % ���������������Ļ���Ͻ�Ϊԭ�㣬���Ϊx�ᣬ�߶�Ϊy��
            r.r.click(p(1),p(2));
        end
    end
end