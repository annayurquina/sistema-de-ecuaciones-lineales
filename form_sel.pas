unit Form_SEL;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Grids, ExtDlgs;

type

  { TFormCargaMatris }
  Cadena=String[30];
  tVector=array[1..100] of Integer;

  TFormCargaMatris = class(TForm)
    btnIncongnitas: TButton;
    btnOK: TButton;
    btnCargaEc: TButton;
    btnBorrar: TButton;
    cmbTipoMtx: TComboBox;
    edCantIncongnitas: TEdit;
    edCoeficiente: TEdit;
    Label1: TLabel;
    lbX: TLabel;
    lbEcuacion: TLabel;
    lbCoeficientes: TLabel;
    lbTitulo: TLabel;
    lbCantIncognitas: TLabel;
    pnlTitulo: TPanel;
    strGridMatris: TStringGrid;
    procedure btnBorrarClick(Sender: TObject);
    procedure btnCargaEcClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnIncongnitasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    //procedure ModificaEcuacion(cantClick:integer;strCoef:cadena);//no se porqué no va aqui
  public

  end;

var
  FormCargaMatris: TFormCargaMatris;
  V:tVector;
  N:integer;
  clickCoef:integer;


implementation

{$R *.lfm}


{ TFormCargaMatris }

{procedure creaStrGrid();
var

begin

end; }


procedure TFormCargaMatris.btnIncongnitasClick(Sender: TObject);
var
   cant:integer;
   strCant:cadena;
   codCant:integer;
begin
  strCant:=FormCargaMatris.edCantIncongnitas.Text;

  if (strCant<>'') then
    begin
      val(strCant,cant,codCant);
      if (codCant=0) and (cant>0) then
        begin
          FormCargaMatris.edCantIncongnitas.Enabled:=False;
          N:=cant;
          FormCargaMatris.edCoeficiente.Enabled:=True;
          FormCargaMatris.btnOK.Enabled:=True;
        end
      else
        begin
          ShowMessage('La valor no válido');
          FormCargaMatris.edCantIncongnitas.Text:='';
        end;
    end
  else
    begin
      ShowMessage('Debe ingresar cantidad de variables');
    end;

end;

procedure ActualizaX(cantClick:integer);
begin
  if(cantClick<N)then
  begin
    FormCargaMatris.lbX.Caption:='x'+IntToStr(cantClick+1);
  end;
end;

procedure ModificaEcuacion(cantClick:integer;strCoef:cadena);
var
  coef:integer;// vble aux para saber arreglar el tema de signos en la ecuacion
begin
  coef:=strtoInt(strCoef);
  if(cantClick=1) then//si es el primer coeficiente se muestra distinto en el termino aX1
  begin
    if(coef<0) then//si el coeficiente es negativo se le agrega paréntesis
    begin
      FormCargaMatris.lbEcuacion.Caption:='('+strCoef+')'+' x'+IntToStr(cantClick);
    end
    else//si es positivo se muestra igual
    begin
      FormCargaMatris.lbEcuacion.Caption:=strCoef+' x'+IntToStr(cantClick);
    end;
  end
  else//si no es el primer coeficiente
  begin
    if(coef<0)then//si es negativo, se aplica regla de signos + * - = -
    begin
      FormCargaMatris.lbEcuacion.Caption:=FormCargaMatris.lbEcuacion.Caption+' '+strCoef+' x'+IntToStr(clickCoef);
    end
    else
    begin//si es positivo, solo se modifica el indice de X
      FormCargaMatris.lbEcuacion.Caption:=FormCargaMatris.lbEcuacion.Caption+' +'+strCoef+' x'+IntToStr(clickCoef);
    end;
  end;
end;

procedure HabilitaCoeficientes(cantClick:integer);
begin
  if(cantClick=N) then
  begin
    FormCargaMatris.btnOK.Enabled:=False;
    FormCargaMatris.edCoeficiente.Enabled:=False;
  end;
end;

procedure TFormCargaMatris.btnOKClick(Sender: TObject);
var
  coef:integer;
  strCoef:cadena;
  codCoef:integer;

begin
  strCoef:=FormCargaMatris.edCoeficiente.Text;
  if(strCoef<>'') and (clickCoef<N) then
    begin
      val(strCoef,coef,codCoef);
      if(codCoef=0) then
        begin
          clickCoef:=clickCoef+1;
          V[clickCoef-1]:=coef;
          ActualizaX(clickCoef); //el X que acompaña al EditText
          ModificaEcuacion(clickCoef, strCoef);
          HabilitaCoeficientes(clickCoef); 
          FormCargaMatris.edCoeficiente.Caption:='';
        end
      else
        begin
          ShowMessage('Ingrese valores numéricos');
          FormCargaMatris.edCoeficiente.Caption:='';
        end;
    end
  else
    begin
      ShowMessage('No puede agregar más coeficiente');
      FormCargaMatris.edCoeficiente.Enabled:=False;
    end;
end;

procedure cargaUnaEcuacion(var V:tVector;var N:integer; valor:integer);
var
  i:integer;
begin

end;

procedure TFormCargaMatris.btnCargaEcClick(Sender: TObject);
var
   i:integer;
   coeficientes:cadena;
begin
  FormCargaMatris.strGridMatris.RowCount:=FormCargaMatris.strGridMatris.RowCount+1;
  i:=FormCargaMatris.strGridMatris.RowCount;
  coeficientes:='';
  for i:=0 to N-1 do
  begin
    coeficientes:=coeficientes+','+intToStr(V[i]);
  end;
  ShowMessage('Cargando: '+coeficientes);
end;

procedure TFormCargaMatris.btnBorrarClick(Sender: TObject);
begin
  FormCargaMatris.edCoeficiente.Enabled:=True;
  FormCargaMatris.btnOK.Enabled:=True;
  FormCargaMatris.edCoeficiente.Caption:='';
  FormCargaMatris.lbEcuacion.Caption:='';
  FormCargaMatris.lbX.Caption:='x1';
  clickCoef:=0;

end;

procedure TFormCargaMatris.FormShow(Sender: TObject);
begin
  N:=0;
  clickCoef:=0;
  edCoeficiente.Enabled:=False;
  btnOK.Enabled:=False;
  edCantIncognitas.Enabled:=False;
  btnIncognitas.Enabled:=False;
end;



end.

