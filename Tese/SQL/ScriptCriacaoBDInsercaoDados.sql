USE [master]
GO

CREATE DATABASE [dbDU]
GO

USE [dbDU]
GO

/****** Object:  Table [dbo].[F_TipoRequisito]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[F_TipoRequisito](
	[id_TipoRequisito] [int] NOT NULL,
	[TipoRequisito] [varchar](50) NOT NULL,
 CONSTRAINT [pk_FTipoRequisito] PRIMARY KEY CLUSTERED 
(
	[id_TipoRequisito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[F_Categoria]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[F_Categoria](
	[id_Categoria] [int] IDENTITY(1,1) NOT NULL,
	[Categoria] [varchar](50) NOT NULL,
	[Observacao] [varchar](500) NULL,
 CONSTRAINT [pk_FCategoria] PRIMARY KEY CLUSTERED 
(
	[id_Categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[F_Requisitos]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[F_Requisitos](
	[id_Requisito] [char](10) NOT NULL,
	[id_TipoRequisito] [int] NOT NULL,
	[id_Categoria] [int] NULL,
	[Descricao] [varchar](500) NOT NULL,
	[Detalhe] [varchar](1000) NULL,
	[Fonte] [varchar](100) NULL,
 CONSTRAINT [pk_FRequisitos] PRIMARY KEY CLUSTERED 
(
	[id_Requisito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  View [dbo].[vw_RequisitosF]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_RequisitosF]
as
select r.id_Requisito,tr.TipoRequisito, c.Categoria, r.Descricao, r.Detalhe, r.Fonte
from F_Requisitos r
left join F_TipoRequisito tr on tr.id_TipoRequisito = r.id_TipoRequisito
left join F_Categoria c on c.id_Categoria = r.id_Categoria
GO

/****** Object:  Table [dbo].[WCAG22_Principios]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WCAG22_Principios](
	[id_Principio] [int] NOT NULL,
	[Principio] [varchar](50) NOT NULL,
	[Descricao] [varchar](500) NULL,
	[Detalhe] [varchar](1000) NULL,
 CONSTRAINT [pk_WCAG22_Principios] PRIMARY KEY CLUSTERED 
(
	[id_Principio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[WCAG22_Diretrizes]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WCAG22_Diretrizes](
	[id_Diretriz] [int] IDENTITY(1,1) NOT NULL,
	[Diretriz] [varchar](50) NOT NULL,
	[Descricao] [varchar](500) NOT NULL,
 CONSTRAINT [pk_WCAG22Diretrizes] PRIMARY KEY CLUSTERED 
(
	[id_Diretriz] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[WCAG22_CriteriosSucesso]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WCAG22_CriteriosSucesso](
	[id_Criterio] [char](10) NOT NULL,
	[id_Principio] [int] NOT NULL,
	[id_Diretriz] [int] NULL,
	[nivel] [char](10) NULL,
	[Criterio] [varchar](100) NULL,
	[Descricao] [varchar](1000) NULL,
 CONSTRAINT [pk_WCAG22_CriteriosSucesso] PRIMARY KEY CLUSTERED 
(
	[id_Criterio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  View [dbo].[vw_WCAG22]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_WCAG22]
as
select cs.id_Criterio, p.Principio,  d.Diretriz,cs.nivel, cs.Criterio,cs.Descricao, 
p.Descricao as Descricao_Principio, p.Detalhe as Detalhe_Principio, d.Descricao as Descricao_Diretriz
from WCAG22_CriteriosSucesso cs
left join WCAG22_Principios p on cs.id_Principio = p.id_Principio
left join WCAG22_Diretrizes d on cs.id_Diretriz = d.id_Diretriz
GO

/****** Object:  Table [dbo].[GDAMA_Secoes]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GDAMA_Secoes](
	[id_Secao] [int] NOT NULL,
	[Descricao] [varchar](50) NOT NULL,
 CONSTRAINT [pkGDMA_Secoes] PRIMARY KEY CLUSTERED 
(
	[id_Secao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[GDAMA_Subcategorias]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GDAMA_Subcategorias](
	[id_SubCategoria] [int] NOT NULL,
	[Descricao] [varchar](50) NULL,
 CONSTRAINT [pk_GDAMA_Subcategoria] PRIMARY KEY CLUSTERED 
(
	[id_SubCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[GDAMA_Requisitos]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GDAMA_Requisitos](
	[id_Requisito] [char](10) NOT NULL,
	[TipoRequisito] [char](10) NOT NULL,
	[Descricao] [varchar](500) NOT NULL,
	[Detalhe] [varchar](1000) NOT NULL,
	[id_Secao] [int] NULL,
	[id_Subcategoria] [int] NULL,
 CONSTRAINT [pk_GDAMA_Requisitos] PRIMARY KEY CLUSTERED 
(
	[id_Requisito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  View [dbo].[vw_GDAMA]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_GDAMA]
as
select gr.id_Requisito, gs.Descricao as Secao,gsub.Descricao as SubCategoria, gr.TipoRequisito, gr.Descricao, gr.Detalhe
from GDAMA_Requisitos gr 
left join GDAMA_Secoes gs on gr.id_Secao = gs.id_Secao
left join GDAMA_Subcategorias gsub on gr.id_Subcategoria = gsub.id_SubCategoria
GO

/****** Object:  Table [dbo].[NBR_17060Categorias]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NBR_17060Categorias](
	[id_Categoria] [int] NOT NULL,
	[Categoria] [varchar](50) NULL,
 CONSTRAINT [pk_NBR17060Categorias] PRIMARY KEY CLUSTERED 
(
	[id_Categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NBR_17060]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NBR_17060](
	[id_requisito] [char](10) NOT NULL,
	[id_TipoRequisito] [int] NULL,
	[id_Categoria] [int] NULL,
	[Descricao] [varchar](500) NULL,
	[Detalhe] [varchar](1000) NULL,
 CONSTRAINT [pk_NBR_17060] PRIMARY KEY CLUSTERED 
(
	[id_requisito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  View [dbo].[vw_NBR17060]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_NBR17060] as
select nbr.id_requisito,c.Categoria,
       case id_TipoRequisito when 0 then 'Requisito' else 'Recomendacao' end as tipo,  nbr.Descricao, nbr.Detalhe
from NBR_17060 nbr
left join NBR_17060Categorias c on nbr.id_Categoria = c.id_Categoria
GO

/****** Object:  Table [dbo].[Geral]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Geral](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Origem] [char](10) NULL,
	[id_Origem] [char](10) NULL,
	[Tipo] [varchar](15) NULL,
	[Tipo_Uso] [varchar](50) NULL,
	[Tipo_Config] [varchar](50) NULL,
	[Descricao] [varchar](500) NULL,
	[Detalhe] [varchar](1000) NULL,
	[Fonte] [varchar](50) NULL,
	[Config_Usuario] [char](1) NULL,
 CONSTRAINT [pk_Geral] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NBR_17060_DesempFuncRequisitos]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NBR_17060_DesempFuncRequisitos](
	[id_Requisito] [char](10) NOT NULL,
	[id_DesempenhoFuncional] [int] NOT NULL,
 CONSTRAINT [pk_NBR_17060_DesempFuncRequisitos] PRIMARY KEY CLUSTERED 
(
	[id_Requisito] ASC,
	[id_DesempenhoFuncional] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NBR_17060DesempenhoFuncional]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NBR_17060DesempenhoFuncional](
	[id_DesempenhoFuncional] [int] NOT NULL,
	[Descricao] [varchar](50) NULL,
	[Detalhe] [varchar](1000) NULL,
 CONSTRAINT [pk_NBR_17060DesempenhoFuncional] PRIMARY KEY CLUSTERED 
(
	[id_DesempenhoFuncional] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[F_Requisitos]  WITH CHECK ADD  CONSTRAINT [fk_FRequisitosCategoria] FOREIGN KEY([id_Categoria])
REFERENCES [dbo].[F_Categoria] ([id_Categoria])
GO
ALTER TABLE [dbo].[F_Requisitos] CHECK CONSTRAINT [fk_FRequisitosCategoria]
GO
ALTER TABLE [dbo].[F_Requisitos]  WITH CHECK ADD  CONSTRAINT [fk_FRequisitosTipoRequisito] FOREIGN KEY([id_TipoRequisito])
REFERENCES [dbo].[F_TipoRequisito] ([id_TipoRequisito])
GO
ALTER TABLE [dbo].[F_Requisitos] CHECK CONSTRAINT [fk_FRequisitosTipoRequisito]
GO
ALTER TABLE [dbo].[GDAMA_Requisitos]  WITH CHECK ADD  CONSTRAINT [fk_Requisitos_Secoes] FOREIGN KEY([id_Secao])
REFERENCES [dbo].[GDAMA_Secoes] ([id_Secao])
GO
ALTER TABLE [dbo].[GDAMA_Requisitos] CHECK CONSTRAINT [fk_Requisitos_Secoes]
GO
ALTER TABLE [dbo].[GDAMA_Requisitos]  WITH CHECK ADD  CONSTRAINT [fk_Requisitos_SubCategorias] FOREIGN KEY([id_Subcategoria])
REFERENCES [dbo].[GDAMA_Subcategorias] ([id_SubCategoria])
GO
ALTER TABLE [dbo].[GDAMA_Requisitos] CHECK CONSTRAINT [fk_Requisitos_SubCategorias]
GO
ALTER TABLE [dbo].[NBR_17060]  WITH CHECK ADD  CONSTRAINT [fk_NBR_17060Categoria] FOREIGN KEY([id_Categoria])
REFERENCES [dbo].[NBR_17060Categorias] ([id_Categoria])
GO
ALTER TABLE [dbo].[NBR_17060] CHECK CONSTRAINT [fk_NBR_17060Categoria]
GO
ALTER TABLE [dbo].[NBR_17060_DesempFuncRequisitos]  WITH CHECK ADD  CONSTRAINT [fk_NBR_17060DesempDesemp] FOREIGN KEY([id_DesempenhoFuncional])
REFERENCES [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional])
GO
ALTER TABLE [dbo].[NBR_17060_DesempFuncRequisitos] CHECK CONSTRAINT [fk_NBR_17060DesempDesemp]
GO
ALTER TABLE [dbo].[NBR_17060_DesempFuncRequisitos]  WITH CHECK ADD  CONSTRAINT [fk_NBR_17060DesempRequisitoDesempenho] FOREIGN KEY([id_Requisito])
REFERENCES [dbo].[NBR_17060] ([id_requisito])
GO
ALTER TABLE [dbo].[NBR_17060_DesempFuncRequisitos] CHECK CONSTRAINT [fk_NBR_17060DesempRequisitoDesempenho]
GO
ALTER TABLE [dbo].[WCAG22_CriteriosSucesso]  WITH CHECK ADD  CONSTRAINT [fk_WCAG22_Criterios_Diretrizes] FOREIGN KEY([id_Diretriz])
REFERENCES [dbo].[WCAG22_Diretrizes] ([id_Diretriz])
GO
ALTER TABLE [dbo].[WCAG22_CriteriosSucesso] CHECK CONSTRAINT [fk_WCAG22_Criterios_Diretrizes]
GO
ALTER TABLE [dbo].[WCAG22_CriteriosSucesso]  WITH CHECK ADD  CONSTRAINT [fk_WCAG22_Criterios_Principios] FOREIGN KEY([id_Principio])
REFERENCES [dbo].[WCAG22_Principios] ([id_Principio])
GO
ALTER TABLE [dbo].[WCAG22_CriteriosSucesso] CHECK CONSTRAINT [fk_WCAG22_Criterios_Principios]
GO

/****** Object:  StoredProcedure [dbo].[usp_PesquisaTermo]    Script Date: 18/12/2025 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_PesquisaTermo] @busca varchar(30)
as
set @busca = ltrim(rtrim(@busca))
select * from Geral 
where detalhe like '%'+@busca+'%'
   or tipo_uso    like '%'+@busca+'%'
   or tipo_config like '%'+@busca+'%'
   or Descricao   like '%'+@busca+'%'
GO

 
USE [dbDU]
GO
INSERT [dbo].[F_TipoRequisito] ([id_TipoRequisito], [TipoRequisito]) VALUES (1, N'Ambiente')
INSERT [dbo].[F_TipoRequisito] ([id_TipoRequisito], [TipoRequisito]) VALUES (2, N'Gráficos')
INSERT [dbo].[F_TipoRequisito] ([id_TipoRequisito], [TipoRequisito]) VALUES (3, N'Sonoros')
INSERT [dbo].[F_TipoRequisito] ([id_TipoRequisito], [TipoRequisito]) VALUES (4, N'Entrada')
GO
SET IDENTITY_INSERT [dbo].[F_Categoria] ON 

INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (1, N'Aplicativo', N'usuário deve poder dentro do aplicativo')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (2, N'Zoom', N'usuário deve poder ativar o zoom e configurar suas seguintes propriedades')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (3, N'Textos e Fontes', N'usuário deve poder configurar as seguintes propriedades dos textos escritos')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (4, N'Cor da Tela', N'usuário deve poder configurar as seguintes propriedades de cores')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (5, N'Cursor', N'usuário deve poder utilizar o cursor e configurar as seguintes propriedades')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (6, N'Legendas em Vídeos', N'usuário deve poder utilizar a legenda nos vídeos quando disponível e configurar suas propriedades')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (7, N'Leitor de Tela', N'usuário deve poder ativar o leitor de tela e configurar suas seguintes propriedades')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (8, N'Leitura de Conteúdo', N'usuário deve poder escolher os seguintes conteúdos a serem lidos')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (9, N'Leitura durante digitação', N'usuário deve poder habilitar as seguintes funções de leitura durante a digitação')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (10, N'Toque na tela', N'usuário deve poder configurar as seguintes propriedades do toque na tela')
INSERT [dbo].[F_Categoria] ([id_Categoria], [Categoria], [Observacao]) VALUES (11, N'Estilo de Digitacao', N'usuário deve poder escolher o estilo de digitação a ser utilizado')
SET IDENTITY_INSERT [dbo].[F_Categoria] OFF
GO
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.1.1.    ', 1, 1, N'Usar ou ignorar o brilho automático', N'ajusta o brilho e o contraste da tela com base nos ajustes da luz ambiente', N'SO,23')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.1.2.    ', 1, 1, N'Reduzir o ponto branco na tela', N'reduz a intensidade das cores brilhantes', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.1.3.    ', 1, 1, N'Silenciar todos os efeitos sonoros', N'quando essa opção for selecionada, o celular não vai emitir nenhum efeito', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.1.4.    ', 1, 1, N'Reduzir animação das telas', N'reduz o movimento da interface do usuário', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.1.5.    ', 1, 1, N'Ouvir notificações', N'o leitor de tela vai falar quando uma notificação chegar', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.1.6.    ', 1, 1, N'Piscar o flash para alertas', N'o flash vai piscar quando chegar alguma mensagem ou ligação', N'SO,10')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.2.1.    ', 1, 2, N'Ativar o zoom', N'amplia a tela ou parte dela', N'SO,23')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.2.2.    ', 1, 2, N'Seguir o foco de seleção', N'essa opção faz com que o zoom amplie parte da tela em que alguma tarefa está sendo executada', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.2.3.    ', 1, 2, N'Exibição do controle do zoom em tela', N'o controle é uma alternativa para acesso rápido aos controles do zoom', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.2.4.    ', 1, 2, N'Visibilidade do controle do zoom', N'essa opção define o quão visível vai ficar o controle do zoom', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'1.2.5.    ', 1, 2, N'Janela de ampliação e ampliação máxima', N'define se a tela inteira será utilizada para visualizar o conteúdo ampliado ou se será utilizada uma janela para isso', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.1.1.    ', 2, 3, N'Fontes preferidas e seus estilos', N'escolher qual tema de fonte prefere', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.1.2.    ', 2, 3, N'Texto em negrito', N'deixar o texto do app em negrito', N'SO,DP')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.1.3.    ', 2, 3, N'Tamanho da fonte', N'escolher qual tamanho de fonte prefere', N'SO,4,DP')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.1.4.    ', 2, 3, N'Cor da fonte', N'escolher uma cor para o texto', N'4,DP')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.2.1.    ', 2, 4, N'Personalizar cor da tela', N'escolher a cor que deseja que a tela tenha', N'23,DP')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.2.2.    ', 2, 4, N'Inverter as cores da tela', N'inverter todas as cores da tela', N'SO,10')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.2.3.    ', 2, 4, N'Filtro da cor da tela', N'escolher o conjunto de cores que deseja que a película na tela tenha', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.2.4.    ', 2, 4, N'Intensidade e contraste da cor da tela', N'escolher a intensidade de tons da tela', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.3.1.    ', 2, 5, N'Modelo do cursor', N'deixa o contorno ao redor do item mais grosso para aumentar o destaque', N'SO,26')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.3.2.    ', 2, 5, N'Visualização do cursor', N'escolher a cor e transparência do contorno do cursor', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.4.1.    ', 2, 6, N'Fontes preferidas e seus estilos', N'escolher qual tipo de legenda prefere como texto contornado ou clássico', N'SO,23')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.4.2.    ', 2, 6, N'Tamanho da fonte', N'escolher qual o tamanho de fonte que a legenda deve ter', N'SO,23')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.4.3.    ', 2, 6, N'Cor e opacidade da fonte', N'escolher a cor que a legenda deve ter e o quão evidente ela vai estar na tela', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.4.4.    ', 2, 6, N'Cor de fundo e opacidade da caixa de legenda', N'escolher a cor de fundo da legenda e o quão evidente o contorno dela vai estar na tela', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'2.4.5.    ', 2, 6, N'Ativar a legenda de libras', N'o usuário deve poder ativar e utilizar a legenda em LIBRAS nos vídeos, quando disponível', N'DP')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.1.1.    ', 3, 7, N'Ativar o leitor de tela', N'escolher se deseja ativar o leitor de tela', N'SO,23')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.1.2.    ', 3, 7, N'Velocidade da fala', N'escolher a velocidade da fala do leitor de tela', N'SO,23')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.1.3.    ', 3, 7, N'timbre de fala', N'escolher o tom da fala do leitor de tela', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.2.1.    ', 3, 8, N'Conteúdo da tela', N'todo conteúdo da tela vai ser lido', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.2.2.    ', 3, 8, N'Pontuação', N'determinar como serão faladas as pontuações em texto', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.2.3.    ', 3, 8, N'Texto Selecionado', N'determina se o texto detectado automaticamente no item em foco deve ser falado', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.2.4.    ', 3, 8, N'Letras e palavras em maiúsculo', N'determina o que fazer ao encontrar letras maiúsculas em um texto', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.2.5.    ', 3, 8, N'Cabeçalhos de tabelas', N'ler o conteúdo do cabeçalho de uma tabela', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.2.6.    ', 3, 8, N'Números de linhas e colunas em tabelas', N'o leitor de tela vai indicar a quantidade de linhas e colunas', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.2.7.    ', 3, 8, N'Falar a palavra "emoji"', N'quando o leitor de tela encontrar um emoji no texto vai ser indicado', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.3.1.    ', 3, 9, N'Escolher modo de leitura ao digitar', N'falar letras e algarismos digitados, palavras normalmente ou por retorno fonético', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'3.3.2.    ', 3, 9, N'Falar palavras inteiras ao serem digitadas', N'o leitor de tela vai falar a palavra inteira quando terminar de ser digitada', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'4.1.1.    ', 4, 10, N'Ação a ser executada a cada tipo de movimento de toque', N'escolher qual ação: toque simples, toque com arraste, toque duplo, toque longo', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'4.1.2.    ', 4, 10, N'Intervalo de tempo de um toque', N'escolher qual o intervalo de tempo para um aplicativo reconhecer o toque', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'4.1.3.    ', 4, 10, N'Intervalo de duração de um toque longo', N'escolher qual o intervalo de tempo para um aplicativo reconhecer um toque longo', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'4.2.1.    ', 4, 11, N'Digitação por toque direto', N'a letra que o usuário tocar será a letra digitada', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'4.2.2.    ', 4, 11, N'Digitação com confirmação de voz', N'mova o dedo para esquerda ou direita no teclado. O aplicativo irá dizer por voz sobre qual letra seu dedo está e o usuário confirma com um ou dois toques se deseja digitá-la', N'SO')
INSERT [dbo].[F_Requisitos] ([id_Requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe], [Fonte]) VALUES (N'4.2.3.    ', 4, 11, N'Digitação datilográfica', N'o usuário seleciona tecla e, ao retirar o dedo da tecla, a letra é digitada', N'SO')
GO
INSERT [dbo].[GDAMA_Secoes] ([id_Secao], [Descricao]) VALUES (1, N'Interface')
INSERT [dbo].[GDAMA_Secoes] ([id_Secao], [Descricao]) VALUES (2, N'Interação')
INSERT [dbo].[GDAMA_Secoes] ([id_Secao], [Descricao]) VALUES (3, N'Navegação')
INSERT [dbo].[GDAMA_Secoes] ([id_Secao], [Descricao]) VALUES (4, N'Outros')
GO
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (1, N'Cor')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (2, N'Orientação da Tela')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (3, N'Leitura')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (4, N'Área de Toque')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (5, N'Organização')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (6, N'Padrão de Interface')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (7, N'Tempo de Interação')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (8, N'Ajuda')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (9, N'Teclado')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (10, N'Feedback')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (11, N'Atalho')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (12, N'Foco')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (13, N'Configuração')
INSERT [dbo].[GDAMA_Subcategorias] ([id_SubCategoria], [Descricao]) VALUES (14, N'Compatibilidade')
GO
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R01       ', N'desejável ', N'Os componentes e informações da interface devem contribuir diretamente para a funcionalidade da aplicação', N'Não utilizar componentes com propósito apenas estético pois isso aumenta a quantidade de informações para o usuário com deficiência visual memorizar quando explora e interage com a interface, aumentando a carga cognitiva.', 1, NULL)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R02       ', N'mandatório', N'Os componentes da interface devem ser entendidos sem a utilização de cores.', N'Não utilizar apenas cores para identificar ou indicar a funcionalidade de componentes. Tanto o entendimento quanto a interação de usuários, sobretudo com perda parcial da visão ou daltônicos, podem ser prejudicados. Exemplo: Verde para aceitar/entrar e vermelho para cancelar.', 1, 1)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R03       ', N'mandatório', N'Os componentes da interface devem utilizar cores com alto contraste em relação ao plano de fundo.', N'A falta de alto contraste entre os componentes pode fazer usuários com perda parcial da visão ignorá-los. O contraste pode ser verificado por várias ferramentas, como a
Accessibility Color Wheel.', 1, 1)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R04       ', N'desejável ', N'A interface sempre deve oferecer a opção para a orientação vertical da tela.', N'Usuários com deficiência visual utilizam o aparelho posicionado na vertical em uma das mãos e interagem com a outra. Desta forma, a melhor posição do telefone é na vertical e portanto os aplicativos devem oferecer essa opção.', 1, 2)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R05       ', N'mandatório', N'A aplicação deve notificar o usuário antes de alterar a orientação da tela, caso seja apropriado modificá-la.', N'Não informar a mudança na orientação da tela pode atrapalhar a interação, pois o usuário com deficiência visual precisará explorar a tela novamente por causa da mudança de posicionamento dos componentes. Além disso, há a possibilidade de acionar componentes erroneamente, o que pode causar até a perda de dados.', 1, 2)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R06       ', N'mandatório', N'A aplicação deve usar linguagem adequada ao contexto do usuário.', N'Não utilizar termos técnicos ou em outra língua, que não façam parte do conhecimento popular do público-alvo da aplicação.', 1, 3)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R07       ', N'mandatório', N'Todos os componentes da interface devem possuir rótulos.', N'Certifique-se que todos os elementos visuais (incluindo componentes não-textuais) da interface da aplicação estejam rotulados na implementação do código, para que os componentes sejam devidamente identificados pelo usuário com deficiência visual.
Exemplo: Ler "home_activity" ao invés do correto, "Tela inicial".', 1, 3)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R08       ', N'mandatório', N'Os rótulos devem descrever a funcionalidade ou significado e o estado dos componentes da interface de forma clara, sucinta e completa.', N'Garantir que a descrição de conteúdo legendado expresse de forma clara, sucinta e completa a funcionalidade ou significado dos elementos da tela. Ex.: "S-Planner – Agenda", "Botão Voltar", "Campo ‘Inserir seu nome‘".', 1, 3)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R09       ', N'mandatório', N'A aplicação deve fornecer as informações textuais ou numéricas contextualizadas para o conversor de texto para voz.', N'As leituras devem ser feitas levando em consideração o contexto da informação, conduzindo o usuário a assimilá-la, de forma fácil e rápida.
Exemplo: Para um número de telefone, ler os números um por vez e não por extenso - Ler Nove, Oito, Oito... ao invés de Novencentos e oitenta e oito milhões... para 988764000".', 1, 3)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R10       ', N'mandatório', N'Os componentes não-textuais devem ser nomeados de forma que sejam compreendidos independente do contexto.', N'Os componentes não-textuais aqui abordados são aqueles representados geralmente por alguma imagem característica, como um "+" para adicionar algo ou uma "casa" para indicar a tela inicial da aplicação. Caso o componente possua alguma especificidade, não indicá-la pode deixar o usuário confuso sobre a funcionalidade que representa.
Exemplo: Ao invés de "Botão Salvar", utilizar "Botão Salvar Usuário" (em uma tela de cadastro de usuário) e "Botão Salvar Cartão" (em uma tela de cadastro de cartão).', 1, 3)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R11       ', N'mandatório', N'O rótulo dos componentes com itens sequenciais e/ou paginados deve informar o intervalo que está sendo mostrado e o número total de itens.', N'Informar e identificar a ordenação das informações e componentes listados e/ou sequenciais, colabora para que o usuário não deixe de percebê-los durante a interação.
Exemplo: "Página 01 de 03", "Cinco itens listados", "Item 1 de 5".', 1, 3)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R12       ', N'mandatório', N'Todas as imagens e figuras da interface da aplicação devem possuir uma audiodescrição.', N'A audiodescrição é utilizada para descrever o conteúdo de uma imagem, como se fosse uma narração. Para isso, deve ser definido o texto que será lido pelo leitor de telas no código da aplicação.
Esse recurso só deve ser implementado para as imagens do próprio aplicativo, excluindo assim arquivos recebidos de outras aplicações.', 1, 3)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R13       ', N'mandatório', N'A área de toque dos componentes da interface deve ter tamanho e espaçamento que facilitem a interação do usuário.', N'Para garantir o equilíbrio entre densidade e usabilidade, a Google recomenda que componentes de toque devem ter no mínimo 48 x 48 dp (Density-independent Pixels - uma unidade abstrata baseada na densidade física da tela. Essas unidades são relativas à tela de 160 dpi). Na maioria dos casos, deve existir um espaçamento de pelo menos 8dp entre eles. Esses componentes devem ter um tamanho físico de aproximadamente 9mm, sendo que o tamanho recomendado em telas de toque é entre 7 e 10 mm.
(Métricas recomendadas pela Google)', 1, 4)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R14       ', N'desejável ', N'Os componentes da interface das funções mais importantes/utilizadas devem estar situados próximos das extremidades da tela.', N'Usuários com deficiência visual tendem a procurar botões nas extremidades da tela, em especial na área superior da interface.', 1, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R15       ', N'desejável ', N'Cada tela da interface deve conter a menor quantidade de componentes de interação possível.', N'Quanto mais componentes na tela, mais tempo de exploração será necessário para que o usuário com deficiência visual assimile a tela. Além disso, há o risco do usuário não perceber algum componente.', 1, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R16       ', N'desejável ', N'Listas suspensas devem estar situadas na metade superior da tela.', N'Quando a lista suspensa está localizada no fim da tela, nem todos os itens são exibidos. Além disso a "janela" aberta com os itens pode ficar muito pequena. Desta forma, a aplicação dos gestos necessários para acessá-los (rolar a tela e gesto tab) necessita de muita precisão, o que traz bastante dificuldade para pessoas que não enxergam.', 1, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R17       ', N'mandatório', N'Componentes de interação devem ter o espaçamento mínimo em relação à borda da tela.', N'Componentes localizados muito próximos aos limites da tela podem levar o usuário com deficiência visual a ter dificuldade de acessá-los, ou mesmo fazer com que toque erroneamente em outros componentes.
Exemplo: Posicionar determinado componente no limite inferior da tela pode fazer o usuário tocar involuntariamente nos botões físicos do dispositivo, executando ações não esperadas, como voltar para a tela anterior ao clicar no botão "Voltar".', 1, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R18       ', N'desejável ', N'Componentes de interação devem manter tamanhos similares na mesma tela.', N'Devido à exploração por toque, interfaces com componentes de tamanhos variados colaboram para que usuários com deficiência visual não percebam os menores, sobretudo quando entre componentes grandes.
No caso, usuários com perda parcial da visão, normalmente tocam em componentes grandes, que chamam mais sua atenção em detrimento dos menores.', 1, 4)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R19       ', N'desejável ', N'A interface da aplicação com grande quantidade de informações deve ser estruturada em forma de lista ordenada.', N'ara facilitar a exploração dos itens deve ser usado um critério de ordenação para apresentação dos dados que melhor se adeque ao contexto da tela.
Exemplo: Ordem alfabética, númerica, crescente/decrescente, recente/antigo, etc.', 1, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R20       ', N'desejável ', N'Componentes de formulários devem ser distribuídos um item por linha, evitando o uso de múltiplas colunas numa mesma linha.', N'Usuários com deficiência visual, sobretudo com perda total da visão, que exploram a tela deslizando o dedo (varrendo a tela) costumam fazê-lo de cima para baixo, em linha reta. Desse modo, se uma linha tiver mais de um componente, pode ser que o usuário não identifique um deles.', 1, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R21       ', N'mandatório', N'A barra de ferramentas deve permanecer fixa em telas de rolagem.', N'Usuários com deficiência visual se valem da memória para localizar componentes. Logo ocultar a barra durante a interação pode deixá-lo confuso sobre a estrutura da tela.', 1, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R22       ', N'desejável ', N'Componentes com textos devem ser curtos e concisos, sempre que possível.', N'A escuta de textos longos é cansativa para os usuários com deficiência visual. Por isso, aplicações que precisam oferecer algum texto longo, devem ter ele dividido em blocos, de modo que o usuário possa lê-lo por partes e, da mesma forma, recomeçar a leitura sem que seja do início.', 1, 3)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R23       ', N'desejável ', N'As telas da aplicação devem seguir a mesma identidade visual e manter o mesmo padrão de layout.', N'Manter a mesma identidade visual ao longo de toda a aplicação faz com que a aplicação seja previsível, facilitando o aprendizado do usuário.', 1, 6)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R24       ', N'mandatório', N'A localização dos componentes deve seguir padrões amplamente utilizados.', N'O uso de padrões ajuda os usuários com deficiência visual a localizarem os componentes reduzindo assim a carga de memorização durante a exploração, bem como acelerando o aprendizado e a interação do usuário com a aplicação.
Exemplo: botão "Salvar" no canto superior direito.', 1, 6)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R25       ', N'mandatório', N'Os componentes de formulários devem seguir o mesmo padrão.', N'A aplicação deve manter um padrão de apresentação entre o label e o componente a ser preenchido, selecionado ou marcado. O mais comum para usuários com deficiência visual é primeiro o label e logo abaixo o componente referenciado por ele.', 1, 6)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R26       ', N'desejável ', N'A aplicação deve manter a tela ativa por tempo ilimitado quando o leitor de tela estiver ativo.', N'Manter a tela ativa facilita a interação do deficiente visual com funcionalidades que exigem um tempo de leitura maior, como execução de videos e/ou apresentação de textos longos.', 2, 7)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R27       ', N'desejável ', N'A aplicação deve oferecer recursos que reduzam o esforço do usuário.', N'Como por exemplo, a função autocomplete, utilizar comandos de voz e busca por voz.', 2, 8)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R28       ', N'mandatório', N'O teclado utilizado pela aplicação deve ser compatível com o contexto do campo.', N'A depender do tipo de dado a ser preenchido, a aplicação deve oferecer o teclado mais adequado.
Exemplo: Em campos em que o valor a ser inserido seja um email, oferecer um teclado com as teclas arroba (@) e ".com".', 2, 9)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R29       ', N'mandatório', N'O teclado utilizado pela aplicação deve conter teclas que permitam a navegação entre os componentes da interface.', N'presentar no teclado o botão de navegação entre os campos de um formulário facilita a navegação entre eles, e consequentemente o preenchimento dos campos.
Exemplo: inserir botão "Prox." quando o próximo campo é de entrada de dados.', 2, 9)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R30       ', N'desejável ', N'Componentes de interação devem se manter na tela independente da funcionalidade que estiver em uso.', N'Esconder componentes, principalmente em funcionalidades que não necessitam uma interação ativa do usuário com deficiência visual, como a execução de videos ou apresentação de textos longos, pode deixá-lo confuso sobre a estrutura da tela. Além disso uma nova exploração da tela será necessária para encontrar os componentes.', 2, 7)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R31       ', N'mandatório', N'O leitor de telas deve informar ao usuário todos os eventos visíveis.', N'Usuários com perda parcial da visão normalmente se utilizam do resquício de visão que possuem para interagir com aplicativos. Por isso, é necessário que mesmo com o uso de leitor de telas, haja estímulos visuais sobre o que estiver ocorrendo na aplicação.
Exemplo: O usuário deve ser informado sobre a conclusão correta do preenchimento de um formulário.', 2, 10)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R32       ', N'mandatório', N'O leitor de telas deve informar o conteúdo de um componente assim que tocado, interrompendo qualquer leitura em andamento.', N'Deslizar o dedo na tela é uma das formas mais comuns de explorar a interface. Dessa forma, quando a leitura de um componente é interrompida, significa que o usuário está tocando outro componente. Caso a leitura não seja interrompida, o usuário concluirá que a tela não tem outros componentes tocáveis. Isso pode fazer com que componentes importantes na tela não sejam notados.', 2, 10)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R33       ', N'mandatório', N'A aplicação deve fornecer feedback sonoro sobre todas as ações executadas pelo usuário', N'É necessário informar o resultado das ações do usuário para que ele não tente executá-la novamente sem necessidade. Esses feedbacks também podem ser realizados através de sons característicos de algumas operações, por exemplo, para indicar uma confirmação.', 2, 10)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R34       ', N'mandatório', N'A aplicação deve fornecer feedback visual sobre todas as ações executadas pelo usuário.', N'Usuários com perda parcial da visão devem ser informados visualmente do resultado das ações que realiza.', 2, 10)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R35       ', N'mandatório', N'As telas da aplicação, exceto popups (pequenas janelas que se abrem por cima da tela sendo visualizada), devem disponibilizar link para a tela principal do aplicativo.', N'Buscar a tela inicial da aplicação é um comportamento comum para usuários com deficiência visual quando se deparam com situações adversas durante a interação, como quando perdem a referência de qual tela da aplicação está sendo mostrada.
Normalmente esse link pode estar representado por um botão "Home", ou mesmo dentro de um menu de gaveta (ou sanduíche).', 3, 11)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R36       ', N'mandatório', N'As telas da aplicação devem disponibilizar o botão "Voltar" para a tela anteriormente acessada pelo usuário.', N'O botão "Voltar" é muito utilizado por usuários com deficiência visual quando possuem alguma dificuldade na interação com a aplicação. Ele é utilizado para que o usuário volte até uma tela que conhece, ou mesmo para cancelar uma ação para fazê-la novamente.', 3, 11)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R37       ', N'desejável ', N'As telas da aplicação devem oferecer atalhos para suas principais funcionalidades.', N'Usuários com deficiência visual podem ter dificuldades para encontrar os componentes referentes às funcionalidades principais da aplicação. Sendo assim, uma das formas de minimizar esse problema é disponibilizar atalhos para as funcionalidades que se espera que sejam mais utilizadas.
Exemplo: FAB, menu.', 3, 11)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R38       ', N'mandatório', N'A aplicação deve oferecer uma navegação sequencial entre as telas.', N'Plataformas móveis, como o Android, utilizam o desempilhamento de telas. Contudo, para pessoas que não enxergam, é necessário que a aplicação utilize o desempilhamento "semântico", onde a pilha é limpa quando o usuário chega à tela inicial. Caso contrário, o usuário deixa de ter esse referencial, podendo ficar confuso.
Exemplo: Navegando pelo aplicativo o usuário pode passar algumas vezes pela tela inicial. Utilizando o botão "Voltar", o aplicativo só deve permitir que o usuário volte até a tela inicial, não antes dela.', 3, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R39       ', N'mandatório', N'A aplicação deve suportar a navegação baseada em foco.', N'Para explorar a tela, é comum que usuários com deficiência visual utilizem o gesto "tab". Desta forma, a aplicação deve garantir que todos os componentes possam receber o foco, bem como que a ordem dele seja de cima para baixo e da esquerda para a direita.', 3, 12)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R40       ', N'mandatório', N'A aplicação deve informar possíveis erros de interação ao usuário.', N'A aplicação deve informar erros ocorridos durante a interação, evitando repetições, frustrações ou mesmo a desistência do uso decorrente de não entender o que está ocorrendo com a aplicação.
Exemplo: Quando o usuário salvar um formulário de cadastro com campo obrigatório não preenchido, informá-lo da ação. Assim que o usuário confirmar que visualizou a notificação do erro, alterar o foco para o campo que está faltando.', 3, 10)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R41       ', N'mandatório', N'A aplicação deve guiar o usuário no primeiro uso.', N'Realizar um tutorial a respeito da finalidade do aplicativo e suas principais funções durante o primeiro uso pode minimizar problemas de interação proporcionados.
No vídeo ao lado, o usuário nunca havia aberto o aplicativo Google Agenda em seu aparelho. Por isso, em seu primeiro uso, o aplicativo explica suas principais funções através de um tutorial dividido em 4 telas.', 3, 8)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R42       ', N'desejável ', N'As telas da aplicação devem disponibilizar a opção de ajuda referente ao seu conteúdo e funcionalidades.', N'Para evitar que usuários com deficiência visual desistam de utilizar a aplicação por não entendê-la ou não achar alguma funcionalidade, a aplicação deve diponibilizar, sempre que possível, um botão de ajuda que descreva as principais funções daquela interface.', 3, 8)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R43       ', N'desejável ', N'As telas da aplicação devem disponibilizar a opção de busca quando possuírem grande quantidade de informações.', N'A rolagem em telas com muitos itens pode ser extremamente desgastante. Logo, disponibilizar a opção de busca contribui com a redução de esforço do usuário.', 3, 8)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R44       ', N'mandatório', N'A aplicação deve fornecer instruções de preenchimento dos campos de entrada de dados.', N'A aplicação deve fornecer dicas de preenchimento dos campos para evitar que aumente a carga de interação do usuário com deficiencia visual devido a entrada de valores incorretos.', 3, 8)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R45       ', N'mandatório', N'A aplicação deve sugerir a ativação de configurações de acessibilidade dos dispositivos móveis ao usuário em seu primeiro acesso.', N'Há algumas particularidades do público alvo que podem ser atendidas com a ativação de opções de acessibilidade além do leitor de telas.
Exemplo: Quando a aplicação possuir plano de fundo branco (ou de tons claros), sugerir a ativação da opção de acessibilidade "Cores negativas", para contemplar usuários com fotofobia.', 4, 13)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R46       ', N'mandatório', N'A aplicação deve permitir que o usuário configure suas formas de notificação.', N'Notificações constantes durante a interação tendem a desviar a atenção do usuário com deficiência ao ter sua leitura se sobrepondo ao feedback em andamento. Logo, permitir que o usuário configure como será notificado evitará essa situação.', 4, 13)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R47       ', N'mandatório', N'Componentes de interação em telas com grandes textos devem estar fixos e visíveis.', N'Exemplo: Telas com textos longos que exijam confirmação para prosseguir, devem manter o componente da confirmação em um local fixo e de fácil acesso.', 2, 5)
INSERT [dbo].[GDAMA_Requisitos] ([id_Requisito], [TipoRequisito], [Descricao], [Detalhe], [id_Secao], [id_Subcategoria]) VALUES (N'R48       ', N'desejável ', N'A aplicação deve fornecer feedback sonoro quando o usuário tentar executar a rolagem em situações onde não é possível.', N'Para se certificar que passou por todo o conteúdo de uma tela, o usuário com perda total da visão costuma executar o gesto de rolar a tela. Desta forma, um feedback sonoro auxilia o usuário a entender melhor a interface.', 2, 10)
GO
INSERT [dbo].[NBR_17060Categorias] ([id_Categoria], [Categoria]) VALUES (1, N'Percepção e compreensão')
INSERT [dbo].[NBR_17060Categorias] ([id_Categoria], [Categoria]) VALUES (2, N'Controle e interação')
INSERT [dbo].[NBR_17060Categorias] ([id_Categoria], [Categoria]) VALUES (3, N'Mídia')
INSERT [dbo].[NBR_17060Categorias] ([id_Categoria], [Categoria]) VALUES (4, N'Requisitos para codificação')
GO
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.1   ', 0, 1, N'Requisitos para elementos não textuais', N'Elementos não textuais devem ter um texto alternativo que descreva o seu significado.
Elementos não textuais, como imagens, cujo significado é essencial para a compreensão do que é exibido na tela, devem ter uma alternativa textual a ser interpretada por recursos de tecnologia assistiva. Elementos meramente decorativos devem ser ignorados por recursos de tecnologia assistiva.
EXEMPLO	Foto de um resgate em uma notícia descreve a cena exibida na imagem')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.10  ', 1, 1, N'Recomendações para posicionamento de elementos de interface', N'Recomenda-se que o posicionamento de elementos de interface siga padrões amplamente utilizados.
Priorizar o uso de padrões e convenções no posicionamento dos elementos de interface. Desta forma, as cargas cognitivas e de memorização requeridas do usuário são menores, facilitando o aprendizado e a interação, e diminuindo a ansiedade.
EXEMPLO Botões “enviar” e “cancelar” em um formulário seguem a ordem amplamente utilizada (primeiro o botao “enviar” e depois o botao “cancelar”) tanto para navegação visual quanto por recursos de tecnologia assistiva.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.11  ', 0, 1, N'Requisitos para rótulos de campos de formulário', N'Os rótulos de formulários devem ser posicionados adjacentemente ao seu respectivo campo. Em campos de formulário gerais, como os de entrada de textos e/ou números, o rótulo deve ser posicionado antes do campo, ou seja, à esquerda ou acima. Em formulários de botão de rádio (radio button) e caixas de marcação (checkboxes), os rótulos devem estar após as respectivas opções, à direita. A ordem destes itens no código deve coincidir com a ordem visual, para manter a experiência independentemente da forma de navegaçao do usuário. Esse tipo de posicionamento melhora a previsibilidade da leitura do formulário, usando visao e tecnologias assistivas, além de evitar desalinhamentos acidentais.
EXEMPLO	O rótulo “nome” vem antes do campo de formulário que requer esse dado do usuário.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.12  ', 1, 1, N'Recomendações para organização de componentes de formulários', N'Recomenda-se que os componentes de formulários sejam distribuídos um por linha na tela.
Evitar o uso de mais de um componente de formulário por linha em uma aplicação. Vários componentes agrupados em linha podem se desalinhar ou desaparecer da tela, podendo não ser perceptíveis ou operáveis pelo usuário, quando usados em um tamanho de tela diferente do projetado ou se for aplicado zoom.
EXEMPLO 1	Campo CEP vem abaixo do campo de endereço em um formulário.
EXEMPLO 2 Dois botões são apresentados na mesma linha e permanecem visíveis independentemente do tamanho da tela do dispositivo ou se o zoom for aplicado.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.13  ', 0, 1, N'Requisitos para determinação de tipo de campos de formulários', N'Os campos de formulários devem ter seu tipo determinado com base na necessidade de entrada.
Deve ser especificado o tipo de campo para a entrada de dados de acordo com a finalidade deste campo. Especificar o tipo de campo de formulário por meio de código de programaçao oferece uma experiência melhor para o usuário.
EXEMPLO 1 Declarar como campos numéricos permite que um teclado apenas numérico seja exibido para o preenchimento do usuário.
EXEMPLO 2	Em campos do tipo ‘e-mail’ o teclado exibirá o símbolo @ para facilitar o preenchimento.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.14  ', 0, 1, N'Requisitos para instruções de preenchimento de entrada de dados', N'Deve haver instruções de preenchimento de entrada de dados.
Campos de entrada de dados devem ter, além do seu rótulo, instruções de preenchimento relacionadas com o tipo de dados exigidos para entrada, de forma que o usuário possa perceber. Essa técnica é importante para evitar que o usuário cometa erros durante o preenchimento do formulário. Isto pode tomar forma como (mas não se limitando a) de “marcadores de posição” (placeholder), etiqueta, parágrafos ou instruções prévias. Na dúvida, deve-se ser redundante.
EXEMPLO Um campo de data exibe o formato exigido de entrada dia/mês/ano. ')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.15  ', 0, 1, N'Requisitos para indicar o foco de navegação', N'Deve haver indicador de foco de navegaçao.
Os aplicativos devem permitir que recursos de tecnologia assistiva que suportam indicador de loco visível em navegaçao sequencial, como leitores de tela, exibam esse indicador adequadamente.
EXEMPLO Uma pessoa com baixa visao, dislexia ou baixa alfabetização que utiliza um leitor de tela para navegar por um aplicativo consegue identificar visualmente em qual posiçao da tela o foco está.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.16  ', 0, 1, N'Requisitos para elementos de interface de itens em sequência', N'Os elementos de interface de itens em sequência ou que exigem paginação devem situar o usuário.
Deve ficar claro para o usuário a quantidade de etapas, o intervalo mostrado, o seu posicionamento atual e o número de itens totais quando uma açao exige interaçao em itens sequenciais.
EXEMPLO Um formulário dividido em três etapas (dados pessoais, endereço residencial e endereço comercial) exibe de forma clara ao usuário a etapa atual de preenchimento e quantas etapas restantes ele ainda tem.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.17  ', 0, 1, N'Requisitos para contraste de textos e elementos gráticos', N'Os textos e elementos gráficos devem ter contraste suficiente com seus respectivos planos de fundo.
Deve haver contraste mínimo entre os textos e seus respectivos planos de fundo. Também deve haver contraste mínimo entre os elementos gráficos relevantes e seus respectivos planos de fundo e/ou entornos. As taxas de contraste devem estar em conformidade minima com os critérios de sucesso nível AA do WCAG 2.1. Elementos interativos no estado desabilitado não precisam cumprir requisitos de contraste. Elementos gráficos meramente decorativos e logotipos também estão isentos.
EXEMPLO 1 Um fundo claro é escolhido para que as letras de cores escuras possam ser lidas na tela de uma aplicaçao.
EXEMPLO 2	Um botao tem bordas escuras em um plano de fundo claro, para que seja facilmente percebido. ')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.18  ', 0, 1, N'Requisitos para uso da cor', N'Qualquer elemento de interface do usuário que dependa de cor para a sua compreensão deve ter uma outra forma de compreensão que não dependa apenas da cor.
EXEMPLO 1 Botões de “cancelar” e “enviar” um formulário utilizam as cores vermelha e verde, mas também possuem um rótulo acessível.
EXEMPLO 2 Em uma lista de produtos, itens na cor vermelha são os que estão sem estoque e, além da cor, há também o texto “sem estoque”.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.19  ', 0, 1, N'Requisitos relacionados a características sensoriais do usuário', N'Não podem existir instruções que dependem somente das características sensoriais do usuário.
As instruções fornecidas para compreender e utilizar o conteúdo não podem depender somente das características sensoriais dos elementos de interface, como forma, cor, tamanho, localização visual, orientação ou som.
EXEMPLO  Um botão para enviar um formulário é destacado com a cor verde e possui o rótulo “enviar formulário”. Na aplicação, quando ele é mencionado, é referenciado como “botão enviar formulário”.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.2   ', 1, 1, N'Recomendação para textos em vez de imagens', N'Recomenda-se que sejam usados textos em vez de imagens.
Sempre que possível, os textos devem ser codificados como textos propriamente ditos, e não feitos na forma de imagem, pois o formato texto pode ter sua exibição e formatação ajustadas pelo usuário por meio de recursos variados.
Essa orientação não se aplica aos logotipos e a outras situações em que seja essencial usar imagens para atingir a apresentação visual pretendida.
EXEMPLO 1 Um banner de produtos tern uma foto em destaque e, na parte inferior, há um texto com o nome do produto. Esse texto não está embutido na imagem e pode ser selecionado ou customizado pelo usuário.
EXEMPLO 2 O cabeçalho de nível de uma tela está formatado como texto, de acordo com o desejado pela equipe que o desenvolveu, usando fonte, estilo, cor e tamanho suportados pela tecnologia.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.20  ', 0, 1, N'Requisitos para retorno (feedback) fornecido pela aplicação', N'Todo retorno (feedback) fornecido pela aplicação deve ser percebido por todos os usuários e por recursos de tecnologia assistiva.
Ações de interação do usuário, como o acionamento de botões e elementos interativos, devem fornecer um retorno (feedback) perceptível a todos os usuários. Esse retorno (feedback) pode ser visual, mas também deve oferecer alternativas para os usuários de tecnologia assistiva.
EXEMPLO Uma janela de alerta é exibida para o usuário com informações sobre um erro. Essa janela contém uma mensagem visual e também é lida por usuários de leitores de tela.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.21  ', 0, 1, N'Requisitos para saída ou retorno perceptível a todos os usuários', N'A aplicação deve fornecer uma forma de saída ou retorno perceptível a todos os usuários. O usuário deve ter formas de retornar ou voltar para as telas anteriores de forma intuitiva.
EXEMPLO 1	Um modal ou pop-up tem um botão em forma de X que é programaticamente perceptível, tern
um gesto associado e também o uso da tecla “esc” de um teclado, com a função fechar.
EXEMPLO 2 Uma página permite o uso do botão “voltar” do dispositivo ou disponibiliza um botão para voltar para a tela anterior.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.22  ', 1, 1, N'Recomendações para ações indisponíveis, inativas ou proibidas', N'Recomenda-se que todas as tentativas de ações indisponíveis, inativas ou proibidas tenham feedback
ou retorno percebido por todos os usuários e por recursos de tecnologia assistiva.
Alguns usuários podem não perceber quando chegaram ao final de uma tela de aplicação ou ao tentar acionar um botão inativo. Essa orientação tem como objetivo alertar o usuário de que a ação que ele está tentando executar não é possível naquele momento.
EXEMPLO O fim da barra de rolagem exibe uma mensagem ou sinal sonoro informando ao usuário que ele atingiu o final da página.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.23  ', 0, 1, N'Requisitos para título de páginas e aplicações', N'Em páginas web acessadas pelo navegador, isso geralmente é feito pelo elemento HTML <titIe>. Para o caso de aplicação web, híbrida ou nativa, deve-se seguir a documentação da tecnologia aplicada, sendo o nome dessa aplicação o suficiente para atender a esta orientação. Esta informação deve ser interpretada corretamente por tecnologias assistivas, como um leitor de tela, ao navegar entre diferentes abas de um navegador web ou aplicativos abertos simultaneamente no aparelho.
EXEMPLO 1 A página inicial de um jornal tem um título que a identifica. O usuário está com várias abas abertas simultaneamente no seu navegador e consegue localizar entre elas qual é a aba do jornal, optando por abri-la.
EXEMPLO 2 Quando o usuário toca em um ícone de calculadora com o leitor de tela ligado, é informado o nome do aplicativo ao acessá-lo.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.24  ', 0, 1, N'Requisitos para idiomas da aplicação e das partes', N'Os idiomas da aplicação e das partes devem ser declarados.
A declaração do idioma deve ser feita dentro do código-fonte da aplicação, conforme a especificação da tecnologia utilizada para o seu desenvolvimento. Caso ocorra mudança de idioma na mesma tela da aplicação, o código de idioma também deve ser declarado, exceto nomes próprios, vocabulário técnico e palavras ou frases estrangeiras que são parte do vocabulário nacional. Essa técnica permite que tanto o sistema operacional quanto o recurso de tecnologia assistiva identifiquem o idioma e apresentem o conteúdo ao usuário de forma compreensível. A forma de declaração do idioma pode mudar, dependendo da tecnologia de desenvolvimento da aplicação.
EXEMPLO 1 Uma aplicação em português tem seu idioma declarado no seu código-fonte como português do Brasil.EXEMPLO 2 Uma aplicação possui uma caixa de texto chamada “disclaimer”. Esta palavra tem seu idioma declarado no seu código-fonte como inglês dos Estados Unidos da América.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.25  ', 0, 1, N'Requisitos para elementos piscantes', N'Caso existam elementos em tela que piscam três vezes ou mais por segundo, o usuário deve ser avisado com antecedência para que possa evitar a visualização deste tipo de conteúdo. Caso seja tecnicamente possível, deve haver uma função para desabilitar os elementos piscantes. Elementos piscantes podem deixar os usuários desorientados, confusos ou causar desconforto e convulsões em pessoas com fotossensibilidade.
NOTA	Caso não haja conteúdo piscante, este requisito está automaticamente cumprido.
EXEMPLO Um jogo tem uma área que pisca apenas em pequenas áreas e por curto período de tempo. O usuário é avisado disso antes de iniciar o jogo e recebe uma opção para remover ou adaptar de forma inteligente esse tipo de conteúdo.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.26  ', 1, 1, N'Recomendações para funcionalidasdes de interface durante o primeiro uso', N'Recomenda-se que a aplicação ofereça ao usuário orientação sobre as funcionalidades de interface
durante o primeiro uso ou quando desejado.
Uma maneira mais dinâmica de apresentar o usuário a uma nova interface ou ajudá-lo durante a execução de uma tarefa em uma interface é por meio de um roteiro guiado (guided tour) ou de um assistente de execução (wizard).
EXEMPLO  No primeiro uso de uma aplicação, um breve tutorial é exibido na tela, apresentando as principais funcionalidades da aplicação e os recursos de acessibilidade.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.27  ', 1, 1, N'Recomendações para linguagem', N'Recomenda-se que seja usada linguagem simples e clara.
Não é indicado utilizar termos técnicos ou em outro idioma, que não façam parte do conhecimento popular do público-alvo da aplicação. A aplicação deve utilizar termos simples no idioma nativo para o maior número de pessoas e adequados ao contexto do usuário
EXEMPLO Em um aplicativo voltado para médicos, os termos médicos seriam considerados comuns, mas não em uma aplicação direcionada ao público em geral.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.28  ', 1, 1, N'Recomendações para textos', N'Recomenda-se que os textos sejam curtos e concisos. A escuta ou o acompanhamento de textos longos podem ser cansativos e de difícil leitura para alguns usuários. Por isso, se a aplicação apresentar textos longos, recomenda-se dividi-los em blocos, com a devida marcação por meio de código, de modo que o usuário possa ler por partes e recomeçar a leitura por estes blocos.
EXEMPLO  Um contrato de termos de uso tem parágrafos curtos e definidos por meio de código de programação.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.3   ', 1, 1, N'Recomendação para elementos decorativos e atenção do usuário', N'Recomenda-se que não sejam usados elementos meramente decorativos que possam tirar a atenção do usuário durante a execução da tarefa.
EXEMPLO Enquanto um usuário preenche um formulário de contato, nenhum movimento, som ou elemento decorativo atrapalha o seu preenchimento.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.4   ', 0, 1, N'Requisitos para elementos interativos e de interface do usuário', N'Elementos interativos e de interface do usuário devem ter rótulos que descrevem o elemento, sua funcionalidade, estado ou operaçao.
Elementos de interface interativos, como botões e campos de formulário, devem conter um rótulo que descreve a sua função. Os rótulos devem estar relacionados com o elemento por meio de código de programação. Nem todos os elementos possuem todas essas características, mas eles devem ser compreensíveis para a operaçao do usuário.
EXEMPLO Um campo de formulário que exige o nome do usuário precisa ter um rótulo “Nome” relacionado ao campo que exige a entrada de texto.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.5   ', 0, 1, N'Requisitos para cabeçalhos e rótulos', N'A aplicação deve estar estruturada por meio de elementos de cabeçalho em títulos de seção e rótulos em campos de entradas de dados, permitindo que usuários de tecnologia assistiva compreendam melhor sua organização. O uso desses recursos possibilita a localização do conteúdo de forma mais rápida.
EXEMPLO Uma aplicação utiliza cabeçalhos para separar as principais áreas exibidas na tela e rótulos que descrevem o que é exigido nos campos interativos.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.6   ', 0, 1, N'Requisitos para organização de elementos funcionais e nomes acessíveis', N'Deve ser mantida a mesma organização de elementos funcionais e nomes acessíveis ao longo de toda a aplicação.
Os elementos funcionais devem manter-se na mesma posiçao e com a mesma descrição acessível. Isso facilita a compreensao e acelera o aprendizado do usuário.
EXEMPLO  Blocos de controle e menus mantêm a mesma ordem relativa em todas as telas em que aparecem.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.7   ', 0, 1, N'Requisitos para nomes acessíveis', N'Os nomes acessíveis devem conter os rótulos dos elementos.
Para os elementos que possuam rótulos em texto ou imagens de texto, o nome acessível deve conter todo o rótulo. Sempre que possível, o texto do rótulo deve estar no começo do nome acessível.
NOTA 1 O rótulo é apresentado a todos os usuários, enquanto o nome acessível pode estar oculto e ser disponibilizado apenas para os recursos de tecnologia assistiva. Em alguns casos, o nome acessível e o rótulo são os mesmos.
NOTA 2 Programaticamente, na existência de um rótulo e na ausência de um nome acessível, geralmente assume-se que o rótulo seja o nome acessível e, assim, este requisito é automaticamente cumprido.
EXEMPLO Uma interface com várias seções, sendo uma para cada produto, tern um botao para contratação. O rótulo de todos os botões é o mesmo (“contratar"). Contudo, o nome acessível de cada um traz também a identificação do produto, como “contratar produto A”, “contratar produto B”.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.8   ', 0, 1, N'Requisitos para descrição de elementos de interface interativos', N'Elementos de interface interativos devem descrever sua funcionalidade de forma clara, para a compreensao mesmo fora do contexto.
Elementos como botões, links e ícones devem ser compreendidos mesmo fora do contexto. Esses elementos devem ter atributos ou alternativas textuais que descrevem sua funcionalidade aos usuários de tecnologia assistiva. Em caso de elementos que se repetem na interface, cada um deles deve fazer referência a qual objeto ou contexto a ação ou funcionalidade está relacionada.
EXEMPLO Um ícone de uma “casa” que leva o usuário para a página inicial precisa de um texto alternativo “voltar para o início”. Uma imagem “+” precisa ter o texto alternativo “Botão Adicionar Despesa” (em uma tela de cadastro de despesas).
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.1.9   ', 1, 1, N'Recomendações para padrão visual ao longo de toda aplicação', N'Recomenda-se que seja mantido o mesmo padrao visual ao longo de toda a aplicação.
Evitar criar interfaces que mudam muito quando o usuário executa uma ação, pois isso pode dificultar a compreensao e tomar tempo até o usuário se acostumar com a nova interface.
EXEMPLO Uma tela inicial de uma aplicação utiliza o mesmo padrao visual das demais telas da aplicação. ')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.1   ', 0, 2, N'Requisitos para configurações de acessibilidade', N'A aplicação não pode alterar as configurações de acessibilidade do usuário sem que ele seja notificado e concorde com a mudança.
EXEMPLO  Se o modo noturno do dispositivo do usuário estiver habilitado, a aplicação não desabilita essa função de forma automática.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.10  ', 0, 2, N'Requisitos para alteração de contexto ao interagir com formulários', N'Não pode haver alteração de contexto inesperada ao interagir com formulários.
Interações com formulários devem ter efeitos previsíveis, ou seja, ao entrar ou editar dados em formulários, não pode ocorrer de forma automática uma alteração de contexto sem que o usuário tenha conhecimento prévio.
As alterações de contexto inesperadas podem deixar desorientados os usuários que não conseguem ter visibilidade completa da página.
NOTA  Botões e links, quando são acionados, iniciam alterações de conteúdos que podem ser alterações de contexto. Porém, como é do conhecimento do usuário que estes componentes tenham alguma ação/ reação, isso não se enquadra ao descrito acima.
EXEMPLO Ao selecionar um botão de rádio dentro de um formulário, o foco permanece no mesmo Iugar, sem fazer movimentações inesperadas.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.11  ', 0, 2, N'Requisitos para alteração de contexto em elementos interativos', N'Não pode haver alteração de contexto inesperada ao focar em elementos interativos.
Nenhum tipo de alteração de contexto ocorre quando algum elemento de interface recebe foco. Assim, há garantia de previsibilidade de navegação na tela sobre componentes que possuem algum tipo de interação.
Um componente pode receber foco tanto com algum recurso de tecnologia assistiva (por exemplo, com a utilização de um leitor de tela) como sem recurso de tecnologia assistiva (tocar em um campo de formulário para ativar a digitação).
EXEMPLO 1 Em um formulário, ao tocar no último campo, este formulário não é submetido de forma automática, sem avisar o usuário que isso ocorre. Existe um botão “enviar” após o último campo.
EXEMPLO 2 Ao inserir dados em um campo de e-mail, a validação do campo e a mensagem de alerta correspondente são ativadas e informadas ao usuário apenas quando o botão “enviar” é ativado ou quando o campo sair de foco.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.12  ', 0, 2, N'Requisitos para interação por toque', N'Toda interação deve ser suportada por um único toque na tela. Caso existam apps que exijam múltiplos toques ou gestos específicos, deve existir uma forma de permitir que o usuário consiga executar a mesma ação com toque único.
NOTA  Este requisito não se aplica aos gestos de controle dos agentes de usuário, como o deslizar (swipes) de leitores de tela e rolagem (scroll)  padrão na vertical.
EXEMPLO 1 Uma aplicação que exige a ligação entre dois pontos na tela por um caminho desenhado com o dedo também permite que o usuário conclua a ação tocando no ponto inicial e, em seguida, no final.
EXEMPLO 2 Uma aplicação que usa um “carrossel” de imagens e/ou blocos de texto que podem ser trocados com o deslizar do dedo pela tela pode ser acionada por botões nas laterais do carrossel para exibir a imagem seguinte ou a anterior.
EXEMPLO 3 Um mapa interativo que amplia com gesto de pinça executa a mesma ação quando o usuário dá dois toques rápidos no mapa ou possui botões de controle de zoom.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.13  ', 1, 2, N'Recomendações para tamanho da área de toque', N'Recomenda-se que os elementos interativos tenham um tamanho mínimo de área de toque.
O tamanho da área de toque de elementos interativos deve ser grande o suficiente para serem lidos e acionados confortavelmente e com precisão. As dimensões mínimas devem seguir os critérios de sucesso nível AAA do WCAG 2.1. Se houver exigência técnica da especificação da tecnologia utilizada para o desenvolvimento da aplicação, esta deve ser seguida em vez do WCAG.
EXEMPLO  Um aplicativo tem botões com tamanhos e distância de outros botões suficientes para que o usuário não acione outros elementos interativos próximos de forma acidental.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.14  ', 0, 2, N'Requisitos para navegação com recursos de tecnologias assistivas', N'Não pode haver bloqueio na navegação sequencial com recursos de tecnologia assistiva.
A aplicação deve permitir que tecnologias assistivas que utilizam navegação sequencial, normalmente pelo movimento rápido de deslizar o dedo (também conhecido como swipe), como um leitor de tela, percorram todo o conteúdo livremente sem ficar preso em ponto algum.
EXEMPLO  Um aplicativo permite que o leitor de tela interprete todo o conteúdo, item a item, de forma sequencial, conforme os comandos do usuário.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.15  ', 0, 2, N'Requisitos para indicação e correção de erros de interação', N'A aplicação deve informar ao usuário os erros de interação e dar a oportunidade de corrigir o erro sem prejuízo do uso da aplicação.
As informações referentes aos erros do usuário devem ser claras, e a aplicação deve permitir a sua correção.
EXEMPLO  Um formulário que requer dados de um campo obrigatório que não foi preenchido exibe um aviso ao usuário sobre a necessidade do seu preenchimento e leva o foco do usuário para o respectivo campo, sem limpar os demais campos.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.16  ', 0, 2, N'Requisitos para ampliação da tela', N'Deve haver suporte para ampliação da tela sem perda de informação ou funcionalidade.
Quando o usuário fizer ampliação da tela (zoom) em uma aplicação, ele não pode perder informação ou funcionalidade, como, por exemplo, elementos que ficam escondidos atrás de outros elementos de interface visuais.
EXEMPLO Quando o usuário amplia a tela, os elementos da aplicação se reorganizam para se adaptar ao novo tamanho de tela.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.17  ', 0, 2, N'Requisitos para uso de comandos de voz', N'As aplicações que façam uso de comandos de voz devem permitir outra modalidade de comandos por meio de interface interativa.
Se uma aplicação utilizar comandos de voz para executar uma ação, esta ação está disponível também em uma outra modalidade de interação.
EXEMPLO  Uma aplicação que controla as luzes da casa por comandos de voz também disponibiliza uma interface interativa no dispositivo móvel para uso sem voz.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.18  ', 1, 2, N'Recomendações para listas ou tabelas', N'As aplicações que utilizam listas ou tabelas podem permitir a ordenação por critérios que sejam relevantes para o usuário.
EXEMPLO	Uma lista de produtos permite a ordenação alfabética ao tocar no rótulo “nome”, no topo da lista.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.19  ', 1, 2, N'Recomendações para mecanismo de busca em aplicações', N'Recomenda-se que haja mecanismos de busca em aplicações com grande quantidade de informações.
O usuário deve ter opções e formas diferentes para acessar ou localizar um determinado conteúdo. Deve-se considerar adicionar um sistema de busca para que os usuários encontrem conteúdos por frases ou palavras-chave sem ter que navegar por toda a aplicação.
EXEMPLO	Um campo de busca retorna o conteúdo pesquisado pelo usuário.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.2   ', 0, 2, N'Requisitos para controle do usuário sobre ações por movimento', N'Deve haver controle do usuário sobre as ações por movimento de dispositivos móveis.
A aplicação deve permitir que o usuário desative a resposta ao movimento físico do aparelho e forneça alternativa de execução desta ação por meio de componentes de interface.
EXEMPLO  Um aplicativo de reprodução de música responde a movimentos do aparelho para frente e para trás, para passar para a próxima música. O usuário consegue desativar a alteração de música por este movimento nas configurações do próprio aplicativo.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.3   ', 0, 2, N'Requisitos para configuração de notificação', N'A aplicação deve permitir que o usuário configure suas formas de notificação.
O usuário deve ter autonomia para escolher como e se deseja receber notificações da aplicação.
EXEMPLO Um aplicativo de e-commerce permite que o usuário desabilite ou configure as notificações diretamente na aplicação.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.4   ', 0, 2, N'Requisitos para orientação de tela', N'O usuário deve ser avisado sempre que for necessário forçar uma determinada orientação (retrato ou paisagem) do dispositivo.
EXEMPLO Um jogo que só funciona no modo paisagem exibe uma mensagem “gire o dispositivo para usar a aplicação", quando o usuário está usando seu dispositivo em modo retrato.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.5   ', 1, 2, N'Recomendações para orientação de tela', N'Recomenda-se que não seja restringida a orientação de tela do usuário a uma única orientação.
Restringir a somente uma orientação (retrato ou paisagem) pode dificultar a leitura e manipulação de interface de pessoas com limitações motoras e que necessitam de área maior para ler ou interagir com a aplicação.
Caso o aplicativo estabeleça uma orientação, o usuário deve ser auxiliado a alterá-la para retornar a um ponto compatível em seu dispositivo.
EXEMPLO Um aplicativo se ajusta ao tamanho da tela do celular do usuário, independentemente do seu uso na orientação de retrato ou paisagem.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.6   ', 0, 2, N'Requisitos de definição de tempo para execução de atividades', N'Nas aplicações em que a limitação de tempo não é essencial para a execução de uma atividade, deve haver a possibilidade de controle de tempo pelo usuário. Caso haja alguma limitação de tempo, esta limitação pode ser desligada ou prolongada de forma simples e eficiente por ao menos 10 vezes, ou deve ser superior a 20 h.
EXEMPLO  Um formulário de pesquisa de satisfação tem um limite de tempo para ser preenchido que pode ser prolongado pelo usuário, se necessário.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.7   ', 0, 2, N'Requisitos para controle de áudios iniciados automaticamente', N'Deve haver uma forma de controlar os áudios iniciados automaticamente.
Caso uma aplicação ou página inicie a reprodução de um áudio automaticamente e esta reprodução persista por mais de três segundos, deve haver um mecanismo para parar, pausar ou controlar o volume do áudio, de tal forma que não atrapalhe a experiência do usuário, independentemente de uso de recursos assistivos.
NOTA	No parágrafo acima o valor e a unidade foram mantidos por extenso para contemplar acessibilidade.
EXEMPLO 1 Um serviço de transmissão online, como rádio online, inicia automaticamente a transmissão ao abrir o aplicativo, mas existe um controle para interromper, pausar ou silenciar a reprodução do áudio imediatamente.
EXEMPLO 2 Um aplicativo de transmissão de vídeos inicia automaticamente um vídeo com áudio de propaganda ao abrir, mas existe um controle para interromper ou pausar a reprodução do vídeo imediatamente.')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.8   ', 1, 2, N'Recomendações para áudios iniciados automaticamente', N'Recomenda-se que não seja iniciada a reprodução de áudio automaticamente. Isso é importante para que usuários não sejam desorientados pelo áudio, especialmente os que usam leitores de tela.
EXEMPLO  Um serviço de transmissão online, como, por exemplo, uma rádio online, inicia a reprodução do áudio somente após o usuário acionar um botão.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.2.9   ', 0, 2, N'Requisitos para controle de conteúdo que se movimenta na tela', N'Deve haver controle do usuário para pausar, parar ou ocultar conteúdo que se movimente na tela.
A aplicação deve permitir uma forma de parar, pausar ou ocultar conteúdo em movimento que é iniciado automaticamente, que dure mais de cinco segundos e que esteja próximo a outros conteúdos. Atualizações de tela também devem permitir o controle do usuário.
NOTA  No parágrafo acima o valor e a unidade foram mantidos por extenso para contemplar acessibilidade.
EXEMPLO  Um vídeo que inicia automaticamente quando o usuário acessa uma área do aplicativo tem botões de pausar ou fechar o vídeo.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.3.1   ', 0, 3, N'Requisitos para legendas', N'Os vídeos devem oferecer legendas para conteúdo em áudio. Em vídeos ao vivo, deve-se oferecer esse recurso utilizando estenotipia, legenda automática ou serviço similar.
EXEMPLO	Um tutorial de como utilizar um sistema permite que o usuário habilite legendas em um vídeo.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.3.2   ', 0, 3, N'Requisitos para recurso alternativo em vídeo pré-gravado', N'Deve haver ao menos um recurso alternativo para todo conteúdo de vídeo pré-gravado, como transcrição ou audiodescrição.
Para tomar o conteúdo disponível a mais pessoas, deve ser fornecida uma transcrição que contenha todas as informações da mídia pré-gravada (visual ou sonora) na forma de texto ou audiodescrição da mídia de vídeo. Além das informações contidas nas falas, deve-se informar todo o conteúdo visual relevante para a compreensão do vídeo, como expressões corporais, risadas, informações em texto, mudança de ambiente, entre outros.
Transcrição e audiodescrição são recursos importantes para a acessibilidade. Ambos beneficiam pessoas surdas, que não podem compreender o conteúdo em áudio, e pessoas com deficiência
visual (cegas ou com baixa visão), que podem não compreender informações visuais. Recomenda-se adicionar os dois recursos à mídia.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.3.3   ', 0, 3, N'Requisitos para transcrição textual para áudio pré-gravado', N'Deve existir uma transcrição textual para conteúdo de áudio pré-gravado.
Para que as pessoas tenham acesso ao conteúdo por áudio, é ideal que exista uma alternativa em texto, de preferência, de modo sincronizado para acompanhamento.
EXEMPLO  Um episódio de podcast possui um documento contendo a transcrição textual de todo o áudio do programa.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.3.4   ', 1, 3, N'Recomendações para alternativa em texto para áudio ao vivo', N'Recomenda-se que haja uma alternativa em texto para o conteúdo de áudio ao vivo.
Para tornar acessíveis as informações veiculadas por áudio ao vivo, como videoconferências, discursos ao vivo e webcasts de rádio, deve-se fornecer uma alternativa para conteúdo de áudio ao vivo que apresente informações equivalentes em texto, como estenotipia, legenda automática ou serviço similar.
EXEMPLO 1 Uma empresa de notícias usa serviços de legenda baseados na web para cobrir eventos ao vivo; a saída do serviço é incorporada na tela da aplicação que inclui o controle de streaming de áudio.
EXEMPLO 2 Em uma transmissão ao vivo, legendas são exibidas para as pessoas que não conseguem acompanhar o conteúdo por som.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.3.5   ', 1, 3, N'Recomendações para libras em conteúdo com áudio', N'Recomenda-se que seja disponibilizada uma alternativa em Libras para o conteúdo com áudio.
Pessoas surdas ou com deficiência auditiva podem não ser capazes de ler e compreender legendas. Por isso, o fornecimento de tradução ou interpretação em língua de sinais para todo o conteúdo de áudio pré-gravado existente ou em transmissões ao vivo (mesmo quando incluído vídeo) permite que as pessoas usuárias de língua de sinais compreendam o conteúdo.
EXEMPLO  Um vídeo de uma palestra possui um intérprete de Libras no canto ou na lateral do vídeo.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.3.6   ', 1, 3, N'Recomendações para audiodescrição estendida em vídeo pré-gravado', N'Recomenda-se que haja audiodescrição estendida para conteúdo em vídeo pré-gravado.
Pessoas cegas, com baixa visão e com limitações cognitivas que têm dificuldade para interpretar visualmente o que está acontecendo em um vídeo costumam utilizar a audiodescrição da informação visual. Porém, se houver muito diálogo, as pausas no áudio podem ser insuficientes para permitir que as descrições de áudio transmitam o sentido do vídeo. Nestes casos, recomenda-se fornecer uma descrição de áudio estendida para todo o conteúdo visual do vídeo pré-gravado em mídia sincronizada.
EXEMPLO Uma pessoa ensina receitas em um tutorial online. Ela mostra os ingredientes e o modo de fazer com as mãos, enquanto fala rapidamente sobre a receita. Assim que termina de ensinar a primeira receita, ela começa a ensinar a próxima. O vídeo é pausado entre as receitas e é fornecida uma audiodescrição estendida das dicas visuais mostradas no vídeo. O vídeo é reiniciado.
')
INSERT [dbo].[NBR_17060] ([id_requisito], [id_TipoRequisito], [id_Categoria], [Descricao], [Detalhe]) VALUES (N'5.1.4.1   ', 0, 4, N'Requisitos para codificação', N'Toda a aplicação deve ser codificada conforme as documentações de padrões técnicos, para garantir compatibilidade com o máximo de dispositivos e tecnologias assistivas. Para aplicações e páginas web que rodam em dispositivos móveis, as linguagens de marcação e o conteúdo devem ser bem estruturados e válidos, de acordo com as regras definidas nessas linguagens. Os erros na sintaxe dos elementos e atributos e as falhas de estrutura podem impedir a correta interpretação do conteúdo por agentes de usuário e tecnologias assistivas.
Caso sejam utilizados elementos de interface ou controles customizados, é necessário verificar se o componente possui nome, função e valores declarados, e se são acessíveis por recurso de tecnologia assistiva.
EXEMPLO Uma aplicação web segue a especificação de elementos do HTMLS e das diretrizes de acessibilidade WCAG. Aplicações de sistemas nativos Android e IOs seguem suas respectivas orientações de acessibilidade.
')
GO
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (1, N'Utilização sem a visão', N'Quando a TIC oferecer meios de operação visuais, deve ser fornecido pelo menos um modo de operação que não exija o uso da visão.
O descrito a seguir pode contribuir para isso:
a)		uma página da web	ou aplicativo com uma boa estrutura semântica pode permitir que os usuários que não fazem uso da visão identifiquem, naveguem e interajam com a interface;
b)	interfaces de usuário táteis e de áudio.
')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (2, N'Utilização com visão Limitada', N'Quando a TIC oferecer meios de operação visuais, deve ser fornecido pelo menos um modo de operação que permita o seu uso com visão parcial ou limitada.
O descrito a seguir pode contribuir para isso:
a)	ampliação, redução do campo visual e controle do contraste, brilho e intensidade;
b)	fornecimento de meios adicionais para fazer distinção entre esses recursos, quando houver
recursos importantes de interface que dependam da percepção de profundidade;
c)	usuários com visão limitada também podem se beneficiar de modos de operação que não exijam a visão')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (3, N'Utilização sem percepção de cor', N'Quando a TIC oferecer meios de operação visuais que dependam de cor, deve ser fornecido pelo
menos um modo de operação que não exija essa percepção.
O fornecimento de meios adicionais para fazer distinção entre esses recursos, quando houver recursos importantes de interface codificados por cor pode contribuir para isso.
')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (4, N'Utilização sem audição', N'Quando a TIC oferecer meios de operação sonoros, deve ser fornecido pelo menos um modo de operação que não exija o uso da audição.
As interfaces de usuário visuais e táteis podem contribuir para isso.
')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (5, N'Utilização com audição limitada', N'Quando a TIC oferecer meios de operação sonoros, deve ser fornecido pelo menos um modo de operação que permita o seu uso com audição parcial ou limitada, conforme apresentado a seguir:
a)	aprimoramento da clareza do áudio;
b)	redução de ruídos de fundo;
c)	aumento da faixa de volume;
d)	volume maior na faixa de frequência mais alta.
Usuários com audição limitada também podem se beneficiar de modos de operação que não exijam a audição
')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (6, N'Utilização sem a fala', N'Quando a TIC exigir entrada por voz, deve ser fornecido pelo menos um modo de operação que não
exija o uso da voz.
As interfaces de usuário por toque em tela, caneta ou tecla física podem contribuir para isso
')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (7, N'Utilização dom manipulação ou força limitadas', N'Quando a TIC exigir ações manuais, deve ser fornecido pelo menos um modo de operação que não exija manipulação ou força da mão.
Exemplos de operações que os usuários podem não conseguir realizar incluem aquelas que requerem controle motor fino, gestos específicos, movimento de pinça, torcer o pulso, agarrar ou ações manuais simultâneas.
O descrito a seguir pode contribuir para isso:
a)	ações que exijam o uso de apenas uma das mãos;
b)	ações por meio de teclas sequenciais;
c)	ações por entrada de voz;
d)	ações que não exijam força nas mãos. Alguns usuários têm força limitada nas mãos e podem não conseguir atingir o nível de força necessário para realizar uma ação.
')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (8, N'Utilização com alcance limitado', N'Os elementos operacionais precisam estar ao alcance de todos os usuários.
Considerar as necessidades dos usuários de cadeiras de rodas e a variedade de estaturas dos usuários ao posicionar elementos de interface de usuário operáveis pode contribuir para isso.
')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (9, N'Utilização por pessoas com epilepsia fotossensível', N'Quando a TIC oferecer meios de operação visuais, deve ser fornecido pelo menos um modo de operação que minimize o potencial de desencadear convulsões fotossensíveis.
Limitar a área e o número de flashes por segundo pode contribuir para isso.
')
INSERT [dbo].[NBR_17060DesempenhoFuncional] ([id_DesempenhoFuncional], [Descricao], [Detalhe]) VALUES (10, N'Utilização com cognição limitada', N'Alguns usuários necessitam que a TIC forneça recursos que a tornem mais simples e fácil de utilizar. A utilização com cognição limitada tem o objetivo de incluir as necessidades de pessoas com limitadas habilidades cognitivas, de linguagem e de aprendizado.
O descrito a seguir pode contribuir para isso:
a)	limite de tempo ajustável;
b)	indicação de erro e auxílio para a correção;
c)	ordem Iógica de foco.
')
GO
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.1   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.1   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.10  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.10  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.10  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.11  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.11  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.11  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.12  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.12  ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.12  ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.12  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.13  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.13  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.13  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.14  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.15  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.15  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.16  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.16  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.16  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.17  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.17  ', 3)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.18  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.18  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.18  ', 3)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.19  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.19  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.19  ', 3)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.19  ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.19  ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.2   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.2   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.2   ', 3)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.20  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.20  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.20  ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.20  ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.21  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.21  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.21  ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.21  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.22  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.22  ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.23  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.23  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.23  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.24  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.24  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.24  ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.24  ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.24  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.25  ', 9)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.26  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.26  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.26  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.27  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.28  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.28  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.28  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.3   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.3   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.4   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.4   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.4   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.4   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.4   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.5   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.5   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.5   ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.6   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.6   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.6   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.6   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.7   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.7   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.7   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.7   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.7   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.8   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.8   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.8   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.8   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.8   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.9   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.1.9   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 3)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 6)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.1   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.10  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.10  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.10  ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.10  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.11  ', 1)
GO
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.11  ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.11  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.12  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.12  ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.12  ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.13  ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.13  ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.13  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.14  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.14  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.14  ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.14  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.15  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.15  ', 3)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.15  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.16  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.17  ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.17  ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.17  ', 6)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.18  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.18  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.18  ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.18  ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.18  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.19  ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.19  ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.19  ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.19  ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.19  ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.2   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.2   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.2   ', 6)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.2   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.2   ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.2   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.3   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.3   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.3   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.3   ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.4   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.4   ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.5   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.5   ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.6   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.6   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.6   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.6   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.7   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.7   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.7   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.7   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.8   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.8   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.8   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.8   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.9   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.2.9   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.1   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.1   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.1   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.2   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.2   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.2   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.2   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.2   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.3   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.3   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.3   ', 6)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.4   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.4   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.4   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.4   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.4   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.5   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.5   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.5   ', 6)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.6   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.6   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.3.6   ', 10)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 1)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 2)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 3)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 4)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 5)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 6)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 7)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 8)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 9)
INSERT [dbo].[NBR_17060_DesempFuncRequisitos] ([id_Requisito], [id_DesempenhoFuncional]) VALUES (N'5.1.4.1   ', 10)
GO
SET IDENTITY_INSERT [dbo].[Geral] ON 

INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (1, N'FN        ', N'1.1.1.    ', N'Requisito', N'Ambiente', N'Aplicativo', N'Usar ou ignorar o brilho automático', N'ajusta o brilho e o contraste da tela com base nos ajustes da luz ambiente', N'SO,23', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (2, N'FN        ', N'1.1.2.    ', N'Requisito', N'Ambiente', N'Aplicativo', N'Reduzir o ponto branco na tela', N'reduz a intensidade das cores brilhantes', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (3, N'FN        ', N'1.1.3.    ', N'Requisito', N'Ambiente', N'Aplicativo', N'Silenciar todos os efeitos sonoros', N'quando essa opção for selecionada, o celular não vai emitir nenhum efeito', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (4, N'FN        ', N'1.1.4.    ', N'Requisito', N'Ambiente', N'Aplicativo', N'Reduzir animação das telas', N'reduz o movimento da interface do usuário', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (5, N'FN        ', N'1.1.5.    ', N'Requisito', N'Ambiente', N'Aplicativo', N'Ouvir notificações', N'o leitor de tela vai falar quando uma notificação chegar', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (6, N'FN        ', N'1.1.6.    ', N'Requisito', N'Ambiente', N'Aplicativo', N'Piscar o flash para alertas', N'o flash vai piscar quando chegar alguma mensagem ou ligação', N'SO,10', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (7, N'FN        ', N'1.2.1.    ', N'Requisito', N'Ambiente', N'Zoom', N'Ativar o zoom', N'amplia a tela ou parte dela', N'SO,23', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (8, N'FN        ', N'1.2.2.    ', N'Requisito', N'Ambiente', N'Zoom', N'Seguir o foco de seleção', N'essa opção faz com que o zoom amplie parte da tela em que alguma tarefa está sendo executada', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (9, N'FN        ', N'1.2.3.    ', N'Requisito', N'Ambiente', N'Zoom', N'Exibição do controle do zoom em tela', N'o controle é uma alternativa para acesso rápido aos controles do zoom', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (10, N'FN        ', N'1.2.4.    ', N'Requisito', N'Ambiente', N'Zoom', N'Visibilidade do controle do zoom', N'essa opção define o quão visível vai ficar o controle do zoom', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (11, N'FN        ', N'1.2.5.    ', N'Requisito', N'Ambiente', N'Zoom', N'Janela de ampliação e ampliação máxima', N'define se a tela inteira será utilizada para visualizar o conteúdo ampliado ou se será utilizada uma janela para isso', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (12, N'FN        ', N'2.1.1.    ', N'Requisito', N'Gráficos', N'Textos e Fontes', N'Fontes preferidas e seus estilos', N'escolher qual tema de fonte prefere', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (13, N'FN        ', N'2.1.2.    ', N'Requisito', N'Gráficos', N'Textos e Fontes', N'Texto em negrito', N'deixar o texto do app em negrito', N'SO,DP', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (14, N'FN        ', N'2.1.3.    ', N'Requisito', N'Gráficos', N'Textos e Fontes', N'Tamanho da fonte', N'escolher qual tamanho de fonte prefere', N'SO,4,DP', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (15, N'FN        ', N'2.1.4.    ', N'Requisito', N'Gráficos', N'Textos e Fontes', N'Cor da fonte', N'escolher uma cor para o texto', N'4,DP', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (16, N'FN        ', N'2.2.1.    ', N'Requisito', N'Gráficos', N'Cor da Tela', N'Personalizar cor da tela', N'escolher a cor que deseja que a tela tenha', N'23,DP', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (17, N'FN        ', N'2.2.2.    ', N'Requisito', N'Gráficos', N'Cor da Tela', N'Inverter as cores da tela', N'inverter todas as cores da tela', N'SO,10', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (18, N'FN        ', N'2.2.3.    ', N'Requisito', N'Gráficos', N'Cor da Tela', N'Filtro da cor da tela', N'escolher o conjunto de cores que deseja que a película na tela tenha', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (19, N'FN        ', N'2.2.4.    ', N'Requisito', N'Gráficos', N'Cor da Tela', N'Intensidade e contraste da cor da tela', N'escolher a intensidade de tons da tela', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (20, N'FN        ', N'2.3.1.    ', N'Requisito', N'Gráficos', N'Cursor', N'Modelo do cursor', N'deixa o contorno ao redor do item mais grosso para aumentar o destaque', N'SO,26', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (21, N'FN        ', N'2.3.2.    ', N'Requisito', N'Gráficos', N'Cursor', N'Visualização do cursor', N'escolher a cor e transparência do contorno do cursor', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (22, N'FN        ', N'2.4.1.    ', N'Requisito', N'Gráficos', N'Legendas em Vídeos', N'Fontes preferidas e seus estilos', N'escolher qual tipo de legenda prefere como texto contornado ou clássico', N'SO,23', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (23, N'FN        ', N'2.4.2.    ', N'Requisito', N'Gráficos', N'Legendas em Vídeos', N'Tamanho da fonte', N'escolher qual o tamanho de fonte que a legenda deve ter', N'SO,23', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (24, N'FN        ', N'2.4.3.    ', N'Requisito', N'Gráficos', N'Legendas em Vídeos', N'Cor e opacidade da fonte', N'escolher a cor que a legenda deve ter e o quão evidente ela vai estar na tela', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (25, N'FN        ', N'2.4.4.    ', N'Requisito', N'Gráficos', N'Legendas em Vídeos', N'Cor de fundo e opacidade da caixa de legenda', N'escolher a cor de fundo da legenda e o quão evidente o contorno dela vai estar na tela', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (26, N'FN        ', N'2.4.5.    ', N'Requisito', N'Gráficos', N'Legendas em Vídeos', N'Ativar a legenda de libras', N'o usuário deve poder ativar e utilizar a legenda em LIBRAS nos vídeos, quando disponível', N'DP', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (27, N'FN        ', N'3.1.1.    ', N'Requisito', N'Sonoros', N'Leitor de Tela', N'Ativar o leitor de tela', N'escolher se deseja ativar o leitor de tela', N'SO,23', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (28, N'FN        ', N'3.1.2.    ', N'Requisito', N'Sonoros', N'Leitor de Tela', N'Velocidade da fala', N'escolher a velocidade da fala do leitor de tela', N'SO,23', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (29, N'FN        ', N'3.1.3.    ', N'Requisito', N'Sonoros', N'Leitor de Tela', N'timbre de fala', N'escolher o tom da fala do leitor de tela', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (30, N'FN        ', N'3.2.1.    ', N'Requisito', N'Sonoros', N'Leitura de Conteúdo', N'Conteúdo da tela', N'todo conteúdo da tela vai ser lido', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (31, N'FN        ', N'3.2.2.    ', N'Requisito', N'Sonoros', N'Leitura de Conteúdo', N'Pontuação', N'determinar como serão faladas as pontuações em texto', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (32, N'FN        ', N'3.2.3.    ', N'Requisito', N'Sonoros', N'Leitura de Conteúdo', N'Texto Selecionado', N'determina se o texto detectado automaticamente no item em foco deve ser falado', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (33, N'FN        ', N'3.2.4.    ', N'Requisito', N'Sonoros', N'Leitura de Conteúdo', N'Letras e palavras em maiúsculo', N'determina o que fazer ao encontrar letras maiúsculas em um texto', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (34, N'FN        ', N'3.2.5.    ', N'Requisito', N'Sonoros', N'Leitura de Conteúdo', N'Cabeçalhos de tabelas', N'ler o conteúdo do cabeçalho de uma tabela', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (35, N'FN        ', N'3.2.6.    ', N'Requisito', N'Sonoros', N'Leitura de Conteúdo', N'Números de linhas e colunas em tabelas', N'o leitor de tela vai indicar a quantidade de linhas e colunas', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (36, N'FN        ', N'3.2.7.    ', N'Requisito', N'Sonoros', N'Leitura de Conteúdo', N'Falar a palavra "emoji"', N'quando o leitor de tela encontrar um emoji no texto vai ser indicado', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (37, N'FN        ', N'3.3.1.    ', N'Requisito', N'Sonoros', N'Leitura durante digitação', N'Escolher modo de leitura ao digitar', N'falar letras e algarismos digitados, palavras normalmente ou por retorno fonético', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (38, N'FN        ', N'3.3.2.    ', N'Requisito', N'Sonoros', N'Leitura durante digitação', N'Falar palavras inteiras ao serem digitadas', N'o leitor de tela vai falar a palavra inteira quando terminar de ser digitada', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (39, N'FN        ', N'4.1.1.    ', N'Requisito', N'Entrada', N'Toque na tela', N'Ação a ser executada a cada tipo de movimento de toque', N'escolher qual ação: toque simples, toque com arraste, toque duplo, toque longo', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (40, N'FN        ', N'4.1.2.    ', N'Requisito', N'Entrada', N'Toque na tela', N'Intervalo de tempo de um toque', N'escolher qual o intervalo de tempo para um aplicativo reconhecer o toque', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (41, N'FN        ', N'4.1.3.    ', N'Requisito', N'Entrada', N'Toque na tela', N'Intervalo de duração de um toque longo', N'escolher qual o intervalo de tempo para um aplicativo reconhecer um toque longo', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (42, N'FN        ', N'4.2.1.    ', N'Requisito', N'Entrada', N'Estilo de Digitacao', N'Digitação por toque direto', N'a letra que o usuário tocar será a letra digitada', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (43, N'FN        ', N'4.2.2.    ', N'Requisito', N'Entrada', N'Estilo de Digitacao', N'Digitação com confirmação de voz', N'mova o dedo para esquerda ou direita no teclado. O aplicativo irá dizer por voz sobre qual letra seu dedo está e o usuário confirma com um ou dois toques se deseja digitá-la', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (44, N'FN        ', N'4.2.3.    ', N'Requisito', N'Entrada', N'Estilo de Digitacao', N'Digitação datilográfica', N'o usuário seleciona tecla e, ao retirar o dedo da tecla, a letra é digitada', N'SO', N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (45, N'GDAMA     ', N'R01       ', N'Recomendação', N'Interface', N'Organização', N'Os componentes e informações da interface devem contribuir diretamente para a funcionalidade da aplicação', N'Não utilizar componentes com propósito apenas estético pois isso aumenta a quantidade de informações para o usuário com deficiência visual memorizar quando explora e interage com a interface, aumentando a carga cognitiva.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (46, N'GDAMA     ', N'R02       ', N'Requisito', N'Interface', N'Cor', N'Os componentes da interface devem ser entendidos sem a utilização de cores.', N'Não utilizar apenas cores para identificar ou indicar a funcionalidade de componentes. Tanto o entendimento quanto a interação de usuários, sobretudo com perda parcial da visão ou daltônicos, podem ser prejudicados. Exemplo: Verde para aceitar/entrar e vermelho para cancelar.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (47, N'GDAMA     ', N'R03       ', N'Requisito', N'Interface', N'Cor', N'Os componentes da interface devem utilizar cores com alto contraste em relação ao plano de fundo.', N'A falta de alto contraste entre os componentes pode fazer usuários com perda parcial da visão ignorá-los. O contraste pode ser verificado por várias ferramentas, como a
Accessibility Color Wheel.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (48, N'GDAMA     ', N'R04       ', N'Recomendação', N'Interface', N'Orientação da Tela', N'A interface sempre deve oferecer a opção para a orientação vertical da tela.', N'Usuários com deficiência visual utilizam o aparelho posicionado na vertical em uma das mãos e interagem com a outra. Desta forma, a melhor posição do telefone é na vertical e portanto os aplicativos devem oferecer essa opção.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (49, N'GDAMA     ', N'R05       ', N'Requisito', N'Interface', N'Orientação da Tela', N'A aplicação deve notificar o usuário antes de alterar a orientação da tela, caso seja apropriado modificá-la.', N'Não informar a mudança na orientação da tela pode atrapalhar a interação, pois o usuário com deficiência visual precisará explorar a tela novamente por causa da mudança de posicionamento dos componentes. Além disso, há a possibilidade de acionar componentes erroneamente, o que pode causar até a perda de dados.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (50, N'GDAMA     ', N'R06       ', N'Requisito', N'Interface', N'Leitura', N'A aplicação deve usar linguagem adequada ao contexto do usuário.', N'Não utilizar termos técnicos ou em outra língua, que não façam parte do conhecimento popular do público-alvo da aplicação.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (51, N'GDAMA     ', N'R07       ', N'Requisito', N'Interface', N'Leitura', N'Todos os componentes da interface devem possuir rótulos.', N'Certifique-se que todos os elementos visuais (incluindo componentes não-textuais) da interface da aplicação estejam rotulados na implementação do código, para que os componentes sejam devidamente identificados pelo usuário com deficiência visual.
Exemplo: Ler "home_activity" ao invés do correto, "Tela inicial".', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (52, N'GDAMA     ', N'R08       ', N'Requisito', N'Interface', N'Leitura', N'Os rótulos devem descrever a funcionalidade ou significado e o estado dos componentes da interface de forma clara, sucinta e completa.', N'Garantir que a descrição de conteúdo legendado expresse de forma clara, sucinta e completa a funcionalidade ou significado dos elementos da tela. Ex.: "S-Planner – Agenda", "Botão Voltar", "Campo ‘Inserir seu nome‘".', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (53, N'GDAMA     ', N'R09       ', N'Requisito', N'Interface', N'Leitura', N'A aplicação deve fornecer as informações textuais ou numéricas contextualizadas para o conversor de texto para voz.', N'As leituras devem ser feitas levando em consideração o contexto da informação, conduzindo o usuário a assimilá-la, de forma fácil e rápida.
Exemplo: Para um número de telefone, ler os números um por vez e não por extenso - Ler Nove, Oito, Oito... ao invés de Novencentos e oitenta e oito milhões... para 988764000".', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (54, N'GDAMA     ', N'R10       ', N'Requisito', N'Interface', N'Leitura', N'Os componentes não-textuais devem ser nomeados de forma que sejam compreendidos independente do contexto.', N'Os componentes não-textuais aqui abordados são aqueles representados geralmente por alguma imagem característica, como um "+" para adicionar algo ou uma "casa" para indicar a tela inicial da aplicação. Caso o componente possua alguma especificidade, não indicá-la pode deixar o usuário confuso sobre a funcionalidade que representa.
Exemplo: Ao invés de "Botão Salvar", utilizar "Botão Salvar Usuário" (em uma tela de cadastro de usuário) e "Botão Salvar Cartão" (em uma tela de cadastro de cartão).', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (55, N'GDAMA     ', N'R11       ', N'Requisito', N'Interface', N'Leitura', N'O rótulo dos componentes com itens sequenciais e/ou paginados deve informar o intervalo que está sendo mostrado e o número total de itens.', N'Informar e identificar a ordenação das informações e componentes listados e/ou sequenciais, colabora para que o usuário não deixe de percebê-los durante a interação.
Exemplo: "Página 01 de 03", "Cinco itens listados", "Item 1 de 5".', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (56, N'GDAMA     ', N'R12       ', N'Requisito', N'Interface', N'Leitura', N'Todas as imagens e figuras da interface da aplicação devem possuir uma audiodescrição.', N'A audiodescrição é utilizada para descrever o conteúdo de uma imagem, como se fosse uma narração. Para isso, deve ser definido o texto que será lido pelo leitor de telas no código da aplicação.
Esse recurso só deve ser implementado para as imagens do próprio aplicativo, excluindo assim arquivos recebidos de outras aplicações.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (57, N'GDAMA     ', N'R13       ', N'Requisito', N'Interface', N'Área de Toque', N'A área de toque dos componentes da interface deve ter tamanho e espaçamento que facilitem a interação do usuário.', N'Para garantir o equilíbrio entre densidade e usabilidade, a Google recomenda que componentes de toque devem ter no mínimo 48 x 48 dp (Density-independent Pixels - uma unidade abstrata baseada na densidade física da tela. Essas unidades são relativas à tela de 160 dpi). Na maioria dos casos, deve existir um espaçamento de pelo menos 8dp entre eles. Esses componentes devem ter um tamanho físico de aproximadamente 9mm, sendo que o tamanho recomendado em telas de toque é entre 7 e 10 mm.
(Métricas recomendadas pela Google)', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (58, N'GDAMA     ', N'R14       ', N'Recomendação', N'Interface', N'Organização', N'Os componentes da interface das funções mais importantes/utilizadas devem estar situados próximos das extremidades da tela.', N'Usuários com deficiência visual tendem a procurar botões nas extremidades da tela, em especial na área superior da interface.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (59, N'GDAMA     ', N'R15       ', N'Recomendação', N'Interface', N'Organização', N'Cada tela da interface deve conter a menor quantidade de componentes de interação possível.', N'Quanto mais componentes na tela, mais tempo de exploração será necessário para que o usuário com deficiência visual assimile a tela. Além disso, há o risco do usuário não perceber algum componente.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (60, N'GDAMA     ', N'R16       ', N'Recomendação', N'Interface', N'Organização', N'Listas suspensas devem estar situadas na metade superior da tela.', N'Quando a lista suspensa está localizada no fim da tela, nem todos os itens são exibidos. Além disso a "janela" aberta com os itens pode ficar muito pequena. Desta forma, a aplicação dos gestos necessários para acessá-los (rolar a tela e gesto tab) necessita de muita precisão, o que traz bastante dificuldade para pessoas que não enxergam.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (61, N'GDAMA     ', N'R17       ', N'Requisito', N'Interface', N'Organização', N'Componentes de interação devem ter o espaçamento mínimo em relação à borda da tela.', N'Componentes localizados muito próximos aos limites da tela podem levar o usuário com deficiência visual a ter dificuldade de acessá-los, ou mesmo fazer com que toque erroneamente em outros componentes.
Exemplo: Posicionar determinado componente no limite inferior da tela pode fazer o usuário tocar involuntariamente nos botões físicos do dispositivo, executando ações não esperadas, como voltar para a tela anterior ao clicar no botão "Voltar".', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (62, N'GDAMA     ', N'R18       ', N'Recomendação', N'Interface', N'Área de Toque', N'Componentes de interação devem manter tamanhos similares na mesma tela.', N'Devido à exploração por toque, interfaces com componentes de tamanhos variados colaboram para que usuários com deficiência visual não percebam os menores, sobretudo quando entre componentes grandes.
No caso, usuários com perda parcial da visão, normalmente tocam em componentes grandes, que chamam mais sua atenção em detrimento dos menores.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (63, N'GDAMA     ', N'R19       ', N'Recomendação', N'Interface', N'Organização', N'A interface da aplicação com grande quantidade de informações deve ser estruturada em forma de lista ordenada.', N'ara facilitar a exploração dos itens deve ser usado um critério de ordenação para apresentação dos dados que melhor se adeque ao contexto da tela.
Exemplo: Ordem alfabética, númerica, crescente/decrescente, recente/antigo, etc.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (64, N'GDAMA     ', N'R20       ', N'Recomendação', N'Interface', N'Organização', N'Componentes de formulários devem ser distribuídos um item por linha, evitando o uso de múltiplas colunas numa mesma linha.', N'Usuários com deficiência visual, sobretudo com perda total da visão, que exploram a tela deslizando o dedo (varrendo a tela) costumam fazê-lo de cima para baixo, em linha reta. Desse modo, se uma linha tiver mais de um componente, pode ser que o usuário não identifique um deles.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (65, N'GDAMA     ', N'R21       ', N'Requisito', N'Interface', N'Organização', N'A barra de ferramentas deve permanecer fixa em telas de rolagem.', N'Usuários com deficiência visual se valem da memória para localizar componentes. Logo ocultar a barra durante a interação pode deixá-lo confuso sobre a estrutura da tela.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (66, N'GDAMA     ', N'R22       ', N'Recomendação', N'Interface', N'Leitura', N'Componentes com textos devem ser curtos e concisos, sempre que possível.', N'A escuta de textos longos é cansativa para os usuários com deficiência visual. Por isso, aplicações que precisam oferecer algum texto longo, devem ter ele dividido em blocos, de modo que o usuário possa lê-lo por partes e, da mesma forma, recomeçar a leitura sem que seja do início.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (67, N'GDAMA     ', N'R23       ', N'Recomendação', N'Interface', N'Padrão de Interface', N'As telas da aplicação devem seguir a mesma identidade visual e manter o mesmo padrão de layout.', N'Manter a mesma identidade visual ao longo de toda a aplicação faz com que a aplicação seja previsível, facilitando o aprendizado do usuário.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (68, N'GDAMA     ', N'R24       ', N'Requisito', N'Interface', N'Padrão de Interface', N'A localização dos componentes deve seguir padrões amplamente utilizados.', N'O uso de padrões ajuda os usuários com deficiência visual a localizarem os componentes reduzindo assim a carga de memorização durante a exploração, bem como acelerando o aprendizado e a interação do usuário com a aplicação.
Exemplo: botão "Salvar" no canto superior direito.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (69, N'GDAMA     ', N'R25       ', N'Requisito', N'Interface', N'Padrão de Interface', N'Os componentes de formulários devem seguir o mesmo padrão.', N'A aplicação deve manter um padrão de apresentação entre o label e o componente a ser preenchido, selecionado ou marcado. O mais comum para usuários com deficiência visual é primeiro o label e logo abaixo o componente referenciado por ele.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (70, N'GDAMA     ', N'R26       ', N'Recomendação', N'Interação', N'Tempo de Interação', N'A aplicação deve manter a tela ativa por tempo ilimitado quando o leitor de tela estiver ativo.', N'Manter a tela ativa facilita a interação do deficiente visual com funcionalidades que exigem um tempo de leitura maior, como execução de videos e/ou apresentação de textos longos.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (71, N'GDAMA     ', N'R27       ', N'Recomendação', N'Interação', N'Ajuda', N'A aplicação deve oferecer recursos que reduzam o esforço do usuário.', N'Como por exemplo, a função autocomplete, utilizar comandos de voz e busca por voz.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (72, N'GDAMA     ', N'R28       ', N'Requisito', N'Interação', N'Teclado', N'O teclado utilizado pela aplicação deve ser compatível com o contexto do campo.', N'A depender do tipo de dado a ser preenchido, a aplicação deve oferecer o teclado mais adequado.
Exemplo: Em campos em que o valor a ser inserido seja um email, oferecer um teclado com as teclas arroba (@) e ".com".', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (73, N'GDAMA     ', N'R29       ', N'Requisito', N'Interação', N'Teclado', N'O teclado utilizado pela aplicação deve conter teclas que permitam a navegação entre os componentes da interface.', N'presentar no teclado o botão de navegação entre os campos de um formulário facilita a navegação entre eles, e consequentemente o preenchimento dos campos.
Exemplo: inserir botão "Prox." quando o próximo campo é de entrada de dados.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (74, N'GDAMA     ', N'R30       ', N'Recomendação', N'Interação', N'Tempo de Interação', N'Componentes de interação devem se manter na tela independente da funcionalidade que estiver em uso.', N'Esconder componentes, principalmente em funcionalidades que não necessitam uma interação ativa do usuário com deficiência visual, como a execução de videos ou apresentação de textos longos, pode deixá-lo confuso sobre a estrutura da tela. Além disso uma nova exploração da tela será necessária para encontrar os componentes.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (75, N'GDAMA     ', N'R31       ', N'Requisito', N'Interação', N'Feedback', N'O leitor de telas deve informar ao usuário todos os eventos visíveis.', N'Usuários com perda parcial da visão normalmente se utilizam do resquício de visão que possuem para interagir com aplicativos. Por isso, é necessário que mesmo com o uso de leitor de telas, haja estímulos visuais sobre o que estiver ocorrendo na aplicação.
Exemplo: O usuário deve ser informado sobre a conclusão correta do preenchimento de um formulário.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (76, N'GDAMA     ', N'R32       ', N'Requisito', N'Interação', N'Feedback', N'O leitor de telas deve informar o conteúdo de um componente assim que tocado, interrompendo qualquer leitura em andamento.', N'Deslizar o dedo na tela é uma das formas mais comuns de explorar a interface. Dessa forma, quando a leitura de um componente é interrompida, significa que o usuário está tocando outro componente. Caso a leitura não seja interrompida, o usuário concluirá que a tela não tem outros componentes tocáveis. Isso pode fazer com que componentes importantes na tela não sejam notados.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (77, N'GDAMA     ', N'R33       ', N'Requisito', N'Interação', N'Feedback', N'A aplicação deve fornecer feedback sonoro sobre todas as ações executadas pelo usuário', N'É necessário informar o resultado das ações do usuário para que ele não tente executá-la novamente sem necessidade. Esses feedbacks também podem ser realizados através de sons característicos de algumas operações, por exemplo, para indicar uma confirmação.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (78, N'GDAMA     ', N'R34       ', N'Requisito', N'Interação', N'Feedback', N'A aplicação deve fornecer feedback visual sobre todas as ações executadas pelo usuário.', N'Usuários com perda parcial da visão devem ser informados visualmente do resultado das ações que realiza.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (79, N'GDAMA     ', N'R35       ', N'Requisito', N'Navegação', N'Atalho', N'As telas da aplicação, exceto popups (pequenas janelas que se abrem por cima da tela sendo visualizada), devem disponibilizar link para a tela principal do aplicativo.', N'Buscar a tela inicial da aplicação é um comportamento comum para usuários com deficiência visual quando se deparam com situações adversas durante a interação, como quando perdem a referência de qual tela da aplicação está sendo mostrada.
Normalmente esse link pode estar representado por um botão "Home", ou mesmo dentro de um menu de gaveta (ou sanduíche).', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (80, N'GDAMA     ', N'R36       ', N'Requisito', N'Navegação', N'Atalho', N'As telas da aplicação devem disponibilizar o botão "Voltar" para a tela anteriormente acessada pelo usuário.', N'O botão "Voltar" é muito utilizado por usuários com deficiência visual quando possuem alguma dificuldade na interação com a aplicação. Ele é utilizado para que o usuário volte até uma tela que conhece, ou mesmo para cancelar uma ação para fazê-la novamente.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (81, N'GDAMA     ', N'R37       ', N'Recomendação', N'Navegação', N'Atalho', N'As telas da aplicação devem oferecer atalhos para suas principais funcionalidades.', N'Usuários com deficiência visual podem ter dificuldades para encontrar os componentes referentes às funcionalidades principais da aplicação. Sendo assim, uma das formas de minimizar esse problema é disponibilizar atalhos para as funcionalidades que se espera que sejam mais utilizadas.
Exemplo: FAB, menu.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (82, N'GDAMA     ', N'R38       ', N'Requisito', N'Navegação', N'Organização', N'A aplicação deve oferecer uma navegação sequencial entre as telas.', N'Plataformas móveis, como o Android, utilizam o desempilhamento de telas. Contudo, para pessoas que não enxergam, é necessário que a aplicação utilize o desempilhamento "semântico", onde a pilha é limpa quando o usuário chega à tela inicial. Caso contrário, o usuário deixa de ter esse referencial, podendo ficar confuso.
Exemplo: Navegando pelo aplicativo o usuário pode passar algumas vezes pela tela inicial. Utilizando o botão "Voltar", o aplicativo só deve permitir que o usuário volte até a tela inicial, não antes dela.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (83, N'GDAMA     ', N'R39       ', N'Requisito', N'Navegação', N'Foco', N'A aplicação deve suportar a navegação baseada em foco.', N'Para explorar a tela, é comum que usuários com deficiência visual utilizem o gesto "tab". Desta forma, a aplicação deve garantir que todos os componentes possam receber o foco, bem como que a ordem dele seja de cima para baixo e da esquerda para a direita.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (84, N'GDAMA     ', N'R40       ', N'Requisito', N'Navegação', N'Feedback', N'A aplicação deve informar possíveis erros de interação ao usuário.', N'A aplicação deve informar erros ocorridos durante a interação, evitando repetições, frustrações ou mesmo a desistência do uso decorrente de não entender o que está ocorrendo com a aplicação.
Exemplo: Quando o usuário salvar um formulário de cadastro com campo obrigatório não preenchido, informá-lo da ação. Assim que o usuário confirmar que visualizou a notificação do erro, alterar o foco para o campo que está faltando.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (85, N'GDAMA     ', N'R41       ', N'Requisito', N'Navegação', N'Ajuda', N'A aplicação deve guiar o usuário no primeiro uso.', N'Realizar um tutorial a respeito da finalidade do aplicativo e suas principais funções durante o primeiro uso pode minimizar problemas de interação proporcionados.
No vídeo ao lado, o usuário nunca havia aberto o aplicativo Google Agenda em seu aparelho. Por isso, em seu primeiro uso, o aplicativo explica suas principais funções através de um tutorial dividido em 4 telas.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (86, N'GDAMA     ', N'R42       ', N'Recomendação', N'Navegação', N'Ajuda', N'As telas da aplicação devem disponibilizar a opção de ajuda referente ao seu conteúdo e funcionalidades.', N'Para evitar que usuários com deficiência visual desistam de utilizar a aplicação por não entendê-la ou não achar alguma funcionalidade, a aplicação deve diponibilizar, sempre que possível, um botão de ajuda que descreva as principais funções daquela interface.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (87, N'GDAMA     ', N'R43       ', N'Recomendação', N'Navegação', N'Ajuda', N'As telas da aplicação devem disponibilizar a opção de busca quando possuírem grande quantidade de informações.', N'A rolagem em telas com muitos itens pode ser extremamente desgastante. Logo, disponibilizar a opção de busca contribui com a redução de esforço do usuário.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (88, N'GDAMA     ', N'R44       ', N'Requisito', N'Navegação', N'Ajuda', N'A aplicação deve fornecer instruções de preenchimento dos campos de entrada de dados.', N'A aplicação deve fornecer dicas de preenchimento dos campos para evitar que aumente a carga de interação do usuário com deficiencia visual devido a entrada de valores incorretos.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (89, N'GDAMA     ', N'R45       ', N'Requisito', N'Outros', N'Configuração', N'A aplicação deve sugerir a ativação de configurações de acessibilidade dos dispositivos móveis ao usuário em seu primeiro acesso.', N'Há algumas particularidades do público alvo que podem ser atendidas com a ativação de opções de acessibilidade além do leitor de telas.
Exemplo: Quando a aplicação possuir plano de fundo branco (ou de tons claros), sugerir a ativação da opção de acessibilidade "Cores negativas", para contemplar usuários com fotofobia.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (90, N'GDAMA     ', N'R46       ', N'Requisito', N'Outros', N'Configuração', N'A aplicação deve permitir que o usuário configure suas formas de notificação.', N'Notificações constantes durante a interação tendem a desviar a atenção do usuário com deficiência ao ter sua leitura se sobrepondo ao feedback em andamento. Logo, permitir que o usuário configure como será notificado evitará essa situação.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (91, N'GDAMA     ', N'R47       ', N'Requisito', N'Interação', N'Organização', N'Componentes de interação em telas com grandes textos devem estar fixos e visíveis.', N'Exemplo: Telas com textos longos que exijam confirmação para prosseguir, devem manter o componente da confirmação em um local fixo e de fácil acesso.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (92, N'GDAMA     ', N'R48       ', N'Recomendação', N'Interação', N'Feedback', N'A aplicação deve fornecer feedback sonoro quando o usuário tentar executar a rolagem em situações onde não é possível.', N'Para se certificar que passou por todo o conteúdo de uma tela, o usuário com perda total da visão costuma executar o gesto de rolar a tela. Desta forma, um feedback sonoro auxilia o usuário a entender melhor a interface.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (93, N'NBR17060  ', N'5.1.1.1   ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para elementos não textuais', N'Elementos não textuais devem ter um texto alternativo que descreva o seu significado.
Elementos não textuais, como imagens, cujo significado é essencial para a compreensão do que é exibido na tela, devem ter uma alternativa textual a ser interpretada por recursos de tecnologia assistiva. Elementos meramente decorativos devem ser ignorados por recursos de tecnologia assistiva.
EXEMPLO	Foto de um resgate em uma notícia descreve a cena exibida na imagem', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (94, N'NBR17060  ', N'5.1.1.10  ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendações para posicionamento de elementos de interface', N'Recomenda-se que o posicionamento de elementos de interface siga padrões amplamente utilizados.
Priorizar o uso de padrões e convenções no posicionamento dos elementos de interface. Desta forma, as cargas cognitivas e de memorização requeridas do usuário são menores, facilitando o aprendizado e a interação, e diminuindo a ansiedade.
EXEMPLO Botões “enviar” e “cancelar” em um formulário seguem a ordem amplamente utilizada (primeiro o botao “enviar” e depois o botao “cancelar”) tanto para navegação visual quanto por recursos de tecnologia assistiva.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (95, N'NBR17060  ', N'5.1.1.11  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para rótulos de campos de formulário', N'Os rótulos de formulários devem ser posicionados adjacentemente ao seu respectivo campo. Em campos de formulário gerais, como os de entrada de textos e/ou números, o rótulo deve ser posicionado antes do campo, ou seja, à esquerda ou acima. Em formulários de botão de rádio (radio button) e caixas de marcação (checkboxes), os rótulos devem estar após as respectivas opções, à direita. A ordem destes itens no código deve coincidir com a ordem visual, para manter a experiência independentemente da forma de navegaçao do usuário. Esse tipo de posicionamento melhora a previsibilidade da leitura do formulário, usando visao e tecnologias assistivas, além de evitar desalinhamentos acidentais.
EXEMPLO	O rótulo “nome” vem antes do campo de formulário que requer esse dado do usuário.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (96, N'NBR17060  ', N'5.1.1.12  ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendações para organização de componentes de formulários', N'Recomenda-se que os componentes de formulários sejam distribuídos um por linha na tela.
Evitar o uso de mais de um componente de formulário por linha em uma aplicação. Vários componentes agrupados em linha podem se desalinhar ou desaparecer da tela, podendo não ser perceptíveis ou operáveis pelo usuário, quando usados em um tamanho de tela diferente do projetado ou se for aplicado zoom.
EXEMPLO 1	Campo CEP vem abaixo do campo de endereço em um formulário.
EXEMPLO 2 Dois botões são apresentados na mesma linha e permanecem visíveis independentemente do tamanho da tela do dispositivo ou se o zoom for aplicado.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (97, N'NBR17060  ', N'5.1.1.13  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para determinação de tipo de campos de formulários', N'Os campos de formulários devem ter seu tipo determinado com base na necessidade de entrada.
Deve ser especificado o tipo de campo para a entrada de dados de acordo com a finalidade deste campo. Especificar o tipo de campo de formulário por meio de código de programaçao oferece uma experiência melhor para o usuário.
EXEMPLO 1 Declarar como campos numéricos permite que um teclado apenas numérico seja exibido para o preenchimento do usuário.
EXEMPLO 2	Em campos do tipo ‘e-mail’ o teclado exibirá o símbolo @ para facilitar o preenchimento.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (98, N'NBR17060  ', N'5.1.1.14  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para instruções de preenchimento de entrada de dados', N'Deve haver instruções de preenchimento de entrada de dados.
Campos de entrada de dados devem ter, além do seu rótulo, instruções de preenchimento relacionadas com o tipo de dados exigidos para entrada, de forma que o usuário possa perceber. Essa técnica é importante para evitar que o usuário cometa erros durante o preenchimento do formulário. Isto pode tomar forma como (mas não se limitando a) de “marcadores de posição” (placeholder), etiqueta, parágrafos ou instruções prévias. Na dúvida, deve-se ser redundante.
EXEMPLO Um campo de data exibe o formato exigido de entrada dia/mês/ano. ', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (99, N'NBR17060  ', N'5.1.1.15  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para indicar o foco de navegação', N'Deve haver indicador de foco de navegaçao.
Os aplicativos devem permitir que recursos de tecnologia assistiva que suportam indicador de loco visível em navegaçao sequencial, como leitores de tela, exibam esse indicador adequadamente.
EXEMPLO Uma pessoa com baixa visao, dislexia ou baixa alfabetização que utiliza um leitor de tela para navegar por um aplicativo consegue identificar visualmente em qual posiçao da tela o foco está.
', NULL, N'S')
GO
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (100, N'NBR17060  ', N'5.1.1.16  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para elementos de interface de itens em sequência', N'Os elementos de interface de itens em sequência ou que exigem paginação devem situar o usuário.
Deve ficar claro para o usuário a quantidade de etapas, o intervalo mostrado, o seu posicionamento atual e o número de itens totais quando uma açao exige interaçao em itens sequenciais.
EXEMPLO Um formulário dividido em três etapas (dados pessoais, endereço residencial e endereço comercial) exibe de forma clara ao usuário a etapa atual de preenchimento e quantas etapas restantes ele ainda tem.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (101, N'NBR17060  ', N'5.1.1.17  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para contraste de textos e elementos gráticos', N'Os textos e elementos gráficos devem ter contraste suficiente com seus respectivos planos de fundo.
Deve haver contraste mínimo entre os textos e seus respectivos planos de fundo. Também deve haver contraste mínimo entre os elementos gráficos relevantes e seus respectivos planos de fundo e/ou entornos. As taxas de contraste devem estar em conformidade minima com os critérios de sucesso nível AA do WCAG 2.1. Elementos interativos no estado desabilitado não precisam cumprir requisitos de contraste. Elementos gráficos meramente decorativos e logotipos também estão isentos.
EXEMPLO 1 Um fundo claro é escolhido para que as letras de cores escuras possam ser lidas na tela de uma aplicaçao.
EXEMPLO 2	Um botao tem bordas escuras em um plano de fundo claro, para que seja facilmente percebido. ', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (102, N'NBR17060  ', N'5.1.1.18  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para uso da cor', N'Qualquer elemento de interface do usuário que dependa de cor para a sua compreensão deve ter uma outra forma de compreensão que não dependa apenas da cor.
EXEMPLO 1 Botões de “cancelar” e “enviar” um formulário utilizam as cores vermelha e verde, mas também possuem um rótulo acessível.
EXEMPLO 2 Em uma lista de produtos, itens na cor vermelha são os que estão sem estoque e, além da cor, há também o texto “sem estoque”.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (103, N'NBR17060  ', N'5.1.1.19  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos relacionados a características sensoriais do usuário', N'Não podem existir instruções que dependem somente das características sensoriais do usuário.
As instruções fornecidas para compreender e utilizar o conteúdo não podem depender somente das características sensoriais dos elementos de interface, como forma, cor, tamanho, localização visual, orientação ou som.
EXEMPLO  Um botão para enviar um formulário é destacado com a cor verde e possui o rótulo “enviar formulário”. Na aplicação, quando ele é mencionado, é referenciado como “botão enviar formulário”.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (104, N'NBR17060  ', N'5.1.1.2   ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendação para textos em vez de imagens', N'Recomenda-se que sejam usados textos em vez de imagens.
Sempre que possível, os textos devem ser codificados como textos propriamente ditos, e não feitos na forma de imagem, pois o formato texto pode ter sua exibição e formatação ajustadas pelo usuário por meio de recursos variados.
Essa orientação não se aplica aos logotipos e a outras situações em que seja essencial usar imagens para atingir a apresentação visual pretendida.
EXEMPLO 1 Um banner de produtos tern uma foto em destaque e, na parte inferior, há um texto com o nome do produto. Esse texto não está embutido na imagem e pode ser selecionado ou customizado pelo usuário.
EXEMPLO 2 O cabeçalho de nível de uma tela está formatado como texto, de acordo com o desejado pela equipe que o desenvolveu, usando fonte, estilo, cor e tamanho suportados pela tecnologia.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (105, N'NBR17060  ', N'5.1.1.20  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para retorno (feedback) fornecido pela aplicação', N'Todo retorno (feedback) fornecido pela aplicação deve ser percebido por todos os usuários e por recursos de tecnologia assistiva.
Ações de interação do usuário, como o acionamento de botões e elementos interativos, devem fornecer um retorno (feedback) perceptível a todos os usuários. Esse retorno (feedback) pode ser visual, mas também deve oferecer alternativas para os usuários de tecnologia assistiva.
EXEMPLO Uma janela de alerta é exibida para o usuário com informações sobre um erro. Essa janela contém uma mensagem visual e também é lida por usuários de leitores de tela.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (106, N'NBR17060  ', N'5.1.1.21  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para saída ou retorno perceptível a todos os usuários', N'A aplicação deve fornecer uma forma de saída ou retorno perceptível a todos os usuários. O usuário deve ter formas de retornar ou voltar para as telas anteriores de forma intuitiva.
EXEMPLO 1	Um modal ou pop-up tem um botão em forma de X que é programaticamente perceptível, tern
um gesto associado e também o uso da tecla “esc” de um teclado, com a função fechar.
EXEMPLO 2 Uma página permite o uso do botão “voltar” do dispositivo ou disponibiliza um botão para voltar para a tela anterior.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (107, N'NBR17060  ', N'5.1.1.22  ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendações para ações indisponíveis, inativas ou proibidas', N'Recomenda-se que todas as tentativas de ações indisponíveis, inativas ou proibidas tenham feedback
ou retorno percebido por todos os usuários e por recursos de tecnologia assistiva.
Alguns usuários podem não perceber quando chegaram ao final de uma tela de aplicação ou ao tentar acionar um botão inativo. Essa orientação tem como objetivo alertar o usuário de que a ação que ele está tentando executar não é possível naquele momento.
EXEMPLO O fim da barra de rolagem exibe uma mensagem ou sinal sonoro informando ao usuário que ele atingiu o final da página.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (108, N'NBR17060  ', N'5.1.1.23  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para título de páginas e aplicações', N'Em páginas web acessadas pelo navegador, isso geralmente é feito pelo elemento HTML <titIe>. Para o caso de aplicação web, híbrida ou nativa, deve-se seguir a documentação da tecnologia aplicada, sendo o nome dessa aplicação o suficiente para atender a esta orientação. Esta informação deve ser interpretada corretamente por tecnologias assistivas, como um leitor de tela, ao navegar entre diferentes abas de um navegador web ou aplicativos abertos simultaneamente no aparelho.
EXEMPLO 1 A página inicial de um jornal tem um título que a identifica. O usuário está com várias abas abertas simultaneamente no seu navegador e consegue localizar entre elas qual é a aba do jornal, optando por abri-la.
EXEMPLO 2 Quando o usuário toca em um ícone de calculadora com o leitor de tela ligado, é informado o nome do aplicativo ao acessá-lo.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (109, N'NBR17060  ', N'5.1.1.24  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para idiomas da aplicação e das partes', N'Os idiomas da aplicação e das partes devem ser declarados.
A declaração do idioma deve ser feita dentro do código-fonte da aplicação, conforme a especificação da tecnologia utilizada para o seu desenvolvimento. Caso ocorra mudança de idioma na mesma tela da aplicação, o código de idioma também deve ser declarado, exceto nomes próprios, vocabulário técnico e palavras ou frases estrangeiras que são parte do vocabulário nacional. Essa técnica permite que tanto o sistema operacional quanto o recurso de tecnologia assistiva identifiquem o idioma e apresentem o conteúdo ao usuário de forma compreensível. A forma de declaração do idioma pode mudar, dependendo da tecnologia de desenvolvimento da aplicação.
EXEMPLO 1 Uma aplicação em português tem seu idioma declarado no seu código-fonte como português do Brasil.EXEMPLO 2 Uma aplicação possui uma caixa de texto chamada “disclaimer”. Esta palavra tem seu idioma declarado no seu código-fonte como inglês dos Estados Unidos da América.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (110, N'NBR17060  ', N'5.1.1.25  ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para elementos piscantes', N'Caso existam elementos em tela que piscam três vezes ou mais por segundo, o usuário deve ser avisado com antecedência para que possa evitar a visualização deste tipo de conteúdo. Caso seja tecnicamente possível, deve haver uma função para desabilitar os elementos piscantes. Elementos piscantes podem deixar os usuários desorientados, confusos ou causar desconforto e convulsões em pessoas com fotossensibilidade.
NOTA	Caso não haja conteúdo piscante, este requisito está automaticamente cumprido.
EXEMPLO Um jogo tem uma área que pisca apenas em pequenas áreas e por curto período de tempo. O usuário é avisado disso antes de iniciar o jogo e recebe uma opção para remover ou adaptar de forma inteligente esse tipo de conteúdo.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (111, N'NBR17060  ', N'5.1.1.26  ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendações para funcionalidasdes de interface durante o primeiro uso', N'Recomenda-se que a aplicação ofereça ao usuário orientação sobre as funcionalidades de interface
durante o primeiro uso ou quando desejado.
Uma maneira mais dinâmica de apresentar o usuário a uma nova interface ou ajudá-lo durante a execução de uma tarefa em uma interface é por meio de um roteiro guiado (guided tour) ou de um assistente de execução (wizard).
EXEMPLO  No primeiro uso de uma aplicação, um breve tutorial é exibido na tela, apresentando as principais funcionalidades da aplicação e os recursos de acessibilidade.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (112, N'NBR17060  ', N'5.1.1.27  ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendações para linguagem', N'Recomenda-se que seja usada linguagem simples e clara.
Não é indicado utilizar termos técnicos ou em outro idioma, que não façam parte do conhecimento popular do público-alvo da aplicação. A aplicação deve utilizar termos simples no idioma nativo para o maior número de pessoas e adequados ao contexto do usuário
EXEMPLO Em um aplicativo voltado para médicos, os termos médicos seriam considerados comuns, mas não em uma aplicação direcionada ao público em geral.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (113, N'NBR17060  ', N'5.1.1.28  ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendações para textos', N'Recomenda-se que os textos sejam curtos e concisos. A escuta ou o acompanhamento de textos longos podem ser cansativos e de difícil leitura para alguns usuários. Por isso, se a aplicação apresentar textos longos, recomenda-se dividi-los em blocos, com a devida marcação por meio de código, de modo que o usuário possa ler por partes e recomeçar a leitura por estes blocos.
EXEMPLO  Um contrato de termos de uso tem parágrafos curtos e definidos por meio de código de programação.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (114, N'NBR17060  ', N'5.1.1.3   ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendação para elementos decorativos e atenção do usuário', N'Recomenda-se que não sejam usados elementos meramente decorativos que possam tirar a atenção do usuário durante a execução da tarefa.
EXEMPLO Enquanto um usuário preenche um formulário de contato, nenhum movimento, som ou elemento decorativo atrapalha o seu preenchimento.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (115, N'NBR17060  ', N'5.1.1.4   ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para elementos interativos e de interface do usuário', N'Elementos interativos e de interface do usuário devem ter rótulos que descrevem o elemento, sua funcionalidade, estado ou operaçao.
Elementos de interface interativos, como botões e campos de formulário, devem conter um rótulo que descreve a sua função. Os rótulos devem estar relacionados com o elemento por meio de código de programação. Nem todos os elementos possuem todas essas características, mas eles devem ser compreensíveis para a operaçao do usuário.
EXEMPLO Um campo de formulário que exige o nome do usuário precisa ter um rótulo “Nome” relacionado ao campo que exige a entrada de texto.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (116, N'NBR17060  ', N'5.1.1.5   ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para cabeçalhos e rótulos', N'A aplicação deve estar estruturada por meio de elementos de cabeçalho em títulos de seção e rótulos em campos de entradas de dados, permitindo que usuários de tecnologia assistiva compreendam melhor sua organização. O uso desses recursos possibilita a localização do conteúdo de forma mais rápida.
EXEMPLO Uma aplicação utiliza cabeçalhos para separar as principais áreas exibidas na tela e rótulos que descrevem o que é exigido nos campos interativos.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (117, N'NBR17060  ', N'5.1.1.6   ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para organização de elementos funcionais e nomes acessíveis', N'Deve ser mantida a mesma organização de elementos funcionais e nomes acessíveis ao longo de toda a aplicação.
Os elementos funcionais devem manter-se na mesma posiçao e com a mesma descrição acessível. Isso facilita a compreensao e acelera o aprendizado do usuário.
EXEMPLO  Blocos de controle e menus mantêm a mesma ordem relativa em todas as telas em que aparecem.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (118, N'NBR17060  ', N'5.1.1.7   ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para nomes acessíveis', N'Os nomes acessíveis devem conter os rótulos dos elementos.
Para os elementos que possuam rótulos em texto ou imagens de texto, o nome acessível deve conter todo o rótulo. Sempre que possível, o texto do rótulo deve estar no começo do nome acessível.
NOTA 1 O rótulo é apresentado a todos os usuários, enquanto o nome acessível pode estar oculto e ser disponibilizado apenas para os recursos de tecnologia assistiva. Em alguns casos, o nome acessível e o rótulo são os mesmos.
NOTA 2 Programaticamente, na existência de um rótulo e na ausência de um nome acessível, geralmente assume-se que o rótulo seja o nome acessível e, assim, este requisito é automaticamente cumprido.
EXEMPLO Uma interface com várias seções, sendo uma para cada produto, tern um botao para contratação. O rótulo de todos os botões é o mesmo (“contratar"). Contudo, o nome acessível de cada um traz também a identificação do produto, como “contratar produto A”, “contratar produto B”.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (119, N'NBR17060  ', N'5.1.1.8   ', N'Requisito', N'Percepção e compreensão', NULL, N'Requisitos para descrição de elementos de interface interativos', N'Elementos de interface interativos devem descrever sua funcionalidade de forma clara, para a compreensao mesmo fora do contexto.
Elementos como botões, links e ícones devem ser compreendidos mesmo fora do contexto. Esses elementos devem ter atributos ou alternativas textuais que descrevem sua funcionalidade aos usuários de tecnologia assistiva. Em caso de elementos que se repetem na interface, cada um deles deve fazer referência a qual objeto ou contexto a ação ou funcionalidade está relacionada.
EXEMPLO Um ícone de uma “casa” que leva o usuário para a página inicial precisa de um texto alternativo “voltar para o início”. Uma imagem “+” precisa ter o texto alternativo “Botão Adicionar Despesa” (em uma tela de cadastro de despesas).
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (120, N'NBR17060  ', N'5.1.1.9   ', N'Recomendação', N'Percepção e compreensão', NULL, N'Recomendações para padrão visual ao longo de toda aplicação', N'Recomenda-se que seja mantido o mesmo padrao visual ao longo de toda a aplicação.
Evitar criar interfaces que mudam muito quando o usuário executa uma ação, pois isso pode dificultar a compreensao e tomar tempo até o usuário se acostumar com a nova interface.
EXEMPLO Uma tela inicial de uma aplicação utiliza o mesmo padrao visual das demais telas da aplicação. ', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (121, N'NBR17060  ', N'5.1.2.1   ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para configurações de acessibilidade', N'A aplicação não pode alterar as configurações de acessibilidade do usuário sem que ele seja notificado e concorde com a mudança.
EXEMPLO  Se o modo noturno do dispositivo do usuário estiver habilitado, a aplicação não desabilita essa função de forma automática.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (122, N'NBR17060  ', N'5.1.2.10  ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para alteração de contexto ao interagir com formulários', N'Não pode haver alteração de contexto inesperada ao interagir com formulários.
Interações com formulários devem ter efeitos previsíveis, ou seja, ao entrar ou editar dados em formulários, não pode ocorrer de forma automática uma alteração de contexto sem que o usuário tenha conhecimento prévio.
As alterações de contexto inesperadas podem deixar desorientados os usuários que não conseguem ter visibilidade completa da página.
NOTA  Botões e links, quando são acionados, iniciam alterações de conteúdos que podem ser alterações de contexto. Porém, como é do conhecimento do usuário que estes componentes tenham alguma ação/ reação, isso não se enquadra ao descrito acima.
EXEMPLO Ao selecionar um botão de rádio dentro de um formulário, o foco permanece no mesmo Iugar, sem fazer movimentações inesperadas.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (123, N'NBR17060  ', N'5.1.2.11  ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para alteração de contexto em elementos interativos', N'Não pode haver alteração de contexto inesperada ao focar em elementos interativos.
Nenhum tipo de alteração de contexto ocorre quando algum elemento de interface recebe foco. Assim, há garantia de previsibilidade de navegação na tela sobre componentes que possuem algum tipo de interação.
Um componente pode receber foco tanto com algum recurso de tecnologia assistiva (por exemplo, com a utilização de um leitor de tela) como sem recurso de tecnologia assistiva (tocar em um campo de formulário para ativar a digitação).
EXEMPLO 1 Em um formulário, ao tocar no último campo, este formulário não é submetido de forma automática, sem avisar o usuário que isso ocorre. Existe um botão “enviar” após o último campo.
EXEMPLO 2 Ao inserir dados em um campo de e-mail, a validação do campo e a mensagem de alerta correspondente são ativadas e informadas ao usuário apenas quando o botão “enviar” é ativado ou quando o campo sair de foco.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (124, N'NBR17060  ', N'5.1.2.12  ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para interação por toque', N'Toda interação deve ser suportada por um único toque na tela. Caso existam apps que exijam múltiplos toques ou gestos específicos, deve existir uma forma de permitir que o usuário consiga executar a mesma ação com toque único.
NOTA  Este requisito não se aplica aos gestos de controle dos agentes de usuário, como o deslizar (swipes) de leitores de tela e rolagem (scroll)  padrão na vertical.
EXEMPLO 1 Uma aplicação que exige a ligação entre dois pontos na tela por um caminho desenhado com o dedo também permite que o usuário conclua a ação tocando no ponto inicial e, em seguida, no final.
EXEMPLO 2 Uma aplicação que usa um “carrossel” de imagens e/ou blocos de texto que podem ser trocados com o deslizar do dedo pela tela pode ser acionada por botões nas laterais do carrossel para exibir a imagem seguinte ou a anterior.
EXEMPLO 3 Um mapa interativo que amplia com gesto de pinça executa a mesma ação quando o usuário dá dois toques rápidos no mapa ou possui botões de controle de zoom.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (125, N'NBR17060  ', N'5.1.2.13  ', N'Recomendação', N'Controle e interação', NULL, N'Recomendações para tamanho da área de toque', N'Recomenda-se que os elementos interativos tenham um tamanho mínimo de área de toque.
O tamanho da área de toque de elementos interativos deve ser grande o suficiente para serem lidos e acionados confortavelmente e com precisão. As dimensões mínimas devem seguir os critérios de sucesso nível AAA do WCAG 2.1. Se houver exigência técnica da especificação da tecnologia utilizada para o desenvolvimento da aplicação, esta deve ser seguida em vez do WCAG.
EXEMPLO  Um aplicativo tem botões com tamanhos e distância de outros botões suficientes para que o usuário não acione outros elementos interativos próximos de forma acidental.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (126, N'NBR17060  ', N'5.1.2.14  ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para navegação com recursos de tecnologias assistivas', N'Não pode haver bloqueio na navegação sequencial com recursos de tecnologia assistiva.
A aplicação deve permitir que tecnologias assistivas que utilizam navegação sequencial, normalmente pelo movimento rápido de deslizar o dedo (também conhecido como swipe), como um leitor de tela, percorram todo o conteúdo livremente sem ficar preso em ponto algum.
EXEMPLO  Um aplicativo permite que o leitor de tela interprete todo o conteúdo, item a item, de forma sequencial, conforme os comandos do usuário.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (127, N'NBR17060  ', N'5.1.2.15  ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para indicação e correção de erros de interação', N'A aplicação deve informar ao usuário os erros de interação e dar a oportunidade de corrigir o erro sem prejuízo do uso da aplicação.
As informações referentes aos erros do usuário devem ser claras, e a aplicação deve permitir a sua correção.
EXEMPLO  Um formulário que requer dados de um campo obrigatório que não foi preenchido exibe um aviso ao usuário sobre a necessidade do seu preenchimento e leva o foco do usuário para o respectivo campo, sem limpar os demais campos.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (128, N'NBR17060  ', N'5.1.2.16  ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para ampliação da tela', N'Deve haver suporte para ampliação da tela sem perda de informação ou funcionalidade.
Quando o usuário fizer ampliação da tela (zoom) em uma aplicação, ele não pode perder informação ou funcionalidade, como, por exemplo, elementos que ficam escondidos atrás de outros elementos de interface visuais.
EXEMPLO Quando o usuário amplia a tela, os elementos da aplicação se reorganizam para se adaptar ao novo tamanho de tela.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (129, N'NBR17060  ', N'5.1.2.17  ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para uso de comandos de voz', N'As aplicações que façam uso de comandos de voz devem permitir outra modalidade de comandos por meio de interface interativa.
Se uma aplicação utilizar comandos de voz para executar uma ação, esta ação está disponível também em uma outra modalidade de interação.
EXEMPLO  Uma aplicação que controla as luzes da casa por comandos de voz também disponibiliza uma interface interativa no dispositivo móvel para uso sem voz.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (130, N'NBR17060  ', N'5.1.2.18  ', N'Recomendação', N'Controle e interação', NULL, N'Recomendações para listas ou tabelas', N'As aplicações que utilizam listas ou tabelas podem permitir a ordenação por critérios que sejam relevantes para o usuário.
EXEMPLO	Uma lista de produtos permite a ordenação alfabética ao tocar no rótulo “nome”, no topo da lista.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (131, N'NBR17060  ', N'5.1.2.19  ', N'Recomendação', N'Controle e interação', NULL, N'Recomendações para mecanismo de busca em aplicações', N'Recomenda-se que haja mecanismos de busca em aplicações com grande quantidade de informações.
O usuário deve ter opções e formas diferentes para acessar ou localizar um determinado conteúdo. Deve-se considerar adicionar um sistema de busca para que os usuários encontrem conteúdos por frases ou palavras-chave sem ter que navegar por toda a aplicação.
EXEMPLO	Um campo de busca retorna o conteúdo pesquisado pelo usuário.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (132, N'NBR17060  ', N'5.1.2.2   ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para controle do usuário sobre ações por movimento', N'Deve haver controle do usuário sobre as ações por movimento de dispositivos móveis.
A aplicação deve permitir que o usuário desative a resposta ao movimento físico do aparelho e forneça alternativa de execução desta ação por meio de componentes de interface.
EXEMPLO  Um aplicativo de reprodução de música responde a movimentos do aparelho para frente e para trás, para passar para a próxima música. O usuário consegue desativar a alteração de música por este movimento nas configurações do próprio aplicativo.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (133, N'NBR17060  ', N'5.1.2.3   ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para configuração de notificação', N'A aplicação deve permitir que o usuário configure suas formas de notificação.
O usuário deve ter autonomia para escolher como e se deseja receber notificações da aplicação.
EXEMPLO Um aplicativo de e-commerce permite que o usuário desabilite ou configure as notificações diretamente na aplicação.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (134, N'NBR17060  ', N'5.1.2.4   ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para orientação de tela', N'O usuário deve ser avisado sempre que for necessário forçar uma determinada orientação (retrato ou paisagem) do dispositivo.
EXEMPLO Um jogo que só funciona no modo paisagem exibe uma mensagem “gire o dispositivo para usar a aplicação", quando o usuário está usando seu dispositivo em modo retrato.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (135, N'NBR17060  ', N'5.1.2.5   ', N'Recomendação', N'Controle e interação', NULL, N'Recomendações para orientação de tela', N'Recomenda-se que não seja restringida a orientação de tela do usuário a uma única orientação.
Restringir a somente uma orientação (retrato ou paisagem) pode dificultar a leitura e manipulação de interface de pessoas com limitações motoras e que necessitam de área maior para ler ou interagir com a aplicação.
Caso o aplicativo estabeleça uma orientação, o usuário deve ser auxiliado a alterá-la para retornar a um ponto compatível em seu dispositivo.
EXEMPLO Um aplicativo se ajusta ao tamanho da tela do celular do usuário, independentemente do seu uso na orientação de retrato ou paisagem.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (136, N'NBR17060  ', N'5.1.2.6   ', N'Requisito', N'Controle e interação', NULL, N'Requisitos de definição de tempo para execução de atividades', N'Nas aplicações em que a limitação de tempo não é essencial para a execução de uma atividade, deve haver a possibilidade de controle de tempo pelo usuário. Caso haja alguma limitação de tempo, esta limitação pode ser desligada ou prolongada de forma simples e eficiente por ao menos 10 vezes, ou deve ser superior a 20 h.
EXEMPLO  Um formulário de pesquisa de satisfação tem um limite de tempo para ser preenchido que pode ser prolongado pelo usuário, se necessário.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (137, N'NBR17060  ', N'5.1.2.7   ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para controle de áudios iniciados automaticamente', N'Deve haver uma forma de controlar os áudios iniciados automaticamente.
Caso uma aplicação ou página inicie a reprodução de um áudio automaticamente e esta reprodução persista por mais de três segundos, deve haver um mecanismo para parar, pausar ou controlar o volume do áudio, de tal forma que não atrapalhe a experiência do usuário, independentemente de uso de recursos assistivos.
NOTA	No parágrafo acima o valor e a unidade foram mantidos por extenso para contemplar acessibilidade.
EXEMPLO 1 Um serviço de transmissão online, como rádio online, inicia automaticamente a transmissão ao abrir o aplicativo, mas existe um controle para interromper, pausar ou silenciar a reprodução do áudio imediatamente.
EXEMPLO 2 Um aplicativo de transmissão de vídeos inicia automaticamente um vídeo com áudio de propaganda ao abrir, mas existe um controle para interromper ou pausar a reprodução do vídeo imediatamente.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (138, N'NBR17060  ', N'5.1.2.8   ', N'Recomendação', N'Controle e interação', NULL, N'Recomendações para áudios iniciados automaticamente', N'Recomenda-se que não seja iniciada a reprodução de áudio automaticamente. Isso é importante para que usuários não sejam desorientados pelo áudio, especialmente os que usam leitores de tela.
EXEMPLO  Um serviço de transmissão online, como, por exemplo, uma rádio online, inicia a reprodução do áudio somente após o usuário acionar um botão.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (139, N'NBR17060  ', N'5.1.2.9   ', N'Requisito', N'Controle e interação', NULL, N'Requisitos para controle de conteúdo que se movimenta na tela', N'Deve haver controle do usuário para pausar, parar ou ocultar conteúdo que se movimente na tela.
A aplicação deve permitir uma forma de parar, pausar ou ocultar conteúdo em movimento que é iniciado automaticamente, que dure mais de cinco segundos e que esteja próximo a outros conteúdos. Atualizações de tela também devem permitir o controle do usuário.
NOTA  No parágrafo acima o valor e a unidade foram mantidos por extenso para contemplar acessibilidade.
EXEMPLO  Um vídeo que inicia automaticamente quando o usuário acessa uma área do aplicativo tem botões de pausar ou fechar o vídeo.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (140, N'NBR17060  ', N'5.1.3.1   ', N'Requisito', N'Mídia', NULL, N'Requisitos para legendas', N'Os vídeos devem oferecer legendas para conteúdo em áudio. Em vídeos ao vivo, deve-se oferecer esse recurso utilizando estenotipia, legenda automática ou serviço similar.
EXEMPLO	Um tutorial de como utilizar um sistema permite que o usuário habilite legendas em um vídeo.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (141, N'NBR17060  ', N'5.1.3.2   ', N'Requisito', N'Mídia', NULL, N'Requisitos para recurso alternativo em vídeo pré-gravado', N'Deve haver ao menos um recurso alternativo para todo conteúdo de vídeo pré-gravado, como transcrição ou audiodescrição.
Para tomar o conteúdo disponível a mais pessoas, deve ser fornecida uma transcrição que contenha todas as informações da mídia pré-gravada (visual ou sonora) na forma de texto ou audiodescrição da mídia de vídeo. Além das informações contidas nas falas, deve-se informar todo o conteúdo visual relevante para a compreensão do vídeo, como expressões corporais, risadas, informações em texto, mudança de ambiente, entre outros.
Transcrição e audiodescrição são recursos importantes para a acessibilidade. Ambos beneficiam pessoas surdas, que não podem compreender o conteúdo em áudio, e pessoas com deficiência
visual (cegas ou com baixa visão), que podem não compreender informações visuais. Recomenda-se adicionar os dois recursos à mídia.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (142, N'NBR17060  ', N'5.1.3.3   ', N'Requisito', N'Mídia', NULL, N'Requisitos para transcrição textual para áudio pré-gravado', N'Deve existir uma transcrição textual para conteúdo de áudio pré-gravado.
Para que as pessoas tenham acesso ao conteúdo por áudio, é ideal que exista uma alternativa em texto, de preferência, de modo sincronizado para acompanhamento.
EXEMPLO  Um episódio de podcast possui um documento contendo a transcrição textual de todo o áudio do programa.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (143, N'NBR17060  ', N'5.1.3.4   ', N'Recomendação', N'Mídia', NULL, N'Recomendações para alternativa em texto para áudio ao vivo', N'Recomenda-se que haja uma alternativa em texto para o conteúdo de áudio ao vivo.
Para tornar acessíveis as informações veiculadas por áudio ao vivo, como videoconferências, discursos ao vivo e webcasts de rádio, deve-se fornecer uma alternativa para conteúdo de áudio ao vivo que apresente informações equivalentes em texto, como estenotipia, legenda automática ou serviço similar.
EXEMPLO 1 Uma empresa de notícias usa serviços de legenda baseados na web para cobrir eventos ao vivo; a saída do serviço é incorporada na tela da aplicação que inclui o controle de streaming de áudio.
EXEMPLO 2 Em uma transmissão ao vivo, legendas são exibidas para as pessoas que não conseguem acompanhar o conteúdo por som.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (144, N'NBR17060  ', N'5.1.3.5   ', N'Recomendação', N'Mídia', NULL, N'Recomendações para libras em conteúdo com áudio', N'Recomenda-se que seja disponibilizada uma alternativa em Libras para o conteúdo com áudio.
Pessoas surdas ou com deficiência auditiva podem não ser capazes de ler e compreender legendas. Por isso, o fornecimento de tradução ou interpretação em língua de sinais para todo o conteúdo de áudio pré-gravado existente ou em transmissões ao vivo (mesmo quando incluído vídeo) permite que as pessoas usuárias de língua de sinais compreendam o conteúdo.
EXEMPLO  Um vídeo de uma palestra possui um intérprete de Libras no canto ou na lateral do vídeo.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (145, N'NBR17060  ', N'5.1.3.6   ', N'Recomendação', N'Mídia', NULL, N'Recomendações para audiodescrição estendida em vídeo pré-gravado', N'Recomenda-se que haja audiodescrição estendida para conteúdo em vídeo pré-gravado.
Pessoas cegas, com baixa visão e com limitações cognitivas que têm dificuldade para interpretar visualmente o que está acontecendo em um vídeo costumam utilizar a audiodescrição da informação visual. Porém, se houver muito diálogo, as pausas no áudio podem ser insuficientes para permitir que as descrições de áudio transmitam o sentido do vídeo. Nestes casos, recomenda-se fornecer uma descrição de áudio estendida para todo o conteúdo visual do vídeo pré-gravado em mídia sincronizada.
EXEMPLO Uma pessoa ensina receitas em um tutorial online. Ela mostra os ingredientes e o modo de fazer com as mãos, enquanto fala rapidamente sobre a receita. Assim que termina de ensinar a primeira receita, ela começa a ensinar a próxima. O vídeo é pausado entre as receitas e é fornecida uma audiodescrição estendida das dicas visuais mostradas no vídeo. O vídeo é reiniciado.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (146, N'NBR17060  ', N'5.1.4.1   ', N'Requisito', N'Requisitos para codificação', NULL, N'Requisitos para codificação', N'Toda a aplicação deve ser codificada conforme as documentações de padrões técnicos, para garantir compatibilidade com o máximo de dispositivos e tecnologias assistivas. Para aplicações e páginas web que rodam em dispositivos móveis, as linguagens de marcação e o conteúdo devem ser bem estruturados e válidos, de acordo com as regras definidas nessas linguagens. Os erros na sintaxe dos elementos e atributos e as falhas de estrutura podem impedir a correta interpretação do conteúdo por agentes de usuário e tecnologias assistivas.
Caso sejam utilizados elementos de interface ou controles customizados, é necessário verificar se o componente possui nome, função e valores declarados, e se são acessíveis por recurso de tecnologia assistiva.
EXEMPLO Uma aplicação web segue a especificação de elementos do HTMLS e das diretrizes de acessibilidade WCAG. Aplicações de sistemas nativos Android e IOs seguem suas respectivas orientações de acessibilidade.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (147, N'WCAG22    ', N'1.1.1.    ', N'Diretriz', N'Alternativas em Texto', NULL, N'Conteúdo não textual', N'Todo conteúdo não textual que é exibido ao usuário tem uma alternativa textual, que serve a um propósito equivalente. Existem exceções', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (148, N'WCAG22    ', N'1.2.1.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'Apenas Áudio e Apenas Vídeo', N'Regras para as mídias de apenas áudio e vídeo, exceto quando o audio ou védeo é uma midia alternativa para texto e claramente identificado como tal', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (149, N'WCAG22    ', N'1.2.2.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'Legendas (Pré-Gravadas)', N'São fornecidas legendas para todo conteúdo de áudio pré-gravado em mídia sincronizada, exceto quando for alternativa para texto e identificada como tal', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (150, N'WCAG22    ', N'1.2.3.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'Audiodescrição ou Mídia Alternativa(Pré-Gravada)', N'Uma alternativa para mídia com base ou uma audio descrição do conteúdo em vídeo pré-gravado é fornecida para mídia sincronizada, exceto quando for altertativa para texto e identificada como tal', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (151, N'WCAG22    ', N'1.2.4.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'Legendas (Ao Vivo)', N'São fornecidas legendas para todo o conteúdo do áudio ao vivo existente em mídia sincronizada', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (152, N'WCAG22    ', N'1.2.5.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'AudioDescrição (Pré-Gravada)', N'É fornecida audiodescrição para todo o conteúdo de vídeo pré-gravado existente em mídia sincronizada', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (153, N'WCAG22    ', N'1.2.6.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'Língua se Sinais (Pré-Gravada)', N'É fornecida interpretação em língua de sinais para todo o conteúdo de audio pré-gravado existente em um conteúdo em mídia sincronizada', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (154, N'WCAG22    ', N'1.2.7.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'Audiodescrição Estendida (Pré-gravada) ', N'Quando as pausas no áudio de primeiro plano forem insuficientes para permitir que as audiodescrições transmitam o sentido do vídeo, é fornecida uma audiodescrição estendida para todo o vídeo pré-gravado existente no conteúdo em mídia sincronizada', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (155, N'WCAG22    ', N'1.2.8.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'Mídia Alternativa (Pré-gravada) ', N'É fornecida uma alternativa para mídia com base em tempo para todo o conteúdo existente em mídia sincronizada pré-gravada e para a todo o conteúdo multimídia composto por apenas vídeo pré-gravado', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (156, N'WCAG22    ', N'1.2.9.    ', N'Diretriz', N'Mídias com base em tempo', NULL, N'Apenas Áudio (Ao Vivo)  ', N'É fornecida uma alternativa para mídia com base em tempo que apresenta informações equivalentes para conteúdo apenas áudio ao vivo', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (157, N'WCAG22    ', N'1.3.1.    ', N'Diretriz', N'Adaptável', NULL, N'Informações e Relações', N'As informações, a estrutura, e os relacionamentos transmitidos através de apresentação podem ser determinados por meio de código de programação ou estão disponíveis no texto', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (158, N'WCAG22    ', N'1.3.2.    ', N'Diretriz', N'Adaptável', NULL, N'Sequência com Significado', N'Quando a sequência na qual o conteúdo é apresentado afeta o seu significado, uma sequência de leitura correta pode ser determinada por meio de código de programação', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (159, N'WCAG22    ', N'1.3.3.    ', N'Diretriz', N'Adaptável', NULL, N'Características Sensoriais', N'As instruções fornecidas para compreender e utilizar o conteúdo não dependem somente das características sensoriais dos componentes, tais como forma, cor, tamanho, localização visual, orientação ou som', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (160, N'WCAG22    ', N'1.3.4.    ', N'Diretriz', N'Adaptável', NULL, N'Orientação', N'O conteúdo não restringe sua visualização e operação a uma única orientação de exibição, como um retrato ou uma paisagem, a menos que uma orientação de exibição específica seja essencial', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (161, N'WCAG22    ', N'1.3.5.    ', N'Diretriz', N'Adaptável', NULL, N'Identificar o Objetivo de Entrada', N'A finalidade de cada campo de entrada que coleta informações sobre o usuário pode ser determinada de forma programática quando:
a) O campo de entrada atende à finalidade identificada na seção Finalidades de Entrada para Componentes de Interface de Usuário;
b) O conteúdo é implementado por meio do uso de tecnologias com suporte para identificar o significado esperado para os dados de entrada do formulário.
', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (162, N'WCAG22    ', N'1.3.6.    ', N'Diretriz', N'Adaptável', NULL, N'Identificar o Objetivo', N'Em conteúdo implementado com linguagens de marcação, a finalidade dos Componentes de Interface de Usuário, ícones, e regiões podem ser determinados programaticamente', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (163, N'WCAG22    ', N'1.4.1.    ', N'Diretriz', N'Discernível', NULL, N'Utilização de Cores', N'A cor não é utilizada como o único meio visual de transmitir informações, indicar uma ação, pedir uma resposta ou distinguir um elemento visual.
NOTA - Este critério de sucesso aborda especificamente a percepção de cores. Outras formas de percepção são abordadas na Diretriz 1.3 incluindo o acesso às cores por meio de código de programação e a outra codificação da apresentação visual.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (164, N'WCAG22    ', N'1.4.10.   ', N'Diretriz', N'Discernível', NULL, N'Realinhar', N'O conteúdo pode ser apresentado sem perda de informação ou funcionalidade e sem exigir rolagem em duas dimensões para:
a) Conteúdo de rolagem vertical com largura equivalente a 320 pixels CSS;
b) Conteúdo de rolagem horizontal com altura equivalente a 256 pixels CSS.
Exceto para partes do conteúdo que requerem layout bidimensional para uso ou significado.
', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (165, N'WCAG22    ', N'1.4.11.   ', N'Diretriz', N'Discernível', NULL, N'Contraste não textual', N'A apresentação visual a seguir tem um relação de contraste de pelo menos 3:1 contra cor(es) adjacente(s):
a) Componentes de Interface de Usuário ..., b) Objetos Gráficos ...', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (166, N'WCAG22    ', N'1.4.12.   ', N'Diretriz', N'Discernível', NULL, N'Espaçamento de Texto', N'No conteúdo implementado usando linguagens de marcação que suportam as seguintes propriedades de estilo de texto, nenhuma perda de conteúdo ou funcionalidade ocorre pela configuração de todos os itens a seguir e pela alteração de nenhuma outra propriedade de estilo:
a) Altura da linha (espaçamento entre linhas);
b) Espaçamento entre os parágrafos subsequentes;
c) Espaçamento entre letras;
d) Espaçamento entre palavras', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (167, N'WCAG22    ', N'1.4.13.   ', N'Diretriz', N'Discernível', NULL, N'Conteúdo em foco por mouse ou teclado', N'Quando a ação de receber e então remover o ponteiro do mouse ou o foco do teclado aciona conteúdo adicional tornando-o visível e então oculto, os itens a seguir são verdadeiros:
a) Descartável ; b) Flutuante (passar o cursor sobre); c) Persistente', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (168, N'WCAG22    ', N'1.4.2.    ', N'Diretriz', N'Discernível', NULL, N'Controle de Áudio', N'Se qualquer áudio em uma página web tocar automaticamente durante mais de 3 segundos, deve estar disponível um mecanismo para fazer uma pausa ou parar o áudio, ou um mecanismo para controlar o volume do áudio, independentemente do nível global de volume do sistema deve disponibilizar', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (169, N'WCAG22    ', N'1.4.3.    ', N'Diretriz', N'Discernível', NULL, N'Contraste Mínimo', N'A apresentação visual de texto e imagens de texto tem uma relação de contraste de no mínimo, 4.5:1, exceto para o seguinte:
Texto Ampliado, Texto em plano Secundário ou Logotipos', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (170, N'WCAG22    ', N'1.4.4.    ', N'Diretriz', N'Discernível', NULL, N'Redimensionar Texto', N'Exceto para legendas e imagens de texto, o texto pode ser redimensionado sem tecnologia assistiva até 200 por cento sem perder conteúdo ou funcionalidade', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (171, N'WCAG22    ', N'1.4.5.    ', N'Diretriz', N'Discernível', NULL, N'Imagens de Texto ', N'Se as tecnologias que estiverem sendo utilizadas puderem proporcionar a apresentação visual, é utilizado texto para transmitir informações em vez de imagens de texto exceto para o seguinte:
Personalizável e Essencial - Uma determinada apresentação de texto é essencial para as informações que serão transmitidas ', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (172, N'WCAG22    ', N'1.4.6.    ', N'Diretriz', N'Discernível', NULL, N'Contraste (Melhorado)', N'A apresentação visual do texto e imagens de texto tem uma relação de contraste de, no mínimo, 7:1, exceto para as seguintes situações: Texto Ampliado, Texto em plano Secundário ou Logotipos', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (173, N'WCAG22    ', N'1.4.7.    ', N'Diretriz', N'Discernível', NULL, N'Áudio de fundo baixo ou sem Áudio de fundo ', N'Para conteúdo composto por apenas áudio |pré-gravado que a) contenha essencialmente fala em primeiro plano, b) não seja um CAPTCHA de áudio ou logotipo de áudio, e 
c) não seja vocalização com o objetivo de ser, essencialmente, expressão musical, tal como cantar ou fazer batidas', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (174, N'WCAG22    ', N'1.4.8.    ', N'Diretriz', N'Discernível', NULL, N'Apresentação Visual', N'Apresentação Visual: Para a apresentação visual de blocos de texto, um mecanismo está disponível para se obter o seguinte: a) As cores do primeiro plano e do plano de fundo podem ser selecionadas pelo usuário...', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (175, N'WCAG22    ', N'1.4.9.    ', N'Diretriz', N'Discernível', NULL, N'Imagens de Texto sem exceção', N'As imagens de texto só são utilizadas por questões meramente decorativas ou quando uma determinada apresentação de texto é essencial para a informação que está sendo transmitida.
NOTA - Os logotipos (texto que faz parte de um logotipo ou marca comercial) são considerados essenciais', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (176, N'WCAG22    ', N'2.1.1.    ', N'Diretriz', N'Acessível por teclado', NULL, N'Teclado', N'Toda a funcionalidade do conteúdo é operável através de uma interface de teclado sem requerer temporizações específicas para digitação individual, exceto quando a função subjacente requer entrada de dados que dependa da cadeia de movimento do usuário e não apenas dos pontos finais', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (177, N'WCAG22    ', N'2.1.2.    ', N'Diretriz', N'Acessível por teclado', NULL, N'Sem bloqueio do Teclado', N'Se o foco do teclado puder ser movido para um componente da página utilizando uma interface de teclado, então o foco pode ser retirado desse componente utilizando apenas uma interface de teclado e, se for necessário mais do que as setas do cursor ou tabulação ou outros métodos de saída normalmente utilizados, o usuário deve ser informado sobre o método para retirar o foco', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (178, N'WCAG22    ', N'2.1.3.    ', N'Diretriz', N'Acessível por teclado', NULL, N'Teclado sem Exceção', N'Toda a funcionalidade do conteúdo é operável através de uma interface de teclado sem requerer temporizações específicas para digitação individual', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (179, N'WCAG22    ', N'2.1.4.    ', N'Diretriz', N'Acessível por teclado', NULL, N'Atalhos de teclado por caractere', N'Se um atalho de teclado é implementado no conteúdo utilizando apenas letras (incluindo letras maiúsculas e minúsculas), pontuação, números ou símbolos, então ao menos um dos itens é verdadeiro:
a)Desativar  - Um mecanismo está disponível para desativar o atalho;
b)Remapear - Um mecanismo está disponível para remapear o atalho 
c)Ativo apenas quando recebe o foco - O atalho do teclado para um componente de interface de usuário está ativo apenas quando esse componente está em foco.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (180, N'WCAG22    ', N'2.2.1.    ', N'Diretriz', N'Tempo Suficiente', NULL, N'Ajustável por temporização', N'Para cada limite de tempo definido pelo conteúdo, no mínimo, uma das seguintes afirmações é verdadeira:
a) Desligar;b) Ajustar; c) Prolongar; d) Exceção em Tempo Real; e) Exceção Essencial; e f) Exceção de 20 Horas', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (181, N'WCAG22    ', N'2.2.2.    ', N'Diretriz', N'Tempo Suficiente', NULL, N'Colocar em pausa, parar, ocultar', N'Para informações em movimento, em modo intermitente, em deslocamento ou em atualização automática, todas as seguintes afirmações são verdadeiras:
a)Em movimento, em modo intermitente, em deslocamento ; b) Em atualização automática ', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (182, N'WCAG22    ', N'2.2.3.    ', N'Diretriz', N'Tempo Suficiente', NULL, N'Sem Temporização', N'A temporização não é uma parte essencial do evento ou da atividade apresentada pelo conteúdo, exceto para mídia sincronizada não interativa e eventos em tempo real', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (183, N'WCAG22    ', N'2.2.4.    ', N'Diretriz', N'Tempo Suficiente', NULL, N'Interrupções', N'As interrupções podem ser adiadas ou suprimidas pelo usuário, exceto interrupções que envolvam uma emergência', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (184, N'WCAG22    ', N'2.2.5.    ', N'Diretriz', N'Tempo Suficiente', NULL, N'Nova Autenticação', N'Quando uma seção autenticada expira, o usuário pode continuar a atividade sem perder dados após a nova autenticação', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (185, N'WCAG22    ', N'2.2.6.    ', N'Diretriz', N'Tempo Suficiente', NULL, N'Limites de Tempo', N'Os usuários são avisados sobre a duração de qualquer inatividade do usuário que possa causar perda de dados, a menos que os dados sejam preservados por mais de 20 horas quando o usuário não realizar nenhuma ação.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (186, N'WCAG22    ', N'2.3.1.    ', N'Diretriz', N'Convulsões e Reações Físicas', NULL, N'Três Flashes ou Abaixo do Limite', N'As páginas web não incluem nenhum conteúdo que pisque mais de três vezes no período de um segundo, ou o flash encontra-se abaixo dos limites de flash universal e flash vermelho', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (187, N'WCAG22    ', N'2.3.2.    ', N'Diretriz', N'Convulsões e Reações Físicas', NULL, N'Três Flashes', N'As páginas web não incluem qualquer conteúdo que pisca mais de três vezes no período de um segundo', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (188, N'WCAG22    ', N'2.3.3.    ', N'Diretriz', N'Convulsões e Reações Físicas', NULL, N'Animação de Interações', N'A animação de movimento acionada por interação pode ser desativada, a menos que a animação seja essencial para a funcionalidade ou para as informações que estão sendo transmitidas', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (189, N'WCAG22    ', N'2.4.1.    ', N'Diretriz', N'Navegável', NULL, N'Ignorar Blocos', N'Um mecanismo está disponível para ignorar blocos de conteúdo que são repetidos em várias páginas web', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (190, N'WCAG22    ', N'2.4.10.   ', N'Diretriz', N'Navegável', NULL, N'Cabeçalhos da Sessão ', N'Os cabeçalhos da seção são utilizados para organizar o conteúdo. NOTA – "Cabeçalho" é utilizado no seu significado geral e inclui títulos e outras formas para adicionar um cabeçalho a diferentes tipos de conteúdo. NOTA - Este critério de sucesso abrange seções sobre escrita, não sobre componentes de interface do usuário. Os componentes de interface do usuário são abrangidos pelo Critério de Sucesso 4.1.2.', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (191, N'WCAG22    ', N'2.4.11.   ', N'Diretriz', N'Navegável', NULL, N'Foco não obscurecido(mínimo)', N'Quando um componente da interface do usuário recebe o foco do teclado, o componente não fica totalmente oculto 
devido ao conteúdo criado pelo autor. NOTA quando o conteúdo em uma inerface configurável pode ser reposicionado pelo 
usuário, apenas as posições iniciais do conteúdo movel do usuário são consideradas para teste e conformidade. O conteúdo 
aberto pelo usuário pode obscurecer o foco do componente que está recebendo', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (192, N'WCAG22    ', N'2.4.12.   ', N'Diretriz', N'Navegável', NULL, N'Foco não obscurecido(aprimorado)', N'Quando um componente da interface do usuário recebe o foco do teclado, nenhuma parte do componente fica oculta pelo conteúdo criado pelo autor', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (193, N'WCAG22    ', N'2.4.13.   ', N'Diretriz', N'Navegável', NULL, N'Aparência de foco', N'Quando o indicador de foco do teclado está visível, uma área do indicador de foco atende 
a todos os itens a seguir: - seja pelo menos tão grande quanto à area do perímetro, espessura de 2 pixels do componente ou subcomponente não focado e tem uma relação de 
contraste  de pelo menos 3:1 entre os mesmos pixels nos estados focado e não focado', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (194, N'WCAG22    ', N'2.4.2.    ', N'Diretriz', N'Navegável', NULL, N'Página com Título', N'As páginas web têm títulos que descrevem o tópico ou a finalidade', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (195, N'WCAG22    ', N'2.4.3.    ', N'Diretriz', N'Navegável', NULL, N'Ordem de Foco', N'Se uma página web puder ser navegada de forma sequencial e as sequências de navegação afetarem o significado ou a operação, os componentes que podem ser focados recebem o foco em uma ordem que preserva o significado e a operabilidade', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (196, N'WCAG22    ', N'2.4.4.    ', N'Diretriz', N'Navegável', NULL, N'Finalidade do Link Em contexto', N'A finalidade de cada link pode ser determinada a partir do link sozinho ou a partir do texto do link em conjunto com seu respectivo contexto do link determinado por meio de código de programação, exceto quando a finalidade do link for ambígua para os usuários em geral', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (197, N'WCAG22    ', N'2.4.5.    ', N'Diretriz', N'Navegável', NULL, N'Várias Formas', N'Está disponível mais de uma forma para localizar uma página web em um conjunto de páginas web exceto quando a Página Web for o resultado, ou uma etapa, de um processo', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (198, N'WCAG22    ', N'2.4.6.    ', N'Diretriz', N'Navegável', NULL, N'Cabeçalhos e Rótulos', N'Os cabeçalhos e os rótulos descrevem o tópico ou a finalidade', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (199, N'WCAG22    ', N'2.4.7.    ', N'Diretriz', N'Navegável', NULL, N'Foco Visível', N'Qualquer interface de usuário operável por teclado dispõe de um modo de operação onde o indicador de foco do teclado está visível', NULL, N'S')
GO
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (200, N'WCAG22    ', N'2.4.8.    ', N'Diretriz', N'Navegável', NULL, N'Localização', N'Informação sobre a localização do usuário está disponível em um conjunto de páginas web', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (201, N'WCAG22    ', N'2.4.9.    ', N'Diretriz', N'Navegável', NULL, N'Finalidade do Link (Apenas o Link)', N'Um mecanismo está disponível para permitir que a finalidade de cada link seja identificada a partir apenas do texto do link, exceto quando a sua finalidade for ambígua para os usuários em geral', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (202, N'WCAG22    ', N'2.5.1.    ', N'Diretriz', N'Modalidades de Entrada', NULL, N'Gestos de Acionamento', N'Todas as funcionalidades que usam gestos multiponto ou baseados em caminhos para operação podem ser operadas com um ponteiro único sem um gesto baseado em caminho, a menos que um gesto multiponto ou baseado em caminho seja essencial.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (203, N'WCAG22    ', N'2.5.2.    ', N'Diretriz', N'Modalidades de Entrada', NULL, N'Cancelamento de Acionamento', N'Para funcionalidade que pode ser operada usando um ponteiro único, pelo menos um dos seguintes itens é verdadeiro:
a)Sem Down-Event - O down-event do ponteiro não é utilizado para executar nenhuma parte da função;
b)Interromper ou Desfazer -;
c)Ativação Reversa - O up-event reverte qualquer resultado do down-event precedente.
d)Essencial - É essencial completar a função no down-event.', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (204, N'WCAG22    ', N'2.5.3.    ', N'Diretriz', N'Modalidades de Entrada', NULL, N'Rótulo em Nome Acessível', N'Para componentes de interface de usuário com rótulos que incluem texto ou imagens de texto, o nome contém o texto que é apresentado visualmente. NOTA - A melhor prática é ter o texto do rótulo no começo do nome', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (205, N'WCAG22    ', N'2.5.4.    ', N'Diretriz', N'Modalidades de Entrada', NULL, N'Atuação em Movimento', N'A funcionalidade que pode ser operada por movimento do dispositivo ou movimento do usuário pode também ser operada por componentes de interface de usuário e a resposta ao movimento pode ser desabilitada para evitar acionamento acidental, exceto quando:
a) Interface com suporte - O movimento é usado para operar a funcionalidade por meio de uma interface com suporte a acessibilidade;
b) Essencial - O movimento é essencial para a função e fazendo isso invalidaria a atividade', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (206, N'WCAG22    ', N'2.5.5.    ', N'Diretriz', N'Modalidades de Entrada', NULL, N'Tamanho do Alvo (Área Clicável) ', N'O tamanho do alvo para entradas de ponteiro é de pelo menos 44 x 44 pixels CSS exceto quando:
a)Equivalente- alvo está disponível por meio de um link ou controle equivalente na mesma página, com pelo menos 44 por 44 pixels;
b)Em linha- alvo está em uma sentença ou bloco de texto;
c)Controle de Agente de Usuário - tamanho do alvo é determinado pelo agente de usuário e não é modificado pelo autor;
d)Essencial- Uma apresentação específica do alvo é essencial para as informações transmitidas', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (207, N'WCAG22    ', N'2.5.6.    ', N'Diretriz', N'Modalidades de Entrada', NULL, N'Mecanismos de Entrada Simultâneos', N'O conteúdo da Web não restringe o uso de modalidades de entrada disponíveis em uma plataforma, exceto quando a restrição é essencial, necessária para garantir a segurança do conteúdo ou obrigatória para respeitar as configurações do usuário', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (208, N'WCAG22    ', N'2.5.7.    ', N'Diretriz', N'Modalidades de Entrada', NULL, N'Movimento de arrastamento', N'Toda a funcionalidade que umas um movimento de 
arrastar para operação pode ser alcançada por um único ponteiro sem arrastar, a menos que o arrastar seja essencial ou a 
funcionalidade seja determinada pelo agente do usuário e não modificada pelo autor. NOTA - esse requisito se aplica ao conteúdo da 
Web que interpreta ações de ponteiro (ou seja, isso não se aplica a ações necessárias para operar o agente do usuário 
ou a tecnologia assistiva', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (209, N'WCAG22    ', N'2.5.8.    ', N'Diretriz', N'Modalidades de Entrada', NULL, N'Tamanho de destino(mínimo)', N'O tamanho de destino para 
entradas de ponteiro é de pelo menos 24 por 24 pixels (ver exceções)', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (210, N'WCAG22    ', N'3.1.1.    ', N'Diretriz', N'Legível', NULL, N'Idioma da Página', N'O idioma humano pré-definido de cada página web pode ser determinado por meio de código de programação', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (211, N'WCAG22    ', N'3.1.2.    ', N'Diretriz', N'Legível', NULL, N'Idioma das Partes', N'O idioma de cada passagem ou frase no conteúdo pode ser determinado por meio de código de programação exceto para nomes próprios, termos técnicos, palavras de idioma indeterminado e palavras ou frases que se tornaram parte do vernáculo do texto que as envolve', NULL, N'S')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (212, N'WCAG22    ', N'3.1.3.    ', N'Diretriz', N'Legível', NULL, N'Palavras Incomuns', N'Um mecanismo para identificar definições específicas de palavras ou expressões utilizadas de uma forma restrita e incomum está disponível, incluindo expressões idiomáticas e jargões', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (213, N'WCAG22    ', N'3.1.4.    ', N'Diretriz', N'Legível', NULL, N'Abreviaturas', N'Está disponível um mecanismo para identificar a forma expandida ou o significado das abreviaturas', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (214, N'WCAG22    ', N'3.1.5.    ', N'Diretriz', N'Legível', NULL, N'Nível de Leitura', N'Quando o texto exigir uma capacidade de leitura mais avançada do que o nível de educação secundário inferior (equivalente no Brasil aos últimos anos do ensino fundamental), após a remoção dos nomes próprios e títulos adequados, um conteúdo suplementar, ou uma versão que não exija uma capacidade de leitura mais avançada do que o nível de educação secundário inferior (equivalente no Brasil aos últimos anos do ensino fundamental) está disponível', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (215, N'WCAG22    ', N'3.1.6.    ', N'Diretriz', N'Legível', NULL, N'Pronúncia', N'Um mecanismo está disponível para identificar a pronúncia específica de palavras, onde o significado das mesmas, no contexto, é ambíguo se a pronúncia não for conhecida', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (216, N'WCAG22    ', N'3.2.1.    ', N'Diretriz', N'Previsível', NULL, N'Em Foco', N'Quando qualquer componente de interface do usuário recebe o foco, não inicia uma alteração de contexto', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (217, N'WCAG22    ', N'3.2.2.    ', N'Diretriz', N'Previsível', NULL, N'Em Entrada', N'Alterar a definição de um componente de interface de usuário não provoca, automaticamente uma alteração de contexto a menos que o usuário tenha sido avisado sobre esse comportamento antes de utilizar o componente', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (218, N'WCAG22    ', N'3.2.3.    ', N'Diretriz', N'Previsível', NULL, N'Navegação Consistente', N'Os mecanismos de navegação que são repetidos em múltiplas páginas web dentro de um conjunto de páginas web ocorrem na mesma ordem relativa a cada vez que são repetidos, a menos que seja iniciada uma alteração pelo usuário', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (219, N'WCAG22    ', N'3.2.4.    ', N'Diretriz', N'Previsível', NULL, N'Identificação Consistente', N'Os componentes que têm a mesma funcionalidade em um conjunto de páginas web são identificados de forma consistente', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (220, N'WCAG22    ', N'3.2.5.    ', N'Diretriz', N'Previsível', NULL, N'Alteração Mediante Solicitação', N'As alterações de contexto são iniciadas apenas a pedido do usuário, ou um mecanismo para desativar essas alterações está disponível', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (221, N'WCAG22    ', N'3.2.6.    ', N'Diretriz', N'Previsível', NULL, N'Ajuda Consistente', N'Se uma página web contiver qualquer um dos 
mecanismos de ajuda e esses mecanismos forem repetidos em várias páginas web dentro de um conjunto de páginas web, eles 
ocorrerão na mesma ordem em relação a outro conteúdo de página, a menos que uma alteração seja iniciada pelo usuário: 
-dados de contato humano, -mecanismo de contato humano, -opção de autoajuda, -mecanismo de contato totalmente automatizado', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (222, N'WCAG22    ', N'3.3.1.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Identificação do Erro', N'Se um erro de entrada for automaticamente detectado, o item que apresenta erro é identificado e o erro é descrito para o usuário em texto', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (223, N'WCAG22    ', N'3.3.2.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Rótulos ou Instruções', N'Rótulos ou instruções são fornecidos quando o conteúdo exigir a entrada de dados por parte do usuário', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (224, N'WCAG22    ', N'3.3.3.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Sugestão de Erro', N'Se um erro de entrada for automaticamente detectado e forem conhecidas sugestões de correção, então as sugestões são fornecidas ao usuário, a menos que coloque em risco a segurança ou o propósito do conteúdo', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (225, N'WCAG22    ', N'3.3.4.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Prevenção de Erros (Legal, Financeiro, Dados)', N'Para páginas web que façam com que ocorram responsabilidades jurídicas ou transações financeiras para o usuário, que modificam ou eliminam dados controláveis pelo usuário em sistemas de armazenamento de dados, ou que enviem respostas de teste do usuário, no mínimo, uma das seguintes afirmações é verdadeira:
a) Reversível, b) Verificado c) Confirmado ', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (226, N'WCAG22    ', N'3.3.5.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Ajuda', N'Está disponível ajuda contextual', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (227, N'WCAG22    ', N'3.3.6.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Prevenção de Erros(todos)', N'Para páginas web que exijam que o usuário envie informações, no mínimo, uma das seguintes afirmações é verdadeira:
a) Reversível, b) Verificado c) Confirmado ', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (228, N'WCAG22    ', N'3.3.7.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Entrada Redundante', N'As informações inseridas anteriormente pelo usuário ou 
fornecidas ao usuário que devem ser inseridas novamente no mesmo processo são: preenchidos automaticamente ou disponivel para o usuario selecionar. 
Exceto quando: reinserir as informações é essencial; as informações sejam necessárias para garantir a segurança do conteúdo, ou
as informações inseridas anteriormente não são mais válidas', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (229, N'WCAG22    ', N'3.3.8.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Autenticação acessível(mínimo)', N'Um teste de função cognit.(como lembrar uma senha ou resolver um quebra-cabeça) 
não é necessário para nenhuma etapa em um proc.de autentic., a menos que essa etapa forneça ao menos: 
a)outro método de autent.que não depende de um teste de função cognit. b)um mecanismo está dispon.para 
ajudar o usuário a completar o teste de função cognit. c)o teste de função cognit.consiste em reconhecer objetos, 
d)o teste de função cognit.é identif. o conteúdo não textual que o usuário forneceu ao site', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (230, N'WCAG22    ', N'3.3.9.    ', N'Diretriz', N'Assistência de Entrada', NULL, N'Autenticação acessível(aprimorada)', N'Um teste de função cognitiva (como lembrar uma senha ou resolver um quebra-cabeça) não é necessário para
nenhuma etapa em um processo de autenticação, a menos que essa etapa forneça pelo menos: Alternativa- outro método 
de autenticação que não depende de um teste de função cognitiva, Mecanismo-um mecanismo está disponível para 
ajudar o usuário a completar o teste de função cognitiva', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (231, N'WCAG22    ', N'4.1.1.    ', N'Diretriz', N'Compatível', NULL, N'Análise', N'No conteúdo implementado utilizando linguagens de marcação, os elementos dispõem de tags completas de início e de fim, os elementos são aninhados de acordo com as respectivas especificações, os elementos não contêm atributos duplicados, e quaisquer IDs são exclusivos, exceto quando as especificações permitem estas características.
NOTA - Tags de início e fim que não têm um carácter crítico na sua formação, ou seja, falta de um sinal de maior ou um atributo incorreto, não estão completas', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (232, N'WCAG22    ', N'4.1.2.    ', N'Diretriz', N'Compatível', NULL, N'Nome, Função, Valor', N'Para todos os componentes de interface de usuário (incluindo, mas não se limitando a: elementos de formulário, links e componentes gerados por scripts), o nome e a função podem ser determinados por meio de código de programação; os estados, as propriedades e os valores, que possam ser definidos pelo usuário, podem ser definidos por meio de código de programação; e a notificação sobre alterações destes itens está disponível para os agentes de usuário, incluindo as tecnologias assistivas', NULL, N'N')
INSERT [dbo].[Geral] ([id], [Origem], [id_Origem], [Tipo], [Tipo_Uso], [Tipo_Config], [Descricao], [Detalhe], [Fonte], [Config_Usuario]) VALUES (233, N'WCAG22    ', N'4.1.3.    ', N'Diretriz', N'Compatível', NULL, N'Mensagens de Status', N'Em conteúdo implementado que usa linguagens de marcação, as mensagens de status podem ser determinadas programaticamente por meio da função ou de propriedades, de modo que possam ser apresentadas ao usuário por tecnologias assistivas sem receber foco', NULL, N'N')
SET IDENTITY_INSERT [dbo].[Geral] OFF
GO
