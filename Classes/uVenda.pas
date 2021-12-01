unit uVenda;

interface

uses
  FireDAC.Comp.Client,
  dconexao,
  Vcl.Dialogs,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  uCliente,
  uFPagamento,
  uVendedor,
  System.Generics.Collections,
  uItem;

type
  TVenda = class
  private
    FID: integer;
    FCliente: Tcliente;
    FVendedor: TVendedor;
    FFormaPagamento: TFPagamento;
    FEmissao: TDateTime;
    FDataVencimento: TDateTime;
    FDesconto: double;
    FTotal: double;
    FObs: String;

    FListaVendaItem: TObjectList<TItem>;

    class var FObjetoBusca: TVenda;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);
    procedure AdicionarVendaItem(pItem: TItem);

    constructor Create;
    class property ObjetoBusca: TVenda read FObjetoBusca write FObjetoBusca;
    class function GeraProximoID: integer;
    class function Existe(pId: integer): boolean;

    property ID: integer read FID write FID;
    property Cliente: Tcliente read FCliente write FCliente;
    property Vendedor: TVendedor read FVendedor write FVendedor;
    property FormaPagamento: TFPagamento read FFormaPagamento
      write FFormaPagamento;
    property Emissao: TDateTime read FEmissao write FEmissao;
    property DataVencimento: TDateTime read FDataVencimento
      write FDataVencimento;
    property Desconto: double read FDesconto write FDesconto;
    property Total: double read FTotal write FTotal;
    property Obs: String read FObs write FObs;

    property ListaVendaItem: TObjectList<TItem> read FListaVendaItem
      write FListaVendaItem;
  end;

implementation

{ TClassDefault }

procedure TVenda.Carrega;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' SELECT * FROM VENDA ');
    lQuery.SQL.Add(' WHERE ID = :ID        ');
    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FCliente.ID := lQuery.FieldByName('FK_CLIENTE').AsInteger;
      FCliente.Carrega;

      FVendedor.ID := lQuery.FieldByName('FK_VENDEDOR').AsInteger;
      FVendedor.Carrega;

      FFormaPagamento.ID := lQuery.FieldByName('FK_FORMAPAGAMENTO').AsInteger;
      FFormaPagamento.Carrega;

      FEmissao := lQuery.FieldByName('EMISSAO').AsDateTime;
      FDataVencimento := lQuery.FieldByName('DATA_VENCIMENTO').AsDateTime;
      FDesconto := lQuery.FieldByName('DESCONTO').AsFloat;
      FTotal := lQuery.FieldByName('TOTAL').AsFloat;
      FObs := lQuery.FieldByName('OBS').AsString;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TVenda.Existe(pId: integer): boolean;
var
  lQuery: TFDQuery;
begin
  result := false;
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.SQL.Add('SELECT * FROM VENDA WHERE ID = :ID');
    lQuery.ParamByName('ID').AsInteger := pId;
    lQuery.Open;

    if (lQuery.RecordCount > 0) then
    begin
      result := true;

      if not Assigned(FObjetoBusca) then
      begin
        FObjetoBusca := TVenda.Create;
      end;

      FObjetoBusca.FID := pId;
      FObjetoBusca.Carrega;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TVenda.GeraProximoID: integer;
var
  lQuery: TFDQuery;
begin
  // Criei Class Function para não precisar estanciar a classe.
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' select gen_id(gen_venda_id, 0) codigo from VENDA ');
    lQuery.Open;

    result := lQuery.FieldByName('codigo').AsInteger + 1;

  finally
    lQuery.Free;
  end;
end;

procedure TVenda.Incluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
  I: integer;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' INSERT INTO VENDA (   ');
    lQuery.SQL.Add('  FK_CLIENTE           ');
    lQuery.SQL.Add(' ,FK_VENDEDOR          ');
    lQuery.SQL.Add(' ,FK_FORMAPAGAMENTO    ');
    lQuery.SQL.Add(' ,EMISSAO              ');
    lQuery.SQL.Add(' ,DATA_VENCIMENTO      ');
    lQuery.SQL.Add(' ,DESCONTO             ');
    lQuery.SQL.Add(' ,TOTAL                ');
    lQuery.SQL.Add(' ,OBS                  ');

    lQuery.SQL.Add(' )VALUES (             ');
    lQuery.SQL.Add('  :FK_CLIENTE          ');
    lQuery.SQL.Add(' ,:FK_VENDEDOR         ');
    lQuery.SQL.Add(' ,:FK_FORMAPAGAMENTO   ');
    lQuery.SQL.Add(' ,:EMISSAO             ');
    lQuery.SQL.Add(' ,:DATA_VENCIMENTO      ');
    lQuery.SQL.Add(' ,:DESCONTO            ');
    lQuery.SQL.Add(' ,:TOTAL               ');
    lQuery.SQL.Add(' ,:OBS                 ');
    lQuery.SQL.Add(' )                     ');

    lQuery.ParamByName('FK_CLIENTE').AsInteger := FCliente.ID;
    lQuery.ParamByName('FK_VENDEDOR').AsInteger := FVendedor.ID;
    lQuery.ParamByName('FK_FORMAPAGAMENTO').AsInteger := FFormaPagamento.ID;
    lQuery.ParamByName('EMISSAO').AsDateTime := FEmissao;
    lQuery.ParamByName('DATA_VENCIMENTO').AsDateTime := FDataVencimento;
    lQuery.ParamByName('TOTAL').AsFloat := FTotal;
    lQuery.ParamByName('DESCONTO').AsFloat := FDesconto;
    lQuery.ParamByName('OBS').AsString := FObs;
    lQuery.ExecSQL;

    if FListaVendaItem.Count > 0 then
    begin
      for I := 0 to FListaVendaItem.Count - 1 do
      begin
        FListaVendaItem[I].Incluir(false);
      end;
    end;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TVenda.Alterar(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' UPDATE VENDA SET                        ');
    lQuery.SQL.Add('  FK_CLIENTE = :FK_CLIENTE               ');
    lQuery.SQL.Add(' ,FK_VENDEDOR = :FK_VENDEDOR             ');
    lQuery.SQL.Add(' ,FK_FORMAPAGAMENTO = :FK_FORMAPAGAMENTO ');
    lQuery.SQL.Add(' ,EMISSAO = :EMISSAO                     ');
    lQuery.SQL.Add(' ,DATA_VENCIMENTO = :DATA_VENCIMENTO     ');
    lQuery.SQL.Add(' ,DESCONTO = :DESCONTO                   ');
    lQuery.SQL.Add(' ,TOTAL = :TOTAL                         ');
    lQuery.SQL.Add(' ,OBS = :OBS                             ');

    lQuery.SQL.Add(' WHERE ID = :ID                          ');

    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.ParamByName('FK_CLIENTE').AsInteger := FCliente.ID;
    lQuery.ParamByName('FK_VENDEDOR').AsInteger := FVendedor.ID;
    lQuery.ParamByName('FK_FORMAPAGAMENTO').AsInteger := FFormaPagamento.ID;
    lQuery.ParamByName('EMISSAO').AsDateTime := FEmissao;
    lQuery.ParamByName('DATA_VENCIMENTO').AsDateTime := FDataVencimento;
    lQuery.ParamByName('TOTAL').AsFloat := FTotal;
    lQuery.ParamByName('DESCONTO').AsFloat := FDesconto;
    lQuery.ParamByName('OBS').AsString := FObs;

    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TVenda.Excluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    if (MessageDlg('Confirma a Exclusão da Venda: ' + FID.ToString + '?',
      mtInformation, [mbyes, mbno], 0) = mryes) then
    begin
      lQuery.Connection := dtmConexao.FDConnection;
      lQuery.Close;
      lQuery.SQL.Clear;
      lQuery.SQL.Add(' DELETE FROM VENDA    ');
      lQuery.SQL.Add(' WHERE ID = :ID       ');
      lQuery.ParamByName('ID').AsInteger := FID;
      lQuery.ExecSQL;

      if pEfetuarCommit = true then
      begin
        dtmConexao.FDConnection.Commit;
      end;
    end;
  except
    begin
      MessageDlg('Problema na Exclusão da Venda da O.S. ' +
        'Favor tentar mais tarde e conferir rotina !!!', mtError, [mbOK], 0);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TVenda.AdicionarVendaItem(pItem: TItem);
var
  I: integer;
begin
  FListaVendaItem.Add(TItem.Create);
  I := FListaVendaItem.Count - 1;
  FListaVendaItem[I].Venda := pItem.Venda;
  FListaVendaItem[I].Emissao := FEmissao;
  FListaVendaItem[I].Produto.ID := pItem.Produto.ID;
  FListaVendaItem[I].Valor := pItem.Valor;
  FListaVendaItem[I].Quantidade := pItem.Quantidade;
  FListaVendaItem[I].Desconto := pItem.Desconto;
end;

procedure TVenda.Inicializar;
begin
  FID := 0;
  FEmissao := 0;
  FDataVencimento := 0;
  FTotal := 0;
  FDesconto := 0;
  FObs := emptystr;
end;

constructor TVenda.Create;
begin
  Inicializar;
  FCliente := Tcliente.Create;
  FVendedor := TVendedor.Create;
  FFormaPagamento := TFPagamento.Create;
  FListaVendaItem := TObjectList<TItem>.Create;
end;

destructor TVenda.Destroy;
begin
  inherited;
  FCliente.Free;
  FVendedor.Free;
  FFormaPagamento.Free;
  FListaVendaItem.Free;
end;

end.
