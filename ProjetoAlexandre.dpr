program ProjetoAlexandre;

uses
  midaslib,
  Vcl.Forms,
  fPrincipal in 'Formularios\fPrincipal.pas' {frmPrincipal},
  fCadastroCliente in 'Formularios\fCadastroCliente.pas' {frmCadastroCliente},
  fConsultaCliente in 'Formularios\fConsultaCliente.pas' {frmConsultaCliente},
  dConexao in 'DataModule\dConexao.pas' {dtmConexao: TDataModule},
  uCliente in 'Classes\uCliente.pas',
  uClasDefault in 'Classes\uClasDefault.pas',
  fCadastroDefault in 'Formularios\Default\fCadastroDefault.pas' {fmrCadastroDefault},
  fConsultaDefault in 'Formularios\Default\fConsultaDefault.pas' {frmConsultaDefault},
  fCadastroUsuario in 'Formularios\fCadastroUsuario.pas' {frmCadastroUsuario},
  fConsultaUsuario in 'Formularios\fConsultaUsuario.pas' {frmConsultaUsuario},
  uUsuario in 'Classes\uUsuario.pas',
  fConsultaProduto in 'Formularios\fConsultaProduto.pas' {frmConsultaProduto},
  uProduto in 'Classes\uProduto.pas',
  fCadastroProduto in 'Formularios\fCadastroProduto.pas' {frmCadastroProduto},
  fCadastroUnidade in 'Formularios\fCadastroUnidade.pas' {frmCadastroUnidade},
  fConsultaUnidade in 'Formularios\fConsultaUnidade.pas' {frmConsultaUnidade},
  uUnidade in 'Classes\uUnidade.pas',
  fCadastroFPagamento in 'Formularios\fCadastroFPagamento.pas' {frmCadastroFPagamento},
  fConsultaFPagamento in 'Formularios\fConsultaFPagamento.pas' {frmConsultaFPagamento},
  uFPagamento in 'Classes\uFPagamento.pas',
  uHelpersImagensBase64 in 'Classes\uHelpersImagensBase64.pas',
  uVendedor in 'Classes\uVendedor.pas',
  fCadastroVendedor in 'Formularios\fCadastroVendedor.pas' {frmCadastroVendedor},
  fConsultaVendedor in 'Formularios\fConsultaVendedor.pas' {frmConsultaVendedor},
  fLogin in 'Formularios\fLogin.pas' {frmLogin},
  fVendas in 'Formularios\fVendas.pas' {frmVendas},
  uVenda in 'Classes\uVenda.pas',
  uItem in 'Classes\uItem.pas',
  fConsultaVenda in 'Formularios\fConsultaVenda.pas' {frmConsultaVenda},
  fRotinaPagamento in 'Formularios\fRotinaPagamento.pas' {frmRotinaPagamento},
  fFiltroCliente in 'Relatorios\fFiltroCliente.pas' {frmFiltroCliente},
  uHelpersRLImagensBase64 in 'Classes\uHelpersRLImagensBase64.pas',
  fFiltroDefault in 'Relatorios\fFiltroDefault.pas' {frmFiltroDefault},
  fRelatorioCliente in 'Relatorios\fRelatorioCliente.pas' {frmRelatorioCliente},
  fRelatorioDefault in 'Relatorios\fRelatorioDefault.pas' {frmRelatorioDefault},
  fRelatorioUsuario in 'Relatorios\fRelatorioUsuario.pas' {frmRelatorioUsuario},
  fFiltroUsuario in 'Relatorios\fFiltroUsuario.pas' {frmFiltroUsuario},
  fRelatorioProduto in 'Relatorios\fRelatorioProduto.pas' {frmRelatorioProduto},
  fFiltroProduto in 'Relatorios\fFiltroProduto.pas' {frmFiltroProduto},
  fRelatorioVendedor in 'Relatorios\fRelatorioVendedor.pas' {frmRelatorioVendedor},
  fFiltroVendedor in 'Relatorios\fFiltroVendedor.pas' {frmFiltroVendedor},
  fFiltroFPagamento in 'Relatorios\fFiltroFPagamento.pas' {frmFiltroFPagamento},
  fRelatorioFPagamento in 'Relatorios\fRelatorioFPagamento.pas' {frmRelatorioFPagamento},
  fFiltroUnidade in 'Relatorios\fFiltroUnidade.pas' {frmFiltroUnidade},
  fRelatorioUnidade in 'Relatorios\fRelatorioUnidade.pas' {frmRelatorioUnidade},
  fFiltroVenda in 'Relatorios\fFiltroVenda.pas' {frmFiltroVenda},
  fRelatorioVenda in 'Relatorios\fRelatorioVenda.pas' {frmRelatorioVenda},
  uScript in 'Script\uScript.pas',
  uConfig in 'Classes\uConfig.pas',
  fConfig in 'Formularios\fConfig.pas' {frmConfig},
  fAlteraVenda in 'Formularios\fAlteraVenda.pas' {frmAlteraVenda},
  fAlteraVendaItem in 'Formularios\fAlteraVendaItem.pas' {frmAlteraVendaItem};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TdtmConexao, dtmConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmConfig, frmConfig);
  if dtmConexao.ConectaBanco then
  begin
    Application.Run;
  end;

end.
