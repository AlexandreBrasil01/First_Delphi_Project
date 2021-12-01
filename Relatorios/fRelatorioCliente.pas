unit fRelatorioCliente;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  RLReport,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  dconexao,
  uHelpersRLImagensBase64,
  uCliente;

type
  TfrmRelatorioCliente = class(TForm)
    rlpRelatorio: TRLReport;
    rlbRegistros: TRLBand;
    txtNome: TRLDBText;
    qryRelatorio: TFDQuery;
    DataSource1: TDataSource;
    qryRelatorioID: TIntegerField;
    qryRelatorioNOME: TStringField;
    qryRelatorioCPF: TStringField;
    qryRelatorioCNPJ: TStringField;
    qryRelatorioFISICOOUJURIDICO: TStringField;
    qryRelatorioEMAIL: TStringField;
    qryRelatorioENDERECO: TStringField;
    qryRelatorioBAIRRO: TStringField;
    qryRelatorioCEP: TStringField;
    qryRelatorioCIDADE: TStringField;
    qryRelatorioFOTO: TBlobField;
    txtBairro: TRLDBText;
    rlbCabecalho: TRLBand;
    rllCabecalhoTxt: TRLLabel;
    txtcpfcnpj: TRLDBText;
    txtEmail: TRLDBText;
    RLLabel1: TRLLabel;
    txtCidade: TRLDBText;
    txtEndereco: TRLDBText;
    txtCEP: TRLDBText;
    RLImage1: TRLImage;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    procedure txtcpfcnpjBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure RLImage1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLLabel2BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioCliente: TfrmRelatorioCliente;

implementation

{$R *.dfm}

procedure TfrmRelatorioCliente.RLImage1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
  lCliente: TCliente;
begin
  lCliente := TCliente.Create;
  lCliente.ID := qryRelatorio.FieldByName('ID').asinteger;
  lCliente.carrega; // aqui carrega propriedades do cliente na classe

  lCliente.CarregaRLImagem(RLImage1);
end;

procedure TfrmRelatorioCliente.RLLabel2BeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
  if qryRelatorio.FieldByName('FISICOOUJURIDICO').AsString = 'J' then
  begin
    AText := 'CNPJ:';
  end
  else
  begin
    AText := 'CPF:';
  end;
end;

procedure TfrmRelatorioCliente.txtcpfcnpjBeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
  if qryRelatorio.FieldByName('FISICOOUJURIDICO').AsString = 'J' then
  begin
    AText := qryRelatorio.FieldByName('CNPJ').AsString;
  end
  else
  begin
    AText := qryRelatorio.FieldByName('CPF').AsString;
  end;
end;

end.
