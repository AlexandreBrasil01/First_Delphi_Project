unit fRelatorioVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fRelatorioDefault, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, uProduto;

type
  TfrmRelatorioVenda = class(TfrmRelatorioDefault)
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    DataSource2: TDataSource;
    qryDetalhe: TFDQuery;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    qryRelatorioID2: TIntegerField;
    qryRelatorioFK_CLIENTE: TIntegerField;
    qryRelatorioNCLIENTE: TStringField;
    qryRelatorioFK_VENDEDOR: TIntegerField;
    qryRelatorioNVENDEDOR: TStringField;
    qryRelatorioFK_FORMAPAGAMENTO: TIntegerField;
    qryRelatorioDESCRICAO2: TStringField;
    qryRelatorioOBS: TStringField;
    qryRelatorioDESCONTO: TCurrencyField;
    qryRelatorioTOTAL: TBCDField;
    qryRelatorioEMISSAO: TSQLTimeStampField;
    qryRelatorioDATA_VENCIMENTO: TSQLTimeStampField;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLBand1: TRLBand;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    qryDetalheID: TIntegerField;
    qryDetalheFK_VENDA: TIntegerField;
    qryDetalheFK_PRODUTO: TIntegerField;
    qryDetalheDESCRICAO: TStringField;
    qryDetalheFOTO: TBlobField;
    qryDetalheEMISSAO: TSQLTimeStampField;
    qryDetalheQUANTIDADE: TBCDField;
    qryDetalheVALOR: TBCDField;
    qryDetalheDESCONTO: TCurrencyField;
    RLImage1: TRLImage;
    procedure RLImage1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioVenda: TfrmRelatorioVenda;

implementation

{$R *.dfm}

procedure TfrmRelatorioVenda.RLImage1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
  lProduto: TProduto;
begin
  lProduto := TProduto.Create;
  lProduto.ID := qryDetalhe.FieldByName('FK_PRODUTO').asinteger;
  lProduto.carrega; // aqui carrega propriedades do cliente na classe

  lProduto.CarregaRLImagem(RLImage1);
end;

end.
