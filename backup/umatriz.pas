unit uMatriz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
Const
  max=100;
type
  tMatriz=array[0..max,0..max] of integer;
  tFraccion=string[51];

var
  mTam:integer;
  mtx:tMatriz;

function determinante():real;



implementation

function determinante2x2():real;
begin
  determinante2x2:=mtx[0][0]*mtx[1][1]-mtx[0][1]*mtx[1][0];
end;

function determinante():real;
begin
  determinante:=0;
  if(mTam=2)then
  begin
    determinante:=determinante2x2();
  end
  else
  begin
    sd
  end;
end;

{function laplace():real;
var
begin

end;}
end.

