unit CalculadoraIMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Classes;

type
  TfrmCalculadoraIMC = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblIdade: TLabel;
    btnCalcular: TButton;
    GroupBox1: TGroupBox;
    btnEnvelhecer: TButton;
    btnEngordar: TButton;
    btnEmagrecer: TButton;
    btnCrescer: TButton;
    edtPeso: TEdit;
    edtAltura: TEdit;
    edtAnoNascimento: TEdit;
    lblResultado: TLabel;
    procedure btnCalcularClick(Sender: TObject);
    procedure btnEnvelhecerClick(Sender: TObject);
    procedure btnEngordarClick(Sender: TObject);
    procedure btnEmagrecerClick(Sender: TObject);
    procedure btnCrescerClick(Sender: TObject);
  private
    procedure CalcularIMC;
    procedure ClassificarIMC(const IMC: Double);
    procedure CamposObrigatorios;
    procedure ExibirIdade;
  public
    { Public declarations }
  end;

var
  frmCalculadoraIMC: TfrmCalculadoraIMC;

implementation

{$R *.dfm}

{ TfrmCalculadoraIMC }

procedure TfrmCalculadoraIMC.btnCalcularClick(Sender: TObject);
begin
      CamposObrigatorios;
      CalcularIMC;
      ExibirIdade;
end;

procedure TfrmCalculadoraIMC.btnCrescerClick(Sender: TObject);
var
  aumentarTamanho : Integer;
begin
  try
      aumentarTamanho  := StrToInt(edtAltura.Text) + 1;
      edtAltura.Text   := IntToStr(aumentarTamanho);
      CalcularIMC;

  except
    on  E: Exception do
        ShowMessage(Format('Ocorreu um erro ao acrescentar peso: %s', [E.Message]));
  end;
end;

procedure TfrmCalculadoraIMC.btnEmagrecerClick(Sender: TObject);
var
  diminuirPeso: Integer;
begin
  try
      diminuirPeso:= StrToInt(edtPeso.Text) - 1;
      edtPeso.Text := IntToStr(diminuirPeso);
      CalcularIMC;

  except
    on  E: Exception do
        ShowMessage(Format('Ocorreu um erro ao diminuir peso: %s', [E.Message]));
  end;
end;

procedure TfrmCalculadoraIMC.btnEngordarClick(Sender: TObject);
var
  acrescentarPeso: Integer;
begin
  try
      acrescentarPeso := StrToInt(edtPeso.Text) + 1;
      edtPeso.Text := IntToStr(acrescentarPeso);
      CalcularIMC;

  except
    on  E: Exception do
        ShowMessage(Format('Ocorreu um erro ao acrescentar peso: %s', [E.Message]));
  end;
end;

procedure TfrmCalculadoraIMC.btnEnvelhecerClick(Sender: TObject);
var
  acrescentarIdade: Integer;
begin
  try
      if (lblIdade.Caption) = '' then
      raise Exception.Create('Para usar o bot�o envelher � necess�rio que o campo idade esteja preenchido');
      acrescentarIdade := StrToInt(lblIdade.Caption) + 1;
      lblIdade.Caption := IntToStr(acrescentarIdade);
  except
    on  E: Exception do
        ShowMessage(Format('Ocorreu um erro ao acrescentar idade: %s', [E.Message]));

  end;
end;

procedure TfrmCalculadoraIMC.CalcularIMC;
var
  Pessoa: TPessoa;
  IMC:Double;
  AnoNascimento: Integer;
begin
  try
    try
      Pessoa := nil;
      Pessoa := TPessoa.Create;
      Pessoa.Peso := StrToFloat(edtPeso.Text );
      Pessoa.Altura := StrToInt(edtAltura.Text);

      IMC := Pessoa.Peso / ((Pessoa.Altura /100) * (Pessoa.Altura	/100));
      AnoNascimento := Pessoa.AnoNascimento;
      ClassificarIMC(IMC);

    except
      on E: Exception do
        ShowMessage(Format('Ocorreu um erro ao calcular o   IMC: $s' , [E.Message]))
    end;

  finally
      if Assigned(Pessoa) then
         FreeAndNil(Pessoa);
  end;
end;

procedure TfrmCalculadoraIMC.CamposObrigatorios;
var
  I: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].Tag = 1) then
    begin
      if Trim(TCustomEdit(Components[i]).Text).IsEmpty then
      begin
        ShowMessage('O deixou de preencher um campo obrigat�rio.');
        TCustomEdit(Components[i]).SetFocus;
        Exit;
      end;
    end;
  end;
end;

procedure TfrmCalculadoraIMC.ClassificarIMC(const IMC: Double);
const
  CONST_RESULTADO: String = 'Seu IMC � %f, voc� est� %s';
begin
   try
      if IMC < 18.5 then
      begin
         lblResultado.Caption := Format(CONST_RESULTADO, [IMC, 'abaixo do peso']);
         lblResultado.Font.Color := clWebWheat;
         Exit;
      end;

      if (IMC >= 18.5) and (IMC <= 24.9) then
      begin
         lblResultado.Caption := Format('Seu IMC � de %f, voc� est� com o peso normal', [IMC]);
         lblResultado.Font.Color := clWebNavajoWhite;
         Exit;
      end;

      if (IMC >= 25) and (IMC <= 29.9) then
      begin
         lblResultado.Caption := Format('Seu IMC � de %f, voc� est� com sobrepeso', [IMC]);
         lblResultado.Font.Color := clWebBurlywood;
         Exit;
      end;

      if (IMC >= 30) and (IMC <= 34.9) then
      begin
         lblResultado.Caption := Format('Seu IMC � de %f, voc� est� com Obesidade 1', [IMC]);
         lblResultado.Font.Color := clYellow;
         Exit;
      end;

      if (IMC >= 35) and (IMC <= 39.9) then
      begin
         lblResultado.Caption := Format('Seu IMC � de %f, voc� est� com Obesidade 2', [IMC]);
         lblResultado.Font.Color := clWebDarkOrange;
         Exit;
      end;

      if IMC >= 40 then
      begin
         lblResultado.Caption := Format('Seu IMC � de %f, voc� est� com Obesidade 3', [IMC]);
         lblResultado.Font.Color := clRed;
         Exit;
      end;

   except
      raise;
   end;
end;

procedure TfrmCalculadoraIMC.ExibirIdade;
var
  Pessoa: TPessoa;
begin
  try
    Pessoa := nil;
    Pessoa := TPessoa.Create;
    Pessoa.AnoNascimento := StrToInt(edtAnoNascimento.Text);
    lblIdade.Caption := IntToStr(Pessoa.Idade);

  finally
    if  Assigned(Pessoa) then
        FreeAndNil(Pessoa);
  end;

end;

end.
