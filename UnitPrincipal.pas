unit UnitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  UnitRegistrosArquivo,
  UnitRegistroR01,
  UnitRegistroR02,
  UnitRegistroR03;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
const
  ARQUIVO = 'd:\teste.txt';
var
  oRegistroArquivo: TRegistroArquivo;

  iContador: Integer;

  oRegistroR01: TRegistroR01;
  oRegistroR02: TRegistroR02;
  oRegistroR03: TRegistroR03;
begin
  oRegistroArquivo:= TRegistroArquivo.Create( ComboBox1.ItemIndex );
  try
    oRegistroArquivo.NomeArquivo:= ARQUIVO;

    oRegistroR01:= TRegistroR01.Create;
    with oRegistroR01 do
    begin
      NumeroFabricacaoECF:= 'EP1243JHFDS234234DBR';
      MarcaECF:= 'EPSON';
      ModeloECF:= 'TM 81 III';
      TipoECF:= 'ECF-IF'
    end;
    oRegistroArquivo.AdicionarRegistro(oRegistroR01);

    for iContador:= 1 to 2 do
    begin
      oRegistroR02:= TRegistroR02.Create;
      with oRegistroR02 do
      begin
        NumeroFabricacaoECF:= 'EP1243JHFDS234234DBR';
        UsuarioECF:= 1;
        CRZ:= 3   * Random(10);
        COO:= 344 * Random(10);
        CRO:= 12  * Random(10);

        oRegistroArquivo.AdicionarRegistro(oRegistroR02);
      end;
    end;

    if (oRegistroArquivo.VersaoLayout = ver0105) then
    begin
      oRegistroR03:= TRegistroR03.Create;
      with oRegistroR03 do
      begin
        CRZ:= 12;
        TotalizadorParcial:= 'T012500';
        ValorAcumulado:= 1234.566
      end;
      oRegistroArquivo.AdicionarRegistro(oRegistroR03);
    end;


    case oRegistroArquivo.VersaoLayout of
      ver0101: oRegistroArquivo.DefineVersao( TVersaoR01_0101.Create, TVersaoR02_0101.Create );
      ver0102: oRegistroArquivo.DefineVersao( TVersaoR01_0101.Create, TVersaoR02_0102.Create );
      ver0103: oRegistroArquivo.DefineVersao( TVersaoR01_0101.Create, TVersaoR02_0103.Create );
      ver0104: oRegistroArquivo.DefineVersao( TVersaoR01_0104.Create, TVersaoR02_0104.Create );
      ver0105: oRegistroArquivo.DefineVersao( TVersaoR01_0104.Create, TVersaoR02_0104.Create,
           TVersaoR03_0105.Create  );
    end;

    oRegistroArquivo.GerarArquivo;

  finally
    if (Assigned(oRegistroArquivo)) then
      FreeAndNil(oRegistroArquivo)

  end;

  Memo1.Clear;
  Memo1.Lines.LoadFromFile(ARQUIVO);

end;

end.
