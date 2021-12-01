unit fAlteraVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, fAlteraVendaItem, dConexao, uVenda,
  uCliente, uVendedor, fConsultaCliente, fConsultaVendedor, uFPagamento,
  fConsultaFPagamento, uItem, System.ImageList, Vcl.ImgList;

type
  TfrmAlteraVenda = class(TForm)
    pnlCabecalho: TPanel;
    lblVendedor: TLabel;
    lblNomeVendedor: TLabel;
    lblCliente: TLabel;
    lblNVenda: TLabel;
    lblNomeCliente: TLabel;
    edtIdVendedor: TEdit;
    edtIdCliente: TEdit;
    edtIdVenda: TEdit;
    pnlTitulo: TPanel;
    pnlGrid: TPanel;
    pnlProdutoFinal: TPanel;
    lblObs: TLabel;
    lblValorAcresDesc: TLabel;
    lblPercentual: TLabel;
    pnlValorFinal: TPanel;
    lblDivisoria: TLabel;
    lblTotalF: TLabel;
    lblSubtotal: TLabel;
    lblDescontoF: TLabel;
    lblAcrsDescNum: TLabel;
    lblSubTotalNum: TLabel;
    lblTotalNum: TLabel;
    edtPorcentual: TEdit;
    memoObs: TMemo;
    rdgAcrsDesc: TRadioGroup;
    edtValorAcrsDesc: TEdit;
    pnlBtnFinal: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    edtIdFPagamento: TEdit;
    lblNomeFPagamento: TLabel;
    lblFPagamento: TLabel;
    gridItens: TDBGrid;
    btnIncluir: TButton;
    btnExcluir: TButton;
    btnBuscaNomeCliente: TButton;
    btnBuscaNomeVendedor: TButton;
    btnBuscaFPagamento: TButton;
    edtTipo: TEdit;
    ImgButtons: TImageList;
    pnlVencimento: TPanel;
    dtpvencimento: TDateTimePicker;
    lblVencimento: TLabel;
    procedure edtValorAcrsDescExit(Sender: TObject);
    procedure edtPorcentualExit(Sender: TObject);
    procedure rdgAcrsDescClick(Sender: TObject);
    procedure gridItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnBuscaNomeClienteClick(Sender: TObject);
    procedure btnBuscaNomeVendedorClick(Sender: TObject);
    procedure edtIdFPagamentoExit(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
    procedure btnBuscaFPagamentoClick(Sender: TObject);
    procedure edtIdClienteExit(Sender: TObject);
    procedure edtIdVendedorExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    FEmissaoAntiga: TDateTime;
    procedure AlimentaLabelTotal;
    procedure CarregaNomeCliente;
    procedure CarregaNomeVendedor;
    procedure carregaNomeFPagamento;
  public
    { Public declarations }
    property EmissaoAntiga: TDateTime read FEmissaoAntiga write FEmissaoAntiga;
  end;

var
  frmAlteraVenda: TfrmAlteraVenda;

implementation

{$R *.dfm}

procedure TfrmAlteraVenda.AlimentaLabelTotal;
var
  lValorBrutoItens, lValorLiquido, lValorDesconto: Double;
begin
  lValorBrutoItens := 0;
  lValorLiquido := 0;
  lValorDesconto := 0;
  lValorBrutoItens := strtofloatdef(lblSubTotalNum.Caption, 0);
  lValorDesconto := strtofloatdef(edtValorAcrsDesc.Text, 0);

  case rdgAcrsDesc.ItemIndex of
    0: // Soma Por Zero
      begin
        lValorLiquido := lValorBrutoItens;
      end;
    1: // Acrescimo
      begin
        lValorLiquido := lValorBrutoItens + lValorDesconto;
      end;
    2: // Desconto
      begin
        lValorLiquido := lValorBrutoItens - lValorDesconto;
      end;
  end;

  lblAcrsDescNum.Caption := FormatFloat('#,##0.00', lValorDesconto);
  lblTotalNum.Caption := FormatFloat('#,##0.00', lValorLiquido);
end;

procedure TfrmAlteraVenda.btnExcluirClick(Sender: TObject);
begin
  if dtmconexao.tblConsultaItens.RecordCount > 0 then
  begin
    lblSubTotalNum.Caption := FormatFloat('#,##0.00',
      StrToFloat(lblSubTotalNum.Caption) -
      dtmconexao.tblConsultaItensTotal.AsFloat);
    dtmconexao.tblConsultaItens.Delete;

    AlimentaLabelTotal;
  end
  else
  begin
    ShowMessage('O carrinho de compras está vazio, não há o que ser removido.');
  end;
end;

procedure TfrmAlteraVenda.btnIncluirClick(Sender: TObject);
var
  lValor, lDesc, lQuant, lTotalItem, lSubTotal, lTotalF: Double;
  lFormulario: TfrmAlteraVendaItem;
begin
  lFormulario := TfrmAlteraVendaItem.Create(nil);
  try
    Confirma := false;
    lFormulario.ShowModal;

    if Confirma = true then
    begin
      lValor := StrToFloat(lFormulario.edtValor.Text);
      lDesc := StrToFloat(lFormulario.edtDesconto.Text);
      lQuant := StrToFloat(lFormulario.edtQuantidade.Text);

      lTotalItem := lQuant * lValor;

      if lDesc > 0 then
      begin
        lTotalItem := lTotalItem - (lDesc * (lTotalItem)) / 100;
      end;

      dtmconexao.tblConsultaItens.append;
      dtmconexao.tblConsultaItensFK_VENDA.AsInteger :=
        StrToInt(edtIdVenda.Text);
      dtmconexao.tblConsultaItensFK_PRODUTO.AsInteger :=
        StrToInt(lFormulario.edtIdProduto.Text);
      dtmconexao.tblConsultaItensDESCRICAO.AsString :=
        lFormulario.lblNomeProduto.Caption;
      dtmconexao.tblConsultaItensEMISSAO.AsDateTime := now;
      dtmconexao.tblConsultaItensVALOR.AsFloat := lValor;
      dtmconexao.tblConsultaItensDESCONTO.AsFloat := lDesc;
      dtmconexao.tblConsultaItensQUANTIDADE.AsFloat := lQuant;
      dtmconexao.tblConsultaItensTotal.AsFloat := lTotalItem;
      dtmconexao.tblConsultaItens.Post;

      lSubTotal := lSubTotal + lTotalItem;
      lblSubTotalNum.Caption := FormatFloat('#,##0.00',
        StrToFloat(lblSubTotalNum.Caption) + lTotalItem);
    end;
  finally
    AlimentaLabelTotal;
    lFormulario.Free;
  end;
end;

procedure TfrmAlteraVenda.btnBuscaFPagamentoClick(Sender: TObject);
var
  lFormulario: TfrmConsultaFPagamento;
  lFPagamento: TFPagamento;
begin
  lFormulario := TfrmConsultaFPagamento.Create(nil);
  lFPagamento := TFPagamento.Create;
  try
    lFormulario.btnIncluir.Visible := false;
    lFormulario.btnAlterar.Visible := false;
    lFormulario.btnExcluir.Visible := false;
    lFormulario.btnSair.Caption := 'Selecionar';
    lFormulario.ShowModal;

    edtIdFPagamento.Text := lFormulario.grdConsulta.DataSource.DataSet.
      FieldByName('ID').AsString;
    edtTipo.Text := lFormulario.grdConsulta.DataSource.DataSet.FieldByName
      ('TIPO').AsString;
    lblNomeFPagamento.Caption := lFormulario.grdConsulta.DataSource.DataSet.
      FieldByName('DESCRICAO').AsString;

  finally
    lFormulario.Free;
    lFPagamento.Free;
  end;
end;

procedure TfrmAlteraVenda.btnBuscaNomeClienteClick(Sender: TObject);
var
  lFormulario: TfrmConsultaCliente;
begin
  lFormulario := TfrmConsultaCliente.Create(nil);
  try
    lFormulario.btnIncluir.Visible := false;
    lFormulario.btnAlterar.Visible := false;
    lFormulario.btnExcluir.Visible := false;
    lFormulario.btnRelat.Visible := false;
    lFormulario.btnSair.Caption := 'Selecionar';
    lFormulario.ShowModal;
    edtIdCliente.Text := lFormulario.grdConsulta.DataSource.DataSet.FieldByName
      ('ID').AsString;
    lblNomeCliente.Caption := lFormulario.grdConsulta.DataSource.DataSet.
      FieldByName('NOME').AsString;
    edtIdVendedor.SetFocus;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmAlteraVenda.btnBuscaNomeVendedorClick(Sender: TObject);
var
  lFormulario: TfrmConsultaVendedor;
begin
  lFormulario := TfrmConsultaVendedor.Create(nil);
  try
    lFormulario.btnIncluir.Visible := false;
    lFormulario.btnAlterar.Visible := false;
    lFormulario.btnExcluir.Visible := false;
    lFormulario.btnRelat.Visible := false;
    lFormulario.btnSair.Caption := 'Selecionar';
    lFormulario.ShowModal;
    edtIdVendedor.Text := lFormulario.grdConsulta.DataSource.DataSet.FieldByName
      ('ID').AsString;
    lblNomeVendedor.Caption := lFormulario.grdConsulta.DataSource.DataSet.
      FieldByName('NOME').AsString;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmAlteraVenda.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmAlteraVenda.btnConfirmarClick(Sender: TObject);
var
  lVenda: TVenda;
  lItem: TItem;
begin

  if dtmconexao.tblConsultaItens.RecordCount > 0 then
  begin
    lVenda := TVenda.Create;
    lItem := TItem.Create;
    try

      lVenda.ID := StrToInt(edtIdVenda.Text);
      lVenda.Cliente.ID := StrToInt(edtIdCliente.Text);
      lVenda.Vendedor.ID := StrToInt(edtIdVendedor.Text);
      lVenda.FormaPagamento.ID := StrToInt(edtIdFPagamento.Text);
      lVenda.Emissao := FEmissaoAntiga;
      lVenda.DataVencimento := dtpvencimento.DateTime;
      lVenda.Desconto := StrToFloat(lblAcrsDescNum.Caption);
      lVenda.Total := StrToFloat(lblTotalNum.Caption);
      lVenda.Obs := memoObs.Text;

      lVenda.Alterar(true);

      lItem.Venda := StrToInt(edtIdVenda.Text);
      lItem.Excluir(true);

      dtmconexao.tblConsultaItens.First;
      while not(dtmconexao.tblConsultaItens.EOF) do
      begin

        lItem.Venda := StrToInt(edtIdVenda.Text);
        lItem.Produto.ID := dtmconexao.tblConsultaItensFK_PRODUTO.AsInteger;
        lItem.Emissao := dtmconexao.tblConsultaItensEMISSAO.AsDateTime;
        lItem.Quantidade := dtmconexao.tblConsultaItensQUANTIDADE.AsFloat;
        lItem.Valor := dtmconexao.tblConsultaItensVALOR.AsFloat;
        lItem.Desconto := dtmconexao.tblConsultaItensDESCONTO.AsFloat;

        lItem.Incluir(true);

        dtmconexao.tblConsultaItens.Next;
      end;

    finally
      lVenda.Free;
      lItem.Free;
      dtmconexao.tblConsultaItens.EmptyDataSet;
      close;
    end;
  end
  else
  begin
    ShowMessage('O carrinho deve ter ao menos um item incluso');
    btnIncluir.SetFocus;
  end;
end;

procedure TfrmAlteraVenda.CarregaNomeCliente;
begin
  if (edtIdCliente.Text <> EmptyStr) then
  begin
    if TCliente.Existe(StrToInt(edtIdCliente.Text)) then
    begin
      TCliente.Existe(StrToInt((edtIdCliente.Text)));
      lblNomeCliente.Caption := TCliente.ObjetoBusca.NOME;
    end
    else
    begin
      lblNomeCliente.Caption := '_______________';
      ShowMessage
        ('Esse Cliente não existe, por favor busque um existente pelo botao ao lado');
      edtIdCliente.SetFocus;
    end;
  end
  else
  begin
    lblNomeCliente.Caption := '_______________';
  end;
end;

procedure TfrmAlteraVenda.carregaNomeFPagamento;
begin
  if edtIdFPagamento.Text <> EmptyStr then
  begin
    if TFPagamento.Existe(StrToInt(edtIdFPagamento.Text)) then
    begin
      TFPagamento.Existe(StrToInt((edtIdFPagamento.Text)));
      lblNomeFPagamento.Caption := TFPagamento.ObjetoBusca.DESCRICAO;
      edtTipo.Text := TFPagamento.ObjetoBusca.TIPO;
    end
    else
    begin
      lblNomeFPagamento.Caption := '_______________';
      ShowMessage
        (' Formato de pagamento invalido, por favor busque um existente pelo botao ao lado');
      edtIdFPagamento.Text := '1';
    end;
  end
  else
  begin
    lblNomeFPagamento.Caption := '_______________';
  end;
end;

procedure TfrmAlteraVenda.CarregaNomeVendedor;
begin
  if edtIdVendedor.Text <> EmptyStr then
  begin
    if TVendedor.Existe(StrToInt(edtIdVendedor.Text)) then
    begin
      TVendedor.Existe(StrToInt((edtIdVendedor.Text)));
      lblNomeVendedor.Caption := TVendedor.ObjetoBusca.NOME;
      edtIdFPagamento.SetFocus;
    end
    else
    begin
      lblNomeVendedor.Caption := '_______________';
      ShowMessage
        ('Esse vendedor não existe, por favor busque um existente pelo botao ao lado');
      edtIdVendedor.SetFocus;
    end;
  end
  else
  begin
    lblNomeVendedor.Caption := '_______________';
  end;
end;

procedure TfrmAlteraVenda.edtIdClienteExit(Sender: TObject);
begin
  if not(btnBuscaNomeCliente.Focused) and not(btnCancelar.Focused) then
  begin
    CarregaNomeCliente;
  end;
end;

procedure TfrmAlteraVenda.edtIdFPagamentoExit(Sender: TObject);
begin
  if edtIdFPagamento.Text <> EmptyStr then
  begin
    if not(btnBuscaFPagamento.Focused) then
    begin
      carregaNomeFPagamento;
    end;
  end;
end;

procedure TfrmAlteraVenda.edtIdVendedorExit(Sender: TObject);
begin
  if not(btnBuscaNomeVendedor.Focused) and not(btnCancelar.Focused) then
  begin
    CarregaNomeVendedor;
  end;
end;

procedure TfrmAlteraVenda.edtPorcentualExit(Sender: TObject);
var
  lValor: Double;
begin
  if edtPorcentual.Text <> EmptyStr then
  begin
    if (TryStrToFloat(edtPorcentual.Text, lValor)) then
    begin
      case rdgAcrsDesc.ItemIndex of
        1:
          begin
            lValor := (StrToFloat(edtPorcentual.Text) *
              StrToFloat(lblSubTotalNum.Caption)) / 100;

            edtValorAcrsDesc.Text := FormatFloat('#,##0.00', lValor);
            AlimentaLabelTotal;
          end;
        2:
          begin
            if StrToFloat(edtPorcentual.Text) > 100 then
            begin
              ShowMessage('O valor passado não pode exceder o 100%.');
              edtPorcentual.Text := FormatFloat('#,##0.00%', 100);
              edtPorcentual.SetFocus;
            end
            else
            begin
              lValor := (StrToFloat(edtPorcentual.Text) *
                StrToFloat(lblSubTotalNum.Caption)) / 100;

              edtValorAcrsDesc.Text := FormatFloat('#,##0.00', lValor);
              AlimentaLabelTotal;
            end;
          end;
      end;

    end
    else
    begin
      ShowMessage('Número digitado não é um valor válido');
      edtValorAcrsDesc.Text := '0,00';
      edtPorcentual.SetFocus;
    end;
  end
  else
  begin
    edtPorcentual.Text := FormatFloat('#,##0.00%', 0);
  end;

end;

procedure TfrmAlteraVenda.edtTipoChange(Sender: TObject);
begin
  if edtTipo.Text = 'A' then
  begin
    dtpvencimento.Enabled := false;
    dtpvencimento.DateTime := 0;
  end
  else
  begin
    dtpvencimento.Enabled := true;
    dtpvencimento.DateTime := now;
  end;
end;

procedure TfrmAlteraVenda.edtValorAcrsDescExit(Sender: TObject);
var
  lValor: Double;
begin
  if edtValorAcrsDesc.Text <> EmptyStr then
  begin
    if (TryStrToFloat(edtValorAcrsDesc.Text, lValor)) then
    begin
      case rdgAcrsDesc.ItemIndex of
        1:
          begin
            lValor := (StrToFloat(edtValorAcrsDesc.Text) /
              StrToFloat(lblSubTotalNum.Caption)) * 100;

            edtPorcentual.Text := FormatFloat('#,##0.00%', lValor);
            AlimentaLabelTotal;
          end;
        2:
          begin
            if StrToFloat(edtValorAcrsDesc.Text) >
              StrToFloat(lblSubTotalNum.Caption) then
            begin
              ShowMessage
                ('O valor passado não pode exceder o Total Brudo do carrinho.');
              edtValorAcrsDesc.Text := lblSubTotalNum.Caption;
              edtValorAcrsDesc.SetFocus;
            end
            else
            begin
              lValor := (StrToFloat(edtValorAcrsDesc.Text) /
                StrToFloat(lblSubTotalNum.Caption)) * 100;

              edtPorcentual.Text := FormatFloat('#,##0.00%', lValor);
              AlimentaLabelTotal;
            end;
          end;
      end;
    end
    else
    begin
      ShowMessage('Número digitado não é um valor válido');
      edtValorAcrsDesc.Text := '0,00';
      edtValorAcrsDesc.SetFocus;
    end;
  end
  else
  begin
    edtValorAcrsDesc.Text := '0,00';
  end;

end;

procedure TfrmAlteraVenda.gridItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    gridItens.Canvas.brush.Color := clTeal;
    gridItens.Canvas.font.Color := clwhite;
  end;
  gridItens.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmAlteraVenda.rdgAcrsDescClick(Sender: TObject);
begin
  case rdgAcrsDesc.ItemIndex of
    0:
      begin
        edtPorcentual.Enabled := false;
        edtValorAcrsDesc.Enabled := false;
        edtPorcentual.Text := FormatFloat('#,##0.00%', 0);
        edtValorAcrsDesc.Text := '0,00';
        AlimentaLabelTotal;
      end;
    1:
      begin
        edtPorcentual.Enabled := true;
        edtValorAcrsDesc.Enabled := true;
        edtPorcentual.Text := FormatFloat('#,##0.00%', 0);
        edtValorAcrsDesc.Text := '0,00';
        AlimentaLabelTotal;
      end;
    2:
      begin
        edtPorcentual.Enabled := true;
        edtValorAcrsDesc.Enabled := true;
        edtPorcentual.Text := FormatFloat('#,##0.00%', 0);
        edtValorAcrsDesc.Text := '0,00';
        AlimentaLabelTotal;
      end;
  end;
end;

end.
