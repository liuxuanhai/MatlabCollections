clc,clear,close all;
% mex ����
mex md5.cpp

% java ����
!javac -d . *.java
!jar cf md.jar ecnu
rmdir ecnu s
javaaddpath md.jar
