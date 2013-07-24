program ControleVersaoLayout;

uses
  Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {Form1},
  UnitRegistroR01 in 'UnitRegistroR01.pas',
  UnitRegistro in 'UnitRegistro.pas',
  UnitRegistroR02 in 'UnitRegistroR02.pas',
  UnitRegistrosArquivo in 'UnitRegistrosArquivo.pas',
  UnitRegistroR03 in 'UnitRegistroR03.pas',
  UnitRegistroUtils in 'UnitRegistroUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  ReportMemoryLeaksOnShutdown:= True;

  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.


