unit fAlteraVendaItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, dConexao,
  uProduto, fConsultaProduto, System.ImageList, Vcl.ImgList;

type
  TfrmAlteraVendaItem = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    pnlItens: TPanel;
    lblProduto: TLabel;
    lblNomeProduto: TLabel;
    lblQuantidade: TLabel;
    lblValor: TLabel;
    lblTotal: TLabel;
    lblDesconto: TLabel;
    edtValor: TEdit;
    btnIdProduto: TButton;
    edtIdProduto: TEdit;
    edtTotal: TEdit;
    edtDesconto: TEdit;
    edtQuantidade: TEdit;
    btnConfirmaProduto: TButton;
    btnCancelar: TButton;
    ImgButtons: TImageList;
    procedure btnIdProdutoClick(Sender: TObject);
    procedure edtIdProdutoExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmaProdutoClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure edtDescontoExit(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaPropriedadesProduto;
    procedure CalculaTotalItem;
    procedure ValidaCampos;
  public
    { Public declarations }
    procedure LimparCamposProdutos;
  end;

var
  frmAlteraVendaItem: TfrmAlteraVendaItem;
  Confirma: boolean;

implementation

{$R *.dfm}
{ TfrmAlteraVendaItem }

procedure TfrmAlteraVendaItem.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmAlteraVendaItem.btnConfirmaProdutoClick(Sender: TObject);
begin
  if edtIdProduto.text <> emptystr then
  begin
    if edtQuantidade.text <> emptystr then
    begin
      Confirma := true;
      close;
    end
    else
    begin
      ShowMessage('Todos os Campos devem estar preenchidos para prosseguir');
    end;
  end
  else
  begin
    ShowMessage('É preciso escolher um produto para prosseguir');
  end;

end;

procedure TfrmAlteraVendaItem.btnIdProdutoClick(Sender: TObject);
var
  Valor: Double;
  lFormulario: TfrmConsultaProduto;
  lProduto: TProduto;
begin
  lFormulario := TfrmConsultaProduto.Create(nil);
  lProduto := TProduto.Create;
  try
    lFormulario.btnIncluir.Visible := false;
    lFormulario.btnAlterar.Visible := false;
    lFormulario.btnExcluir.Visible := false;
    lFormulario.btnRelat.Visible := false;
    lFormulario.btnSair.Caption := 'Selecionar';
    lFormulario.ShowModal;
    edtIdProduto.text := lFormulario.grdConsulta.DataSource.DataSet.FieldByName
      ('ID').AsString;
    lblNomeProduto.Caption := lFormulario.grdConsulta.DataSource.DataSet.
      FieldByName('DESCRICAO').AsString;
    Valor := lFormulario.grdConsulta.DataSource.DataSet.FieldByName
      ('PRECO').AsFloat;
    edtQuantidade.text := '1';
    edtDesconto.text := '0,00';

    edtValor.text := FormatFloat('#,##0.00', Valor);
    edtTotal.text := FormatFloat('#,##0.00', Valor);
    edtQuantidade.SetFocus;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmAlteraVendaItem.CalculaTotalItem;
var
  lQuantidade, lValor, lDesconto, lTotal: Double;
begin
  lQuantidade := strtofloatdef(edtQuantidade.text, 0);
  lValor := strtofloatdef(edtValor.text, 0);
  lDesconto := strtofloatdef(edtDesconto.text, 0);

  lTotal := lQuantidade * lValor;

  if lDesconto > 0 then
  begin
    lTotal := lTotal - (lDesconto * (lTotal)) / 100;
  end;

  edtTotal.text := FormatFloat('#,##0.00', lTotal);
end;

procedure TfrmAlteraVendaItem.CarregaPropriedadesProduto;
begin
  if edtIdProduto.text <> emptystr then
  begin
    if TProduto.Existe(strToInt(edtIdProduto.text)) then
    begin
      TProduto.Existe(strToInt((edtIdProduto.text)));
      lblNomeProduto.Caption := TProduto.ObjetoBusca.DESCRICAO;
      edtQuantidade.text := '1,00';
      edtDesconto.text := '0';
      edtValor.text := FormatFloat('#,##0.00', TProduto.ObjetoBusca.preco);
      edtTotal.text := FormatFloat('#,##0.00', TProduto.ObjetoBusca.preco);
    end
    else
    begin
      lblNomeProduto.Caption := '_______________';
      ShowMessage
        ('O produto não foi encontrado, por favor busque um existente pelo botao ao lado');
      LimparCamposProdutos;
      edtIdProduto.SetFocus;
    end;
  end
  else
  begin
    lblNomeProduto.Caption := '_______________';
  end;
end;

procedure TfrmAlteraVendaItem.edtIdProdutoExit(Sender: TObject);
begin
  if not(btnIdProduto.Focused) and not(btnCancelar.Focused) then
  begin
    CarregaPropriedadesProduto;
  end;
end;

procedure TfrmAlteraVendaItem.edtQuantidadeExit(Sender: TObject);
var
  lValor: Double;
begin
  CalculaTotalItem;
  lValor := 0;
  if edtQuantidade.text <> emptystr then
  begin
    if StrToFloat(edtQuantidade.text) < 0.5 then
    begin
     ShowMessage('A quantidade mínima é de 0.5');
    edtQuantidade.text := '0.50';
    end
    else
    begin
      if (TryStrToFloat(edtQuantidade.text, lValor)) then
      begin
        edtQuantidade.text := FormatFloat('#0.00', lValor);
      end
      else
      begin
        ShowMessage('Número digitado não é um valor válido.');
        edtQuantidade.clear;
        edtQuantidade.SetFocus;
      end;
    end;
  end
  else
  begin
    ShowMessage('Este campo deve ser preenchido');
    edtQuantidade.text := '0.50';
  end;
end;

procedure TfrmAlteraVendaItem.edtValorExit(Sender: TObject);
var
  lValor: Double;
begin
  CalculaTotalItem;
  lValor := 0;
  if edtValor.text <> emptystr then
  begin
    if (TryStrToFloat(edtValor.text, lValor)) then
    begin
      edtValor.text := FormatFloat('#0.00', lValor);
    end
    else
    begin
      ShowMessage('Número digitado não é um valor válido.');
      edtValor.clear;
      edtValor.SetFocus;
    end;
  end
  else
  begin
    ShowMessage('Este campo deve ser preenchido');
    edtValor.text := '0.00';
  end;
end;

procedure TfrmAlteraVendaItem.edtDescontoExit(Sender: TObject);
var
  lValor: Double;
begin
  CalculaTotalItem;
  lValor := 0;
  if edtDesconto.text <> emptystr then
  begin
    if (TryStrToFloat(edtDesconto.text, lValor)) then
    begin
      edtDesconto.text := FormatFloat('#0.00', lValor);
    end
    else
    begin
      ShowMessage('Número digitado não é um valor válido.');
      edtDesconto.clear;
      edtDesconto.SetFocus;
    end;
  end
  else
  begin
    ShowMessage('Este campo deve ser preenchido');
    edtDesconto.text := '0.00';
  end;
end;

procedure TfrmAlteraVendaItem.LimparCamposProdutos;
begin
  edtIdProduto.clear;
  lblNomeProduto.Caption := emptystr;
  edtValor.clear;
  edtDesconto.clear;
  edtQuantidade.clear;
  edtTotal.clear;
  lblNomeProduto.Caption := '_______________';
  edtIdProduto.SetFocus;
end;

procedure TfrmAlteraVendaItem.ValidaCampos;
begin
  edtQuantidade.text;
  edtValor.text;
  edtDesconto.text;
end;

end.
