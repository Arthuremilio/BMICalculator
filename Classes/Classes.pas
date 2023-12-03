unit Classes;

interface

uses
  DateUtils,
  System.SysUtils;

type
    TPessoa = class
  private
      FNome: String;
      FAltura: Double;
      FPeso: Double;
      FAnoNascimento: Integer;

      function FIdade : Integer;
  public
    property Nome: String read FNome write FNome;
    property Idade: Integer read FIdade;
    property Altura: Double read FAltura write FAltura;
    property Peso: Double read FPeso write FPeso;
    property AnoNascimento: Integer read FAnoNascimento write FAnoNascimento;

    constructor Create;
  end;

implementation

constructor TPessoa.Create;
begin
  FNome := 'O nome não foi informado';
end;

function TPessoa.FIdade: Integer;
begin
  Result := YearOf(Date) - FAnoNascimento;
end;

end.
