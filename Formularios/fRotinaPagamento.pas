unit fRotinaPagamento;

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
  Vcl.ComCtrls,
  fConsultaFPagamento,
  uFPagamento,
  System.ImageList,
  Vcl.ImgList;

type
  TfrmRotinaPagamento = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    edtFPagamento: TEdit;
    btnFPagamento: TButton;
    lblFormaDePagamento: TLabel;
    lblDataVencimento: TLabel;
    lblNomeFPagamento: TLabel;
    lblNotaTotal: TLabel;
    edtNotaTotal: TEdit;
    btnCancela: TButton;
    btnSalva: TButton;
    dtpVencimento: TDateTimePicker;
    edtTipo: TEdit;
    ImgButtons: TImageList;
    procedure btnFPagamentoClick(Sender: TObject);
    procedure edtFPagamentoExit(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCampos;
  public
    { Public declarations }
    procedure CarregaFPagamento;
  end;

var
  frmRotinaPagamento: TfrmRotinaPagamento;

implementation

{$R *.dfm}

procedure TfrmRotinaPagamento.LimparCampos;
begin
  edtFPagamento.clear;
  edtTipo.Text := EmptyStr;
  lblNomeFPagamento.Caption := '_______________';
  edtFPagamento.SetFocus;
end;

procedure TfrmRotinaPagamento.CarregaFPagamento;
begin
  if edtFPagamento.Text <> EmptyStr then
  begin
    if TFPagamento.Existe(StrToInt(edtFPagamento.Text)) then
    begin
      TFPagamento.Existe(StrToInt((edtFPagamento.Text)));
      lblNomeFPagamento.Caption := TFPagamento.ObjetoBusca.DESCRICAO;
      edtTipo.Text := TFPagamento.ObjetoBusca.TIPO;
    end
    else
    begin
      lblNomeFPagamento.Caption := '_______________';
      ShowMessage
        (' Formato de pagamento invalido, por favor busque um existente pelo botao ao lado');
      LimparCampos;
    end;
  end
  else
  begin
    lblNomeFPagamento.Caption := '_______________';
  end;
end;

procedure TfrmRotinaPagamento.btnCancelaClick(Sender: TObject);
begin
  edtFPagamento.Text := EmptyStr;
  close;
end;

procedure TfrmRotinaPagamento.btnFPagamentoClick(Sender: TObject);
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

    edtFPagamento.Text := lFormulario.grdConsulta.DataSource.DataSet.FieldByName
      ('ID').AsString;
    edtTipo.Text := lFormulario.grdConsulta.DataSource.DataSet.FieldByName
      ('TIPO').AsString;
    lblNomeFPagamento.Caption := lFormulario.grdConsulta.DataSource.DataSet.
      FieldByName('DESCRICAO').AsString;

  finally
    lFormulario.free;
    lFPagamento.free;
  end;
end;

procedure TfrmRotinaPagamento.edtFPagamentoExit(Sender: TObject);
begin
  if edtFPagamento.Text <> EmptyStr then
  begin
    if not(btnFPagamento.Focused) then
    begin
      CarregaFPagamento;
    end;
  end;
end;

procedure TfrmRotinaPagamento.edtTipoChange(Sender: TObject);
begin
  if edtTipo.Text = 'A' then
  begin
    dtpVencimento.Enabled := false;
    dtpVencimento.DateTime := 0;
  end
  else
  begin
    dtpVencimento.Enabled := true;
    dtpVencimento.DateTime := now;
  end;
end;

procedure TfrmRotinaPagamento.btnSalvaClick(Sender: TObject);
begin

  if Trim(edtFPagamento.Text) <> EmptyStr then
  begin
    if edtFPagamento.Text = '0' then
    begin
      ShowMessage('É preciso selecionar uma Forma de Pagamento valida.');
      edtFPagamento.SetFocus;
    end
    else
    begin
      if edtTipo.Text = 'A' then
      begin
        close;
      end
      else
      begin
        if (dtpVencimento.Date < now - 1) then
        begin
          ShowMessage('Data selecionada Invalida, selecine uma data atual.');
          dtpVencimento.SetFocus;
        end
        else
        begin
          close;
        end;
      end;
    end;
  end
  else
  begin
    ShowMessage('É preciso Digitar uma Forma de Pagamento');
    edtFPagamento.SetFocus;
  end;

end;

end.
