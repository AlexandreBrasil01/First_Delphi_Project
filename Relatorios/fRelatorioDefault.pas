unit fRelatorioDefault;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRelatorioDefault = class(TForm)
    rlpRelatorio: TRLReport;
    rlbCabecalho: TRLBand;
    rllCabecalhoTxt: TRLLabel;
    rlbRegistros: TRLBand;
    DataSource1: TDataSource;
    qryRelatorio: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioDefault: TfrmRelatorioDefault;

implementation

{$R *.dfm}

end.
