unit fConsultaProduto;

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
  uProduto,
  fCadastroProduto, fFiltroProduto;

type
  TfrmConsultaProduto = class(TfrmConsultaDefault)
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cbxFiltroChange(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnRelatClick(Sender: TObject);

  private
    { Private declarations }
    procedure CarregaProdutos;
    procedure Incluir;
    procedure Alterar;
    procedure Excluir;
    procedure Visualizar;
  public
    { Public declarations }

  end;

var
  frmConsultaProduto: TfrmConsultaProduto;

implementation

{$R *.dfm}

procedure TfrmConsultaProduto.CarregaProdutos;
begin
  dtmConexao.qryConsultaProdutos.close;
  dtmConexao.qryConsultaProdutos.SQL.Clear;

  dtmConexao.qryConsultaProdutos.SQL.Add('  select                     ');
  dtmConexao.qryConsultaProdutos.SQL.Add('  P.ID                       ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,P.FK_UNIDADE               ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,P.DESCRICAO                ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,P.REFERENCIA               ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,P.PRECO                    ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,P.CUSTO                    ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,P.SALDO                    ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,P.PESO                     ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,P.FOTO                     ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ,U.unidade                  ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' from PRODUTO  P             ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' INNER JOIN UNIDADE U        ');
  dtmConexao.qryConsultaProdutos.SQL.Add(' ON P.fk_unidade = U.id      ');

  if edtPesquisar.Text <> emptyStr then
  begin
    case cbxFiltro.ItemIndex of
      0:
        begin
          dtmConexao.qryConsultaProdutos.SQL.Add('WHERE P.ID LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      1:
        begin
          dtmConexao.qryConsultaProdutos.SQL.Add('WHERE P.DESCRICAO LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
    end;
  end;
  dtmConexao.qryConsultaProdutos.SQL.Add(' ORDER BY ID ');
  dtmConexao.qryConsultaProdutos.open;
end;

procedure TfrmConsultaProduto.cbxFiltroChange(Sender: TObject);
begin
  // se for index = 0 recebe numbersonly = true;  se não, recebe   numbersonly = false
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

procedure TfrmConsultaProduto.edtPesquisarChange(Sender: TObject);
begin
  CarregaProdutos;
end;

procedure TfrmConsultaProduto.Incluir;
var
  lFormulario: TfrmCadastroProduto;
begin
  lFormulario := TfrmCadastroProduto.Create(nil);
  try
    lFormulario.TipoRotina := 'Incluir';

    lFormulario.edtID.Text := TProduto.GeraProximoID.tostring;
    lFormulario.ShowModal;
    CarregaProdutos;
  finally
    lFormulario.Free;
    CarregaProdutos;
  end;
end;

procedure TfrmConsultaProduto.Alterar;
var
  lFormulario: TfrmCadastroProduto;
  lProduto: TProduto;
begin
  lProduto := TProduto.Create;
  lFormulario := TfrmCadastroProduto.Create(nil);
  try

    lProduto.ID := dtmConexao.qryConsultaProdutos.FieldByName('ID').AsInteger;
    lProduto.Carrega;

    lProduto.CarregaImagem(lFormulario.imgProduto);

    lFormulario.TipoRotina := 'Alterar';
    lFormulario.edtID.Text := lProduto.ID.tostring;
    lFormulario.edtDESCRICAO.Text := lProduto.DESCRICAO;
    lFormulario.edtREFERENCIA.Text := lProduto.REFERENCIA;
    lFormulario.edtPreco.Text := lProduto.PRECO.tostring;
    lFormulario.edtCusto.Text := lProduto.CUSTO.tostring;
    lFormulario.edtSaldo.Text := lProduto.SALDO.tostring;
    lFormulario.edtPeso.Text := lProduto.PESO.tostring;
    lFormulario.CarregaUnidadeComboBox;
    lFormulario.cbxFkUnidade.ItemIndex :=
      lFormulario.cbxFkUnidade.Items.IndexOfObject(TObject(lProduto.IDUNIDADE));

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
    lProduto.Free;

    CarregaProdutos;
  end;
end;

procedure TfrmConsultaProduto.Excluir;
var
  lProduto: TProduto;
begin
  lProduto := TProduto.Create;
  try
    lProduto.ID := dtmConexao.qryConsultaProdutosID.AsInteger;
    lProduto.Carrega;
    lProduto.Excluir(true);
  finally
    lProduto.Free;
  end;
  CarregaProdutos;
end;

procedure TfrmConsultaProduto.Visualizar;
var
  lFormulario: TfrmCadastroProduto;
  lProduto: TProduto;
begin
  lProduto := TProduto.Create;
  lFormulario := TfrmCadastroProduto.Create(nil);
  try
    lProduto.ID := dtmConexao.qryConsultaProdutos.FieldByName('ID').AsInteger;
    lProduto.Carrega;
    lProduto.CarregaImagem(lFormulario.imgProduto);

    lFormulario.TipoRotina := 'Visualizar';
    lFormulario.edtID.Text := lProduto.ID.tostring;
    lFormulario.edtDESCRICAO.Text := lProduto.DESCRICAO;
    lFormulario.edtREFERENCIA.Text := lProduto.REFERENCIA;
    lFormulario.edtPreco.Text := lProduto.PRECO.tostring;
    lFormulario.edtCusto.Text := lProduto.CUSTO.tostring;
    lFormulario.edtSaldo.Text := lProduto.SALDO.tostring;
    lFormulario.edtPeso.Text := lProduto.PESO.tostring;
    lFormulario.CarregaUnidadeComboBox;
    lFormulario.cbxFkUnidade.ItemIndex :=
      lFormulario.cbxFkUnidade.Items.IndexOfObject(TObject(lProduto.IDUNIDADE));

    lFormulario.edtDESCRICAO.ReadOnly := true;
    lFormulario.edtREFERENCIA.ReadOnly := true;
    lFormulario.edtPreco.ReadOnly := true;
    lFormulario.edtCusto.ReadOnly := true;
    lFormulario.edtSaldo.ReadOnly := true;
    lFormulario.edtPeso.ReadOnly := true;
    lFormulario.CarregaUnidadeComboBox;
    lFormulario.cbxFkUnidade.enabled := false;
    lFormulario.btnSalvar.Visible := false;

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
    lProduto.Free;

    CarregaProdutos;
  end;
end;

procedure TfrmConsultaProduto.btnAtualizarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaProdutos.RecordCount > 0 then
  begin
    CarregaProdutos;
  end
  else
  begin
    ShowMessage('Não há registros para serem carregados.');
  end;
end;

procedure TfrmConsultaProduto.btnIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmConsultaProduto.btnRelatClick(Sender: TObject);
var
  lFormulario: TfrmfiltroProduto;
begin
  lFormulario := TfrmfiltroProduto.Create(nil);
  try
    lFormulario.ShowModal;

  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaProduto.btnAlterarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaProdutos.RecordCount > 0 then
  begin
    Alterar;
  end
  else
  begin
    ShowMessage('Não há registros para serem alterados.');
  end;
end;

procedure TfrmConsultaProduto.btnExcluirClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaProdutos.RecordCount > 0 then
  begin
    Excluir;
  end
  else
  begin
    ShowMessage('Não há registros para serem excluídos.');
  end;
end;

procedure TfrmConsultaProduto.btnVisualizarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaProdutos.RecordCount > 0 then
  begin
    Visualizar;
  end
  else
  begin
    ShowMessage('Não há registros para serem visualizados.');
  end;
end;

procedure TfrmConsultaProduto.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultaProduto.FormShow(Sender: TObject);
begin
  inherited;
  CarregaProdutos;
end;

end.
