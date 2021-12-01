unit fRelatorioUnidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fRelatorioDefault, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, RLReport,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRelatorioUnidade = class(TfrmRelatorioDefault)
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    qryRelatorioID: TIntegerField;
    qryRelatorioDESCRICAO: TStringField;
    qryRelatorioUNIDADE: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioUnidade: TfrmRelatorioUnidade;

implementation

{$R *.dfm}

end.
