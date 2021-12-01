unit fConsultaVenda;

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
  Vcl.ComCtrls,
  fVendas,
  uVenda,
  fFiltroVenda, uItem, FireDAC.Comp.Client, fAlteraVenda;

type
  TfrmConsultaVenda = class(TfrmConsultaDefault)
    pnlData: TPanel;
    dtpEmissao: TDateTimePicker;
    cbxFiltraData: TCheckBox;
    lblFiltroData: TLabel;
    procedure cbxFiltroChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure btnRelatClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaVenda;
    procedure Incluir;
    procedure Alterar;
    procedure Excluir;
    procedure Visualizar;
    procedure Relatorio;
  public
    { Public declarations }
  end;

var
  frmConsultaVenda: TfrmConsultaVenda;
  ID: String;

implementation

{$R *.dfm}
{ TfrmConsultaVenda }

procedure TfrmConsultaVenda.CarregaVenda;
var
  Data: Tdate;
begin

  dtmconexao.qryVenda.close;
  dtmconexao.qryVenda.sql.clear;
  dtmconexao.qryVenda.sql.Add(' SELECT                            ');
  dtmconexao.qryVenda.sql.Add(' V.ID                              ');
  dtmconexao.qryVenda.sql.Add(' , V.FK_CLIENTE                    ');
  dtmconexao.qryVenda.sql.Add(' , C.NOME                          ');
  dtmconexao.qryVenda.sql.Add(' , V.FK_VENDEDOR                   ');
  dtmconexao.qryVenda.sql.Add(' , VN.NOME                         ');
  dtmconexao.qryVenda.sql.Add(' , V.FK_FORMAPAGAMENTO             ');
  dtmconexao.qryVenda.sql.Add(' , FP.DESCRICAO                    ');
  dtmconexao.qryVenda.sql.Add(' , V.OBS                           ');
  dtmconexao.qryVenda.sql.Add(' , V.DESCONTO                      ');
  dtmconexao.qryVenda.sql.Add(' , V.TOTAL                         ');
  dtmconexao.qryVenda.sql.Add(' , V.EMISSAO                       ');
  dtmconexao.qryVenda.sql.Add(' , V.DATA_VENCIMENTO               ');
  dtmconexao.qryVenda.sql.Add(' from VENDA V                      ');
  dtmconexao.qryVenda.sql.Add(' inner join CLIENTE C              ');
  dtmconexao.qryVenda.sql.Add(' on V.FK_CLIENTE = C.ID            ');
  dtmconexao.qryVenda.sql.Add(' inner join VENDEDOR VN            ');
  dtmconexao.qryVenda.sql.Add(' on V.FK_VENDEDOR = VN.ID          ');
  dtmconexao.qryVenda.sql.Add(' inner join FORMAPAGAMENTO FP      ');
  dtmconexao.qryVenda.sql.Add(' on V.FK_FORMAPAGAMENTO = FP.ID    ');

  if edtPesquisar.Text <> emptyStr then
  begin
    case cbxFiltro.ItemIndex of
      0:
        begin
          dtmconexao.qryVenda.sql.Add('WHERE V.ID LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      1:
        begin
          dtmconexao.qryVenda.sql.Add('WHERE C.NOME LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      2:
        begin
          dtmconexao.qryVenda.sql.Add('WHERE VN.NOME LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      3:
        begin
          dtmconexao.qryVenda.sql.Add(' WHERE FP.DESCRICAO LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
    end;
    if cbxFiltraData.Checked then
    begin
      dtmconexao.qryVenda.sql.Add(' AND V.EMISSAO = ' +
        DateToStr(dtpEmissao.Date));
    end;
  end
  else if cbxFiltraData.Checked then
  begin
    dtmconexao.qryVenda.sql.Add(' WHERE V.EMISSAO = ' +
      DateToStr(dtpEmissao.Date));
  end;
  dtmconexao.qryVenda.sql.Add(' ORDER BY ID ');
  dtmconexao.qryVenda.open;
end;

procedure TfrmConsultaVenda.Incluir;
var
  lFormulario: TfrmVendas;
begin
  lFormulario := TfrmVendas.Create(nil);
  try
    lFormulario.TipoRotina := 'Incluir';
    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
  CarregaVenda;
end;

procedure TfrmConsultaVenda.Alterar;
var
  lSubTotal: Double;
  lValor, lDesc, lQuant, lTotalItem: Double;
  lVenda: TVenda;
  lItem: TItem;
  lFormulario: TfrmAlteraVenda;
  lQuery: TFDQuery;
begin
  lValor := 0;
  lDesc := 0;
  lQuant := 0;
  lTotalItem := 0;
  lSubTotal := 0;
  lFormulario := TfrmAlteraVenda.Create(nil);
  lQuery := TFDQuery.Create(nil);
  lVenda := TVenda.Create;
  try

    lVenda.ID := dtmconexao.qryVenda.FieldByName('ID').AsInteger;
    lVenda.Carrega;

    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.close;
    lQuery.sql.clear;
    lQuery.sql.Add(' SELECT * FROM VENDA_ITEM ');
    lQuery.sql.Add(' inner join PRODUTO P     ');
    lQuery.sql.Add(' on fk_produto = p.id     ');
    lQuery.sql.Add(' WHERE FK_VENDA = :ID     ');
    lQuery.sql.Add(' ORDER BY fk_produto      ');
    lQuery.ParamByName('ID').AsInteger := lVenda.ID;
    lQuery.open;

    lQuery.First;
    while not lQuery.Eof do
    begin

      lValor := lQuery.FieldByName('VALOR').AsFloat;
      lDesc := lQuery.FieldByName('DESCONTO').AsFloat;
      lQuant := lQuery.FieldByName('QUANTIDADE').AsFloat;

      lTotalItem := lQuant * lValor;

      if lDesc > 0 then
      begin
        lTotalItem := lTotalItem - (lDesc * (lTotalItem)) / 100;
      end;

      dtmconexao.tblConsultaItens.append;
      dtmconexao.tblConsultaItensFK_VENDA.AsInteger :=
        lQuery.FieldByName('FK_Venda').AsInteger;
      dtmconexao.tblConsultaItensFK_PRODUTO.AsInteger :=
        lQuery.FieldByName('FK_PRODUTO').AsInteger;
      dtmconexao.tblConsultaItensDESCRICAO.AsString :=
        lQuery.FieldByName('DESCRICAO').AsString;
      dtmconexao.tblConsultaItensEMISSAO.AsDateTime :=
        lQuery.FieldByName('EMISSAO').AsDateTime;
      dtmconexao.tblConsultaItensVALOR.AsFloat :=
        lQuery.FieldByName('VALOR').AsFloat;
      dtmconexao.tblConsultaItensDESCONTO.AsFloat :=
        lQuery.FieldByName('DESCONTO').AsFloat;
      dtmconexao.tblConsultaItensQUANTIDADE.AsFloat :=
        lQuery.FieldByName('QUANTIDADE').AsFloat;
      dtmconexao.tblConsultaItensTotal.AsFloat := lTotalItem;
      dtmconexao.tblConsultaItens.Post;

      lSubTotal := lSubTotal + lTotalItem;

      lQuery.Next;
    end;

    lQuery.First;

    if lSubTotal < lVenda.Total then
    begin
      lFormulario.rdgAcrsDesc.ItemIndex := 1;
    end
    else if lSubTotal = lVenda.Total then
    begin
      lFormulario.rdgAcrsDesc.ItemIndex := 0;
    end
    else if lSubTotal > lVenda.Total then
    begin
      lFormulario.rdgAcrsDesc.ItemIndex := 2;
    end;

    lFormulario.edtIdVenda.Text := lVenda.ID.tostring;
    lFormulario.edtIdCliente.Text := lVenda.Cliente.ID.tostring;
    lFormulario.lblNomeCliente.Caption := lVenda.Cliente.NOME;
    lFormulario.edtIdVendedor.Text := lVenda.Vendedor.ID.tostring;
    lFormulario.lblNomeVendedor.Caption := lVenda.Vendedor.NOME;
    lFormulario.edtIdFPagamento.Text := lVenda.FormaPagamento.ID.tostring;
    lFormulario.edtTipo.Text := lVenda.FormaPagamento.TIPO;
    lFormulario.lblNomeFPagamento.Caption := lVenda.FormaPagamento.DESCRICAO;
    lFormulario.memoObs.Text := lVenda.Obs;
    lFormulario.edtValorAcrsDesc.Text := FormatFloat('#,##0.00',
      lVenda.Desconto);
    lFormulario.edtPorcentual.Text := FormatFloat('#,##0.00%',
      lVenda.Desconto / lSubTotal * 100);
    lFormulario.lblSubTotalNum.Caption := FormatFloat('#,##0.00', lSubTotal);
    lFormulario.lblAcrsDescNum.Caption :=
      FormatFloat('#,##0.00', lVenda.Desconto);
    lFormulario.lblTotalNum.Caption := FormatFloat('#,##0.00', lVenda.Total);
    lFormulario.EmissaoAntiga := lVenda.Emissao;

    lFormulario.ShowModal;
  finally
    dtmconexao.tblConsultaItens.EmptyDataSet;
    lFormulario.Free;
    lVenda.Free;
    lQuery.Free;
  end;
end;

procedure TfrmConsultaVenda.Excluir;
var
  lVenda: TVenda;
  lItem: TItem;
begin
  lVenda := TVenda.Create;
  lItem := TItem.Create;
  try
    lVenda.ID := dtmconexao.qryVenda.FieldByName('ID').AsInteger;
    lItem.Venda := dtmconexao.qryVenda.FieldByName('ID').AsInteger;

    lItem.Excluir(true);
    lVenda.Excluir(true);

    CarregaVenda;
  finally
    lVenda.Free;
    lItem.Free;
  end;
end;

procedure TfrmConsultaVenda.Visualizar;
var
  lSubTotal: Double;
  lValor, lDesc, lQuant, lTotalItem: Double;
  lVenda: TVenda;
  lItem: TItem;
  lFormulario: TfrmAlteraVenda;
  lQuery: TFDQuery;
begin
  lValor := 0;
  lDesc := 0;
  lQuant := 0;
  lTotalItem := 0;
  lSubTotal := 0;
  lFormulario := TfrmAlteraVenda.Create(nil);
  lQuery := TFDQuery.Create(nil);
  lVenda := TVenda.Create;
  try

    lVenda.ID := dtmconexao.qryVenda.FieldByName('ID').AsInteger;
    lVenda.Carrega;

    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.close;
    lQuery.sql.clear;
    lQuery.sql.Add(' SELECT * FROM VENDA_ITEM ');
    lQuery.sql.Add(' inner join PRODUTO P     ');
    lQuery.sql.Add(' on fk_produto = p.id     ');
    lQuery.sql.Add(' WHERE FK_VENDA = :ID     ');
    lQuery.sql.Add(' ORDER BY fk_produto      ');
    lQuery.ParamByName('ID').AsInteger := lVenda.ID;
    lQuery.open;

    lQuery.First;
    while not lQuery.Eof do
    begin

      lValor := lQuery.FieldByName('VALOR').AsFloat;
      lDesc := lQuery.FieldByName('DESCONTO').AsFloat;
      lQuant := lQuery.FieldByName('QUANTIDADE').AsFloat;

      lTotalItem := lQuant * lValor;

      if lDesc > 0 then
      begin
        lTotalItem := lTotalItem - (lDesc * (lTotalItem)) / 100;
      end;

      dtmconexao.tblConsultaItens.append;
      dtmconexao.tblConsultaItensFK_VENDA.AsInteger :=
        lQuery.FieldByName('FK_Venda').AsInteger;
      dtmconexao.tblConsultaItensFK_PRODUTO.AsInteger :=
        lQuery.FieldByName('FK_PRODUTO').AsInteger;
      dtmconexao.tblConsultaItensDESCRICAO.AsString :=
        lQuery.FieldByName('DESCRICAO').AsString;
      dtmconexao.tblConsultaItensEMISSAO.AsDateTime :=
        lQuery.FieldByName('EMISSAO').AsDateTime;
      dtmconexao.tblConsultaItensVALOR.AsFloat :=
        lQuery.FieldByName('VALOR').AsFloat;
      dtmconexao.tblConsultaItensDESCONTO.AsFloat :=
        lQuery.FieldByName('DESCONTO').AsFloat;
      dtmconexao.tblConsultaItensQUANTIDADE.AsFloat :=
        lQuery.FieldByName('QUANTIDADE').AsFloat;
      dtmconexao.tblConsultaItensTotal.AsFloat := lTotalItem;
      dtmconexao.tblConsultaItens.Post;

      lSubTotal := lSubTotal + lTotalItem;

      lQuery.Next;
    end;

    lQuery.First;

    if lSubTotal < lVenda.Total then
    begin
      lFormulario.rdgAcrsDesc.ItemIndex := 1;
    end
    else if lSubTotal = lVenda.Total then
    begin
      lFormulario.rdgAcrsDesc.ItemIndex := 0;
    end
    else if lSubTotal > lVenda.Total then
    begin
      lFormulario.rdgAcrsDesc.ItemIndex := 2;
    end;

    lFormulario.edtIdVenda.Text := lVenda.ID.tostring;
    lFormulario.edtIdCliente.Text := lVenda.Cliente.ID.tostring;
    lFormulario.lblNomeCliente.Caption := lVenda.Cliente.NOME;
    lFormulario.edtIdVendedor.Text := lVenda.Vendedor.ID.tostring;
    lFormulario.lblNomeVendedor.Caption := lVenda.Vendedor.NOME;
    lFormulario.edtIdFPagamento.Text := lVenda.FormaPagamento.ID.tostring;
    lFormulario.edtTipo.Text := lVenda.FormaPagamento.TIPO;
    lFormulario.lblNomeFPagamento.Caption := lVenda.FormaPagamento.DESCRICAO;
    lFormulario.memoObs.Text := lVenda.Obs;
    lFormulario.edtValorAcrsDesc.Text := FormatFloat('#,##0.00',
      lVenda.Desconto);
    lFormulario.edtPorcentual.Text := FormatFloat('#,##0.00%',
      lVenda.Desconto / lSubTotal * 100);
    lFormulario.lblSubTotalNum.Caption := FormatFloat('#,##0.00', lSubTotal);
    lFormulario.lblAcrsDescNum.Caption :=
      FormatFloat('#,##0.00', lVenda.Desconto);
    lFormulario.lblTotalNum.Caption := FormatFloat('#,##0.00', lVenda.Total);
    lFormulario.EmissaoAntiga := lVenda.Emissao;

    lFormulario.edtIdCliente.ReadOnly := true;
    lFormulario.edtIdVendedor.ReadOnly := true;
    lFormulario.edtIdFPagamento.ReadOnly := true;
    lFormulario.btnBuscaNomeCliente.Visible := false;
    lFormulario.btnBuscaNomeVendedor.Visible := false;
    lFormulario.btnBuscaFPagamento.Visible := false;
    lFormulario.pnlVencimento.Enabled := false;
    lFormulario.btnIncluir.Visible := false;
    lFormulario.btnExcluir.Visible := false;
    lFormulario.btnConfirmar.Visible := false;
    lFormulario.btnCancelar.Caption := 'Sair';

    lFormulario.rdgAcrsDesc.Enabled := false;
    lFormulario.edtPorcentual.OnExit := nil;

    lFormulario.edtValorAcrsDesc.ReadOnly := true;
    lFormulario.edtPorcentual.ReadOnly := true;
    lFormulario.memoObs.ReadOnly := true;

    lFormulario.btnCancelar.SetFocus;
    lFormulario.ShowModal;
  finally
    dtmconexao.tblConsultaItens.EmptyDataSet;
    lFormulario.Free;
    lVenda.Free;
    lQuery.Free;
  end;
end;

procedure TfrmConsultaVenda.Relatorio;
var
  lFormulario: TfrmfiltroVenda;
begin
  lFormulario := TfrmfiltroVenda.Create(nil);
  try
    lFormulario.ID := dtmconexao.qryVenda.FieldByName('ID').AsInteger;
    lFormulario.ImprimeRelatorio;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaVenda.btnIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmConsultaVenda.btnAlterarClick(Sender: TObject);
begin
  if dtmconexao.qryVenda.RecordCount > 0 then
  begin
    Alterar;
  end
  else
  begin
    ShowMessage('Não há registros para serem alterados.');
  end;
end;

procedure TfrmConsultaVenda.btnAtualizarClick(Sender: TObject);
begin
  if dtmconexao.qryVenda.RecordCount > 0 then
  begin
    CarregaVenda;
  end
  else
  begin
    ShowMessage('Não há registros para serem carregados.');
  end;
end;

procedure TfrmConsultaVenda.btnExcluirClick(Sender: TObject);
begin
  if dtmconexao.qryVenda.RecordCount > 0 then
  begin
    Excluir;
  end
  else
  begin
    ShowMessage('Não há registros para serem excluídos.');
  end;
end;

procedure TfrmConsultaVenda.btnVisualizarClick(Sender: TObject);
begin
  if dtmconexao.qryVenda.RecordCount > 0 then
  begin
    Visualizar;
  end
  else
  begin
    ShowMessage('Não há registros para serem Visualizados.');
  end;
end;

procedure TfrmConsultaVenda.btnRelatClick(Sender: TObject);
begin
  if dtmconexao.qryVenda.RecordCount > 0 then
  begin
    Relatorio;
  end
  else
  begin
    ShowMessage('Não há registros para Imprimir.');
  end;
end;

procedure TfrmConsultaVenda.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultaVenda.cbxFiltroChange(Sender: TObject);
begin
  case cbxFiltro.ItemIndex of
    0:
      begin
        edtPesquisar.clear;
        edtPesquisar.SetFocus;
        edtPesquisar.NumbersOnly := true;
      end;
    1:
      begin
        edtPesquisar.clear;
        edtPesquisar.SetFocus;
        edtPesquisar.NumbersOnly := false;
      end;
    2:
      begin
        edtPesquisar.clear;
        edtPesquisar.SetFocus;
        edtPesquisar.NumbersOnly := false;
      end;
    3:
      begin
        edtPesquisar.clear;
        edtPesquisar.SetFocus;
        edtPesquisar.NumbersOnly := false;
      end;
  end;
end;

procedure TfrmConsultaVenda.edtPesquisarChange(Sender: TObject);
begin
  CarregaVenda;
end;

procedure TfrmConsultaVenda.FormShow(Sender: TObject);
begin
  inherited;
  CarregaVenda;
  dtpEmissao.DateTime := now;
  edtPesquisar.SetFocus;
end;

end.
