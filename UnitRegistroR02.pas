unit UnitRegistroR02;

interface

uses
  SysUtils,
  UnitRegistro,
  UnitRegistroUtils;

type
  TRegistroR02 = class(TRegistro)
  private
    FMFAdicional: string;
    FNumeroFabricacaoECF: string;
    FModeloECF: string;
    FCOO: Integer;
    FNumeroUsuarioECF: Integer;
    FCRO: Integer;
    FCRZ: Integer;
    FDataEmissao: TDate;
    FHoraEmissao: TTime;
    FDataMovimento: TDate;
    function GetTipo: string;
  public
    property Tipo: string read GetTipo;
    property NumeroFabricacaoECF: string read FNumeroFabricacaoECF write FNumeroFabricacaoECF;
    property UsuarioECF: Integer read FNumeroUsuarioECF write FNumeroUsuarioECF;
    property CRZ: Integer read FCRZ write FCRZ;

    // Campo incluído no arquivo a partir da versão 01.02
    // Incluído no final do arquivo
    property COO: Integer read FCOO write FCOO;

    // Campos incluído no arquivo partir da versão 01.03
    // Incluído no meio do arquivo
    property CRO: Integer read FCRO write FCRO;

    // Campos incluídos a partir da versao 01.04
    // A partir da versão 01.04 foi redefinido a estrutura de campos do
    // regsitro no arquivo.
    property DataMovimento: TDate read FDataMovimento write FDataMovimento;
    property DataEmissao: TDate read FDataEmissao write FDataEmissao;
    property HoraEmissao: TTime read FHoraEmissao write FHoraEmissao;
  end;

  IVersaoR02 = interface
    ['{804D59C4-BD7A-449E-82DF-DD1E2B982B06}']
    function RetornarLinha(const ARegistro: TRegistroR02): string;
  end;


  TVersaoR02_0101 = class(TInterfacedObject, IVersaoR02)
    function RetornarLinha(const ARegistro: TRegistroR02): string; virtual;
  end;

  //  Incluído o campo COO no final do registro
  TVersaoR02_0102 = class(TVersaoR02_0101)
    function RetornarLinha(const ARegistro: TRegistroR02): string; override;
  end;

  //  Incluído o campo CRO no meio do registro
  TVersaoR02_0103 = class(TInterfacedObject, IVersaoR02)
    function RetornarLinha(const ARegistro: TRegistroR02): string;
  end;

  ///  O registro foi todo redefinido, incluindo novos campos.
  TVersaoR02_0104 = class(TInterfacedObject, IVersaoR02)
    function RetornarLinha(const ARegistro: TRegistroR02): string;
  end;

implementation



{ TRegistroR02 }

function TRegistroR02.GetTipo: string;
begin
  Result:= 'R02';
end;

{ TVersao0101 }

function TVersaoR02_0101.RetornarLinha(const ARegistro: TRegistroR02): string;
begin
  Result:=
    Formatar( ARegistro.Tipo, 3 ) +
    Formatar( ARegistro.NumeroFabricacaoECF, 20 ) +
    Formatar( ARegistro.UsuarioECF, 3 ) +
    Formatar( ARegistro.CRZ       , 6 )
end;

{ TVersao0102 }

function TVersaoR02_0102.RetornarLinha(const ARegistro: TRegistroR02): string;
begin
  Result:=
    inherited RetornarLinha(ARegistro) +
    Formatar( ARegistro.COO, 6 );
end;

{ TVersao0103 }

function TVersaoR02_0103.RetornarLinha(const ARegistro: TRegistroR02): string;
begin
  Result:=
    Formatar( ARegistro.Tipo, 3) +
    Formatar( ARegistro.NumeroFabricacaoECF, 20) +
    Formatar( ARegistro.CRO        , 6) +
    Formatar( ARegistro.UsuarioECF , 3) +
    Formatar( ARegistro.CRZ        , 6) +
    Formatar( ARegistro.COO        , 6);
end;

{ TVersaoR02_0104 }

function TVersaoR02_0104.RetornarLinha(const ARegistro: TRegistroR02): string;
begin
  Result:=
    Formatar( ARegistro.Tipo, 3) +
    Formatar( ARegistro.NumeroFabricacaoECF, 20) +
    Formatar( ARegistro.DataMovimento) +
    Formatar( ARegistro.DataEmissao  ) +
    Formatar( ARegistro.HoraEmissao  );
end;

end.


