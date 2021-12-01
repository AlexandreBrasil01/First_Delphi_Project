unit fRelatorioVendedor;

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
  fRelatorioDefault,
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
  RLReport,
  uVendedor;

type
  TfrmRelatorioVendedor = class(TfrmRelatorioDefault)
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLImage1: TRLImage;
    qryRelatorioID: TIntegerField;
    qryRelatorioNOME: TStringField;
    qryRelatorioEMAIL: TStringField;
    qryRelatorioENDERECO: TStringField;
    qryRelatorioBAIRRO: TStringField;
    qryRelatorioCEP: TStringField;
    qryRelatorioCIDADE: TStringField;
    qryRelatorioFOTO: TBlobField;
    procedure RLImage1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioVendedor: TfrmRelatorioVendedor;

implementation

{$R *.dfm}

procedure TfrmRelatorioVendedor.RLImage1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
  lVendedor: TVendedor;
begin
  lVendedor := TVendedor.Create;
  lVendedor.ID := qryRelatorio.FieldByName('ID').asinteger;
  lVendedor.carrega; // aqui carrega propriedades do cliente na classe

  lVendedor.CarregaRLImagem(RLImage1);
end;

end.
