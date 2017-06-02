function [X, map, alpha] = myImread(varargin)
% ��MatlabͼƬ��ȡ�Ļ����ϣ�������Ƭ��EXIF��Orientation���ԣ�����Ƭ������ת
% 1 ����ת
% 6 ˳ʱ��90��
% 8 ��ʱ��90��
% 3 180��
% 2 ˮƽ��ת
% 4 ��ֱ��ת
% 5 ˳ʱ��90��+ˮƽ��ת
% 7 ˳ʱ��90��+��ֱ��ת
% ��Ϊ��Щ�����Ǹ�����ʾ��Ӧ�������ʾ��Ƭ
% ��˰�������˵���ķ�����ת����
% �����Ƿ�������ת��Ƭ
% ����ο���http://blog.csdn.net/ouyangtianhan/article/details/29825885
[X,map,alpha]=imread(varargin{:});
info=imfinfo(varargin{1});
if isfield(info,'Orientation')
    switch info.Orientation
        case 1
        case 6
            X=imrotate(X,-90);
        case 8
            X=imrotate(X,90);
        case 3
            X=imrotate(X,180);
        case 2
            X=flip(X,2);
        case 4
            X=flip(X,1);
        case 5
            X=imrotate(X,-90);
            X=flip(X,2);
        case 7
            X=imrotate(X,-90);
            X=flip(X,1);
    end
    if ~isempty(alpha)
        switch info.Orientation
            case 1
            case 6
                alpha=imrotate(alpha,-90);
            case 8
                alpha=imrotate(alpha,90);
            case 3
                alpha=imrotate(alpha,180);
            case 2
                alpha=flip(alpha,2);
            case 4
                alpha=flip(alpha,1);
            case 5
                alpha=imrotate(alpha,-90);
                alpha=flip(alpha,2);
            case 7
                alpha=imrotate(alpha,-90);
                alpha=flip(alpha,1);
        end
    end
end
