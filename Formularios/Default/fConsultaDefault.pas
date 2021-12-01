unit fConsultaDefault;

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
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  dConexao,
  uConfig;

type
  TfrmConsultaDefault = class(TForm)
    pnlPesquisa: TPanel;
    grdConsulta: TDBGrid;
    pnlBotoes: TPanel;
    btnAtualizar: TButton;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnSair: TButton;
    pnlGrid: TPanel;
    btnExcluir: TButton;
    btnRelat: TButton;
    cbxFiltro: TComboBox;
    edtPesquisar: TEdit;
    btnVisualizar: TButton;
    pnlTitulo: TPanel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure grdConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetaVisibleBtnPorNivelAcesso;
  end;

var
  frmConsultaDefault: TfrmConsultaDefault;
  ID: String;

implementation

{$R *.dfm}

procedure TfrmConsultaDefault.SetaVisibleBtnPorNivelAcesso;
begin
  lConfig.CarregaRestricoesBanco;
  if lConfig.INCLUIR < lConfig.CONFIGNACESSO then
  begin
    btnIncluir.Visible := false;
  end;
  if lConfig.ALTERAR < lConfig.CONFIGNACESSO then
  begin
    btnAlterar.visible := false;
  end;
  if lConfig.EXCLUIR < lConfig.CONFIGNACESSO then
  begin
    btnExcluir.visible := false;
  end;
  if lConfig.VISUALIZAR < lConfig.CONFIGNACESSO then
  begin
    btnVisualizar.visible := false;
  end;
  if lConfig.RELATORIO < lConfig.CONFIGNACESSO then
  begin
    btnRelat.visible := false;
  end;
end;

procedure TfrmConsultaDefault.grdConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    grdConsulta.Canvas.brush.Color := StringToColor(lConfig.CONFIGCOR);
    grdConsulta.Canvas.font.Color := clwhite;
  end;
  grdConsulta.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmConsultaDefault.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmConsultaDefault.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  SetaVisibleBtnPorNivelAcesso;
end;

end.
