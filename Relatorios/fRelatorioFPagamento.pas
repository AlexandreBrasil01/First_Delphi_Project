unit fRelatorioFPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fRelatorioDefault, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport;

type
  TfrmRelatorioFPagamento = class(TfrmRelatorioDefault)
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    qryRelatorioID: TIntegerField;
    qryRelatorioDESCRICAO: TStringField;
    qryRelatorioTIPO: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioFPagamento: TfrmRelatorioFPagamento;

implementation

{$R *.dfm}

end.
