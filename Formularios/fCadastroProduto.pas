unit fCadastroProduto;

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
  fCadastroDefault,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  uProduto,
  FireDAC.Comp.Client,
  dConexao,
  uHelpersImagensBase64;

type
  TfrmCadastroProduto = class(TfmrCadastroDefault)
    edtID: TEdit;
    lblID: TLabel;
    edtDescricao: TEdit;
    edtReferencia: TEdit;
    edtPreco: TEdit;
    edtCusto: TEdit;
    edtSaldo: TEdit;
    edtPeso: TEdit;
    lblReferencia: TLabel;
    lblDescricao: TLabel;
    lblPreco: TLabel;
    lblCusto: TLabel;
    lblSaldo: TLabel;
    lblPeso: TLabel;
    lblkUnidade: TLabel;
    cbxFkUnidade: TComboBox;
    pnlImagem: TPanel;
    imgProduto: TImage;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure edtPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCustoKeyPress(Sender: TObject; var Key: Char);
    procedure edtSaldoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesoExit(Sender: TObject);
    procedure edtPrecoExit(Sender: TObject);
    procedure edtCustoExit(Sender: TObject);
    procedure edtSaldoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    FNome: string;
    FId: integer;
    procedure IncluirProduto;
    procedure AlterarProduto;
    // function ConverteValor(EdtValor: string): Double;

  public
    { Public declarations }
    TipoRotina: String;
    procedure CarregaUnidadeComboBox;
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

{$R *.dfm}
{ TfmrCadastroProduto }

procedure TfrmCadastroProduto.CarregaUnidadeComboBox;
var
  lquery: Tfdquery;
begin
  lquery := Tfdquery.Create(nil);
  try
    cbxFkUnidade.Items.Clear; // limpa o cbx
    lquery.Connection := dtmConexao.FDConnection;
    // busca na tabela para carregar na query
    lquery.close;
    lquery.SQL.Clear;
    lquery.SQL.Add(' SELECT * FROM UNIDADE');
    lquery.Open;
    // qdo abre a sql , sempre estara no primeiro resgitro de acordo com order by
    // lquery.First; // inicia a partir do primeiro registro da Query

    // enquanto não chegar no ultimo registro na Query continua percorrendo ela
    while not lquery.Eof do
    begin
      FId := lquery.FieldByName('ID').AsInteger;
      FNome := lquery.FieldByName('DESCRICAO').AsString;
      cbxFkUnidade.Items.AddObject(FNome, TObject(FId));

      // passa para o proximo registro
      // evitando um loop eterno do while
      lquery.next;
    end;

    cbxFkUnidade.ItemIndex := 0; // SETO INDEX PRO PRIMEIRO REGISTRO

  finally
    lquery.Free;
  end;
end;

procedure TfrmCadastroProduto.FormCreate(Sender: TObject);
begin
  inherited;
  CarregaUnidadeComboBox;
end;

procedure TfrmCadastroProduto.IncluirProduto;
var
  lProduto: TProduto;
begin
  lProduto := TProduto.Create;
  try
    lProduto.IDUNIDADE :=
      integer(cbxFkUnidade.Items.Objects[cbxFkUnidade.ItemIndex]);
    lProduto.DESCRICAO := edtDescricao.Text;
    lProduto.REFERENCIA := edtReferencia.Text;
    lProduto.PRECO := StrToFloat(edtPreco.Text);
    lProduto.CUSTO := StrToFloat(edtCusto.Text);
    lProduto.SALDO := StrToFloat(edtSaldo.Text);
    lProduto.PESO := StrToFloat(edtPeso.Text);
    lProduto.FOTO := imgProduto.Base64;
    lProduto.Incluir(true);
  finally
    lProduto.Free;
  end;
end;

procedure TfrmCadastroProduto.AlterarProduto;
var
  lProduto: TProduto;
begin
  lProduto := TProduto.Create;
  try
    lProduto.ID := StrToInt(edtID.Text);
    lProduto.IDUNIDADE :=
      integer(cbxFkUnidade.Items.Objects[cbxFkUnidade.ItemIndex]);
    lProduto.DESCRICAO := edtDescricao.Text;
    lProduto.REFERENCIA := edtReferencia.Text;
    lProduto.PRECO := StrToFloat(edtPreco.Text);
    lProduto.CUSTO := StrToFloat(edtCusto.Text);
    lProduto.SALDO := StrToFloat(edtSaldo.Text);
    lProduto.PESO := StrToFloat(edtPeso.Text);
    lProduto.FOTO := imgProduto.Base64;
    lProduto.Alterar(true);
  finally
    lProduto.Free;
  end;

end;

procedure TfrmCadastroProduto.edtCustoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', ',', '.', #8]) then
    Key := #0;
  if Key in ['.'] then
    Key := #44;
end;

procedure TfrmCadastroProduto.edtCustoExit(Sender: TObject);
var
  lValor: Double;
begin
  lValor := 0;

  if edtPeso.Text <> emptystr then
  begin
    if (TryStrToFloat(edtPeso.Text, lValor)) then
    begin
      edtPeso.Text := FormatFloat('#0.00', lValor);
    end
    else
    begin
      ShowMessage('Número digitado não é um valor válido');
      edtPeso.Clear;
      edtPeso.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroProduto.edtPrecoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', ',', '.', #8]) then
    Key := #0;
  if Key in ['.'] then
    Key := #44;
end;

procedure TfrmCadastroProduto.edtPrecoExit(Sender: TObject);
var
  lValor: Double;
begin
  lValor := 0;
  if edtPreco.Text <> emptystr then
  begin
    if (TryStrToFloat(edtPreco.Text, lValor)) then
    begin
      edtPreco.Text := FormatFloat('#0.00', lValor);
    end
    else
    begin
      ShowMessage('Número digitado não é um valor válido');
      edtPreco.Clear;
      edtPreco.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroProduto.edtSaldoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', ',', '.', #8]) then
    Key := #0;
  if Key in ['.'] then
    Key := #44;
end;

procedure TfrmCadastroProduto.edtSaldoExit(Sender: TObject);
var
  lValor: Double;
begin
  lValor := 0;
  if edtPreco.Text <> emptystr then
  begin
    if (TryStrToFloat(edtPreco.Text, lValor)) then
    begin
      edtPreco.Text := FormatFloat('#0.00', lValor);
    end
    else
    begin
      ShowMessage('Número digitado não é um valor válido');
      edtPreco.Clear;
      edtPreco.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroProduto.edtPesoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', ',', '.', #8]) then
    Key := #0;
  if Key in ['.'] then
    Key := #44;
end;

procedure TfrmCadastroProduto.edtPesoExit(Sender: TObject);
var
  lValor: Double;
begin
  lValor := 0;
  if edtPeso.Text <> emptystr then
  begin
    if (TryStrToFloat(edtPeso.Text, lValor)) then
    begin
      edtPeso.Text := FormatFloat('#0.00', lValor);
    end
    else
    begin
      ShowMessage('Número digitado não é um valor válido');
      edtPeso.Clear;
      edtPeso.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroProduto.btnSalvarClick(Sender: TObject);
var
  lProduto: TProduto;
begin
  lProduto := TProduto.Create;
  try
    if trim(edtDescricao.Text) = emptystr then
    begin
      ShowMessage
        ('O Produto precisa de uma Descrição para a conclusão do cadastro.');
      edtDescricao.SetFocus;
    end
    else if trim(edtReferencia.Text) = emptystr then
    begin
      ShowMessage
        ('O Produto precisa de uma Referência para a conclusão do cadastro.');
      edtReferencia.SetFocus;
    end
    else if trim(edtCusto.Text) = emptystr then
    begin
      ShowMessage
        ('O Produto precisa de um Custo para a conclusão do cadastro.');
      edtCusto.SetFocus;
    end
    else if trim(edtPreco.Text) = emptystr then
    begin
      ShowMessage
        ('O Produto precisa de um Preço para a conclusão do cadastro.');
      edtPreco.SetFocus;
    end
    else if trim(edtSaldo.Text) = emptystr then
    begin
      ShowMessage
        ('O Produto precisa de um Saldo para a conclusão do cadastro.');
      edtSaldo.SetFocus;
    end
    else if trim(edtPeso.Text) = emptystr then
    begin
      ShowMessage('O Produto precisa de um Peso para a conclusão do cadastro.');
      edtPeso.SetFocus;
    end;
    if TipoRotina = 'Incluir' then
    begin
      IncluirProduto;
    end
    else if TipoRotina = 'Alterar' then
    begin
      AlterarProduto;
    end;
    close;
  finally
    lProduto.Free;
  end;
end;

procedure TfrmCadastroProduto.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroProduto.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;

  if TipoRotina = 'Incluir' then
  begin
    imgProduto.Popup;
    edtDescricao.SetFocus;
  end
  else if TipoRotina = 'Alterar' then
  begin
    imgProduto.Popup;
    edtDescricao.SetFocus;
  end
  else
  begin
    btnsair.SetFocus;
  end;
  imgProduto.Stretch := false;
  imgProduto.Proportional := false;
  imgProduto.Center := true;
end;

end.
