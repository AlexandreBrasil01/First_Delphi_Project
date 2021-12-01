unit fRelatorioUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fRelatorioDefault, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport, uUsuario;

type
  TfrmRelatorioUsuario = class(TfrmRelatorioDefault)
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLImage1: TRLImage;
    RLDBText4: TRLDBText;
    RLLabel4: TRLLabel;
    qryRelatorioID: TIntegerField;
    qryRelatorioNOME: TStringField;
    qryRelatorioLOGIN: TStringField;
    qryRelatorioSENHA: TStringField;
    qryRelatorioNIVELACESSO: TIntegerField;
    qryRelatorioEMAIL: TStringField;
    qryRelatorioFOTO: TBlobField;
    procedure RLImage1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioUsuario: TfrmRelatorioUsuario;

implementation

{$R *.dfm}

procedure TfrmRelatorioUsuario.RLImage1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
  lUsuario: TUsuario;
begin
  lUsuario := TUsuario.Create;
  lUsuario.ID := qryRelatorio.FieldByName('ID').asinteger;
  lUsuario.carrega; // aqui carrega propriedades do cliente na classe

  lUsuario.CarregaRLImagem(RLImage1);
end;

end.
