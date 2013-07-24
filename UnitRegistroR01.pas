unit UnitRegistroR01;

interface

uses
  UnitRegistro,
  UnitRegistroUtils;

type
  TRegistroR01 = class(TRegistro)
  private
    FNumeroFabricacaoECF: string;
    FMFAdicional: string;
    FMarcaECF: string;
    FTipoECF: string;
    FModeloECF: string;
    FVersaoSB: string;
    function GetTipo: string;
  public
    property Tipo: string read GetTipo;
    property NumeroFabricacaoECF: string read FNumeroFabricacaoECF
      write FNumeroFabricacaoECF;
    property MarcaECF: string read FMarcaECF write FMarcaECF;
    property ModeloECF: string read FModeloECF write FModeloECF;
    property TipoECF: string read FTipoECF write FTipoECF;
  end;

  IVersaoR01 = interface
    ['{E63C7C9E-9D82-4143-8642-4C97E89C9872}']
    function RetornarLinha(const ARegistro: TRegistroR01): string;
  end;

  TVersaoR01_0101 = class(TInterfacedObject, IVersaoR01)
    function RetornarLinha(const ARegistro: TRegistroR01): string; virtual;
  end;

  // Removido os campos NumeroFabricacaoECF e ModeloECF
  TVersaoR01_0104 = class(TVersaoR01_0101)
    function RetornarLinha(const ARegistro: TRegistroR01): string; override;
  end;

implementation


{ TRegistroR01 }

function TRegistroR01.GetTipo: string;
begin
  Result:= 'R01';
end;

{ TVersao0101 }

function TVersaoR01_0101.RetornarLinha(const ARegistro: TRegistroR01): string;
begin
  Result:=
    Formatar( ARegistro.Tipo, 3) +
    Formatar( ARegistro.NumeroFabricacaoECF, 20) +
    Formatar( ARegistro.MarcaECF  , 20) +
    Formatar( ARegistro.ModeloECF , 20);
end;

{ TVersaoR01_0104 }

function TVersaoR01_0104.RetornarLinha(const ARegistro: TRegistroR01): string;
begin
  Result:= inherited RetornarLinha(ARegistro) +
    Formatar( ARegistro.TipoECF, 7);
end;

end.

