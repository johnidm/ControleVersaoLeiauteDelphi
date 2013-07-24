unit UnitRegistrosArquivo;

interface

uses
  Contnrs, Dialogs, SysUtils, Classes,
  UnitRegistro,
  UnitRegistroUtils,
  UnitRegistroR01,
  UnitRegistroR02,
  UnitRegistroR03;

type
  TRegistroArquivo = class
  private
    type
      TOrdenacao = (tordNenhuma, tordVersao01);
      TVersaoLayout = (ver0101 = 0, ver0102 = 1, ver0103 = 2, ver0104 = 3,
        ver0105 = 4);
  private
    oListaRegistroArquivo: TObjectList;

    oVersaoR01: IVersaoR01;
    oVersaoR02: IVersaoR02;
    oVersaoR03: IVersaoR03;

    FNomeArquivo: string;
    FOrdenacao: TOrdenacao;
    FVersaoLayout: TVersaoLayout;
  public
    property VersaoLayout: TVersaoLayout read FVersaoLayout write FVersaoLayout;

    property NomeArquivo: string read FNomeArquivo write FNomeArquivo;
    property Ordenacao: TOrdenacao read FOrdenacao write FOrdenacao;

    procedure AdicionarRegistro(const ARegistro: TRegistro);
    procedure DefineVersao(const AVersaoR01: IVersaoR01; const AVersaoR02: IVersaoR02); overload;

    procedure DefineVersao(const AVersaoR01: IVersaoR01; const AVersaoR02: IVersaoR02;
      const AVersaoR03: IVersaoR03); overload;

    procedure GerarArquivo;

    constructor Create(const AVersaoLayout: Integer); overload;

    destructor Destroy; override;
  end;


implementation

{ TRegistroArquivo }

procedure TRegistroArquivo.AdicionarRegistro(const ARegistro: TRegistro);
begin
  oListaRegistroArquivo.Add(ARegistro);
end;

procedure TRegistroArquivo.DefineVersao(const AVersaoR01: IVersaoR01;
  const AVersaoR02: IVersaoR02);
begin

  oVersaoR01:= AVersaoR01;
  oVersaoR02:= AVersaoR02;
end;



constructor TRegistroArquivo.Create(const AVersaoLayout: Integer);
begin
 oListaRegistroArquivo:= TObjectList.Create(True);
 oListaRegistroArquivo.Clear;

 FOrdenacao:= tordNenhuma;
 FVersaoLayout:= TVersaoLayout(AVersaoLayout);

 //if (not(FNomeArquivo in [TVersãoLayout] )) then
 //  raise Exception.Create('Versão do layout não definida');
end;

procedure TRegistroArquivo.DefineVersao(const AVersaoR01: IVersaoR01;
  const AVersaoR02: IVersaoR02; const AVersaoR03: IVersaoR03);
begin

  oVersaoR01:= AVersaoR01;
  oVersaoR02:= AVersaoR02;
  oVersaoR03:= AVersaoR03;
end;

destructor TRegistroArquivo.Destroy;
begin
  if (Assigned(oListaRegistroArquivo)) then
    FreeAndNil(oListaRegistroArquivo);

  inherited;
end;

procedure TRegistroArquivo.GerarArquivo;
var
  oStringList: TStringList;
  iIndice: Integer;
  oRegistro: TRegistro;
begin
  if (VersaoLayout in [ver0101, ver0102, ver0103, ver0104, ver0105]) then
  begin
    if (not(Assigned(oVersaoR01))) then
      raise Exception.CreateFmt(RSVersaoRegistroNaoDefinida, ['R01']);

    if (not(Assigned(oVersaoR02))) then
      raise Exception.CreateFmt(RSVersaoRegistroNaoDefinida, ['R02']);
  end;

  if (VersaoLayout in [ver0105]) then
  begin
    if (not(Assigned(oVersaoR03))) then
      raise Exception.CreateFmt(RSVersaoRegistroNaoDefinida, ['R03']);
  end;
 
  oStringList:= TStringList.Create;
  try
    for iIndice:= 0 to Pred(oListaRegistroArquivo.Count) do
    begin
      oRegistro:= oListaRegistroArquivo[iIndice] as TRegistro;

      if (oRegistro is TRegistroR01) and (Assigned(oVersaoR01)) then
        oStringList.Add(oVersaoR01.RetornarLinha( TRegistroR01(oRegistro) ))
      else if (oRegistro is TRegistroR02) and (Assigned(oVersaoR02)) then
        oStringList.Add(oVersaoR02.RetornarLinha( TRegistroR02(oRegistro) ))
      else if (oRegistro is TRegistroR03) and (Assigned(oVersaoR03)) then
        oStringList.Add(oVersaoR03.RetornarLinha( TRegistroR03(oRegistro) ))

    end;
    oStringList.SaveToFile(FNomeArquivo);
  finally
    FreeAndNil(oStringList);
  end;
end;

end.
