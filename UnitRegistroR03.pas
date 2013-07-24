unit UnitRegistroR03;

interface

uses
  UnitRegistro,
  UnitRegistroUtils;

type
  TRegistroR03 = class(TRegistro)
  private
    FTotalizadorParcial: string;
    FCRZ: Integer;
    FValorAcumulado: Currency;
    function GetTipo: string;
  public
    property Tipo: string read GetTipo;
    property CRZ: Integer read FCRZ write FCRZ;
    property TotalizadorParcial: string read FTotalizadorParcial
      write FTotalizadorParcial;
    property ValorAcumulado: Currency read FValorAcumulado
      write FValorAcumulado;
  end;


  IVersaoR03 = interface
    ['{804D59C4-BD7A-449E-82DF-DD1E2B982B06}']
    function RetornarLinha(const ARegistro: TRegistroR03): string;
  end;


  // Registro incluído a partir da versão 01.05
  TVersaoR03_0105 = class(TInterfacedObject, IVersaoR03)
    function RetornarLinha(const ARegistro: TRegistroR03): string; virtual;
  end;


implementation


{ TRegistroR03 }

function TRegistroR03.GetTipo: string;
begin
  Result:= 'R03'
end;

{ TVersaoR03_0105 }

function TVersaoR03_0105.RetornarLinha(const ARegistro: TRegistroR03): string;
begin
  Result:=
    Formatar( ARegistro.Tipo   , 3) +
    Formatar( ARegistro.CRZ    , 6) +
    Formatar( ARegistro.TotalizadorParcial,  7   ) +
    Formatar( ARegistro.ValorAcumulado    , 14, 2);
end;

end.
