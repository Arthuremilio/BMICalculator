program Atividade2_CalculadoraIMC;

uses
  Vcl.Forms,
  CalculadoraIMC in 'CalculadoraIMC.pas' {frmCalculadoraIMC},
  Classes in 'Classes\Classes.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCalculadoraIMC, frmCalculadoraIMC);
  Application.Run;
end.
