unit uItem;

interface

uses
  FireDAC.Comp.Client, dconexao, Vcl.Dialogs, System.SysUtils, Vcl.Controls,
  Vcl.Forms, uProduto;

type
  TItem = class
  private
    FID: integer;
    FEmissao: TDateTime;
    FProduto: TProduto;
    FVenda: integer;
    FValor: double;
    FDesconto: double;
    FQuantidade: double;
    class var FObjetoBusca: TItem;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);

    constructor Create;
    class property ObjetoBusca: TItem read FObjetoBusca write FObjetoBusca;
    class function GeraProximoID: integer; static;

    property ID: integer read FID write FID;
    property Emissao: TDateTime read FEmissao write FEmissao;
    property Venda: integer read FVenda write FVenda;
    property Produto: TProduto read FProduto write FProduto;
    property Valor: double read FValor write FValor;
    property Desconto: double read FDesconto write FDesconto;
    property Quantidade: double read FQuantidade write FQuantidade;
  end;

implementation

{ TClassDefault }

procedure TItem.Carrega;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' SELECT * FROM VENDA_ITEM ');
    lQuery.SQL.Add(' WHERE ID = :ID           ');
    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FProduto.ID := lQuery.FieldByName('FK_PRODUTO').AsInteger;
      FProduto.Carrega;

      FID := lQuery.ParamByName('ID').AsInteger;
      FEmissao := lQuery.FieldByName('EMISSAO').AsDateTime;
      FVenda := lQuery.FieldByName('FK_VENDA').AsInteger;
      FValor := lQuery.FieldByName('VALOR').AsInteger;
      FDesconto := lQuery.FieldByName('DESCONTO').AsInteger;
      FQuantidade := lQuery.FieldByName('QUANTIDADE').AsInteger;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TItem.GeraProximoID: integer;
var
  lQuery: TFDQuery;
begin
  // Criei Class Function para não precisar estanciar a classe.
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add
      (' select gen_id(gen_venda_item_id, 0) codigo from VENDA_ITEM ');
    lQuery.Open;

    result := lQuery.FieldByName('codigo').AsInteger + 1;

  finally
    lQuery.Free;
  end;
end;

procedure TItem.Incluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' INSERT INTO VENDA_ITEM (   ');
    lQuery.SQL.Add('  EMISSAO                   ');
    lQuery.SQL.Add(' ,FK_VENDA                  ');
    lQuery.SQL.Add(' ,FK_PRODUTO                ');
    lQuery.SQL.Add(' ,VALOR                     ');
    lQuery.SQL.Add(' ,DESCONTO                  ');
    lQuery.SQL.Add(' ,QUANTIDADE                ');
    lQuery.SQL.Add(' )VALUES (                  ');
    lQuery.SQL.Add('  :EMISSAO                  ');
    lQuery.SQL.Add(' ,:FK_VENDA                 ');
    lQuery.SQL.Add(' ,:FK_PRODUTO               ');
    lQuery.SQL.Add(' ,:VALOR                    ');
    lQuery.SQL.Add(' ,:DESCONTO                 ');
    lQuery.SQL.Add(' ,:QUANTIDADE               ');
    lQuery.SQL.Add(' )                          ');
    lQuery.ParamByName('EMISSAO').AsDateTime := FEmissao;
    lQuery.ParamByName('FK_VENDA').AsInteger := FVenda;
    lQuery.ParamByName('FK_PRODUTO').AsInteger := FProduto.ID;
    lQuery.ParamByName('VALOR').AsFloat := FValor;
    lQuery.ParamByName('DESCONTO').AsFloat := FDesconto;
    lQuery.ParamByName('QUANTIDADE').AsFloat := FQuantidade;
    lQuery.ExecSQL;

    if pEfetuarCommit then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TItem.Alterar(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' UPDATE VENDA_ITEM SET      ');
    lQuery.SQL.Add('  EMISSAO = :FEMISSAO       ');
    lQuery.SQL.Add(' ,FK_VENDA = :FK_VENDA      ');
    lQuery.SQL.Add(' ,FK_PRODUTO = :FK_PRODUTO  ');
    lQuery.SQL.Add(' ,VALOR = :VALOR            ');
    lQuery.SQL.Add(' ,DESCONTO = :DESCONTO      ');
    lQuery.SQL.Add(' ,QUANTIDADE = :QUANTIDADE  ');
    lQuery.SQL.Add(' WHERE ID = :ID             ');

    lQuery.ParamByName('EMISSAO').AsDateTime := FEmissao;
    lQuery.ParamByName('FK_VENDA').AsInteger := FVenda;
    lQuery.ParamByName('FK_PRODUTO').AsInteger := FProduto.ID;
    lQuery.ParamByName('VALOR').AsFloat := FValor;
    lQuery.ParamByName('DESCONTO').AsFloat := FDesconto;
    lQuery.ParamByName('QUANTIDADE').AsFloat := FQuantidade;
    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TItem.Excluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try

    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' DELETE FROM VENDA_ITEM     ');
    lQuery.SQL.Add(' WHERE FK_VENDA = :FK_VENDA ');
    lQuery.ParamByName('FK_VENDA').AsInteger := FVenda;
    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;

  except
    begin
      MessageDlg('Problema na Exclusão da Venda da O.S. ' +
        'Favor tentar mais tarde e conferir rotina !!!', mtError, [mbOK], 0);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TItem.Inicializar;
begin
  FID := 0;
  FEmissao := 0;
  FValor := 0;
  FDesconto := 0;
  FQuantidade := 0;
end;

constructor TItem.Create;
begin
  Inicializar;
  FProduto := TProduto.Create;
end;

destructor TItem.Destroy;
begin
  inherited;
  FProduto.Free;
end;

end.
