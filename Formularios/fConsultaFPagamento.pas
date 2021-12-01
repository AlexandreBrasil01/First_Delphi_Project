unit fConsultaFPagamento;

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
  fConsultaDefault,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  dConexao,
  fCadastroFPagamento,
  uFPagamento,
  fFiltroFPagamento;

type
  TfrmConsultaFPagamento = class(TfrmConsultaDefault)
    procedure FormShow(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cbxFiltroChange(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure btnRelatClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaFPagamento;
    procedure Incluir;
    procedure Alterar;
    procedure Excluir;
    procedure Visualizar;
  public
    { Public declarations }
  end;

var
  frmConsultaFPagamento: TfrmConsultaFPagamento;

implementation

{$R *.dfm}

procedure TfrmConsultaFPagamento.CarregaFPagamento;
begin
  dtmConexao.qryConsultaFPagamento.close;
  dtmConexao.qryConsultaFPagamento.SQL.Clear;
  dtmConexao.qryConsultaFPagamento.SQL.Add(' select * from FORMAPAGAMENTO ');

  if edtPesquisar.Text <> emptyStr then
  begin
    case cbxFiltro.ItemIndex of
      0:
        begin
          dtmConexao.qryConsultaFPagamento.SQL.Add
            ('WHERE ID LIKE ' + QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      1:
        begin
          dtmConexao.qryConsultaFPagamento.SQL.Add('WHERE DESCRICAO LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
    end;
  end;
  dtmConexao.qryConsultaFPagamento.open;
end;

procedure TfrmConsultaFPagamento.cbxFiltroChange(Sender: TObject);
begin
  case cbxFiltro.ItemIndex of
    0:
      begin
        edtPesquisar.NumbersOnly := true;
        edtPesquisar.Clear;
      end;
    1:
      begin
        edtPesquisar.NumbersOnly := false;
        edtPesquisar.Clear;
      end;
  end;
end;

procedure TfrmConsultaFPagamento.edtPesquisarChange(Sender: TObject);
begin
  CarregaFPagamento;
end;

procedure TfrmConsultaFPagamento.Incluir;
var
  lFormulario: TfrmCadastroFPagamento;
begin
  lFormulario := TfrmCadastroFPagamento.Create(nil);
  try
    lFormulario.TipoRotina := 'Incluir';
    lFormulario.edtID.Text := TFPagamento.GeraProximoID.tostring;
    lFormulario.ShowModal;
    CarregaFPagamento;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaFPagamento.Alterar;
var
  lFormulario: TfrmCadastroFPagamento;
  lFPagamento: TFPagamento;
begin
  lFormulario := TfrmCadastroFPagamento.Create(nil);
  lFPagamento := TFPagamento.Create;
  try
    lFPagamento.ID := dtmConexao.qryConsultaFPagamento.FieldByName('ID')
      .AsInteger;
    lFPagamento.Carrega;

    lFormulario.edtID.Text := lFPagamento.ID.tostring;
    lFormulario.edtDescricao.Text := lFPagamento.DESCRICAO;

    if lFPagamento.TIPO = ('A') then
    begin
      lFormulario.rdgTipo.ItemIndex := 0;
    end
    else
    begin
      lFormulario.rdgTipo.ItemIndex := 1;
    end;

    lFormulario.TipoRotina := 'Alterar';
    lFormulario.ShowModal;
  finally
    lFormulario.Free;
    lFPagamento.Free;
    CarregaFPagamento;
  end;
end;

procedure TfrmConsultaFPagamento.Excluir;
var
  lFPagamento: TFPagamento;
begin
  lFPagamento := TFPagamento.Create;
  try
    lFPagamento.ID := dtmConexao.qryConsultaFPagamentoID.AsInteger;
    lFPagamento.Carrega;
    lFPagamento.Excluir(true);
  finally
    lFPagamento.Free;
  end;
  CarregaFPagamento;
end;

procedure TfrmConsultaFPagamento.Visualizar;
var
  lFormulario: TfrmCadastroFPagamento;
  lFPagamento: TFPagamento;
begin
  lFormulario := TfrmCadastroFPagamento.Create(nil);
  lFPagamento := TFPagamento.Create;
  try
    lFPagamento.ID := dtmConexao.qryConsultaFPagamento.FieldByName('ID')
      .AsInteger;
    lFPagamento.Carrega;

    lFormulario.TipoRotina := 'Visualizar';
    lFormulario.edtID.Text := lFPagamento.ID.tostring;
    lFormulario.edtDescricao.Text := lFPagamento.DESCRICAO;
    if lFPagamento.TIPO = ('A') then
    begin
      lFormulario.rdgTipo.ItemIndex := 0;
    end
    else
    begin
      lFormulario.rdgTipo.ItemIndex := 1;
    end;

    lFormulario.edtDescricao.ReadOnly := true;
    lFormulario.rdgTipo.Enabled := false;
    lFormulario.btnSalvar.Visible := false;

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
    lFPagamento.Free;
    CarregaFPagamento;
  end;
end;

procedure TfrmConsultaFPagamento.btnAtualizarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaFPagamento.RecordCount > 0 then
  begin
    CarregaFPagamento;
  end
  else
  begin
    ShowMessage('Não há registros para serem carregados.');
  end;
end;

procedure TfrmConsultaFPagamento.btnIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmConsultaFPagamento.btnRelatClick(Sender: TObject);
var
  lFormulario: TfrmfiltroFPagamento;
begin
  lFormulario := TfrmfiltroFPagamento.Create(nil);
  try
    lFormulario.ShowModal;

  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaFPagamento.btnAlterarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaFPagamento.RecordCount > 0 then
  begin
    Alterar;
  end
  else
  begin
    ShowMessage('Não há registros para serem alterados.');
  end;
end;

procedure TfrmConsultaFPagamento.btnExcluirClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaFPagamento.RecordCount > 0 then
  begin
    Excluir;
  end
  else
  begin
    ShowMessage('Não há registros para serem excluídos.');
  end;
end;

procedure TfrmConsultaFPagamento.btnVisualizarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaFPagamento.RecordCount > 0 then
  begin
    Visualizar;
  end
  else
  begin
    ShowMessage('Não há registros para serem carregados.');
  end;
end;

procedure TfrmConsultaFPagamento.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultaFPagamento.FormShow(Sender: TObject);
begin
  inherited;
  CarregaFPagamento;
end;

end.
