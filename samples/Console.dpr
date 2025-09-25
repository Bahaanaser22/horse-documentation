program Console;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  System.JSON,
  System.SysUtils,
  Horse.Documentation;

begin
  {$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  THorse.Use(HorseDocumentation);

  HorseDoc
    .Info
      .Description(
'''
# Informa��es Gerais

Aqui no summary � um local onde voc� pode colocar desde uma breve descri��o do que � esta documenta��o da sua API,
at� mesmo uma introdu��o completa documentando as especifica��es t�cnicas de como consumir seu projeto.

Perceba que podemos utilizar uma escrita com **markdown**, e o texto ser� convertido para um html.

# N�vel 1

Dentro do markdown ele tem v�rias formata��es pr�ticas, e neste projeto nao seria diferente, perce�a que conseguimos
colocar v�rios blocos de documenta��o e tamb�m subn�veis, e tudo ser� interpretado e colocado no menu lateral.

## N�vel 2

Aqui � o segundo nivel de documenta��o do markdown
'''     )
      .&End
    .Paths
      .Add('/ping')
      .Description(
'''
Gra�as a fun��o ``THorseDocumentationController.AutoMapHorse``, todas as rotas presente no servidor Horse s�o mapeadas
para a nossa documenta��o, mas apenas para ela dizer um ``estou aqui``, mas com a nossa biblioteca voc� tamb�m pode
documentar rota por rota tamb�m, adicionando informa��es importantes para cada uma delas.
'''   )
      .Get
        .Description('Aqui por exemplo estou mapeando a rota ``/ping`` com o tipo ``GET``')
        .Tags.Add('Ping')
        .Responses
          .StatusCodes
            .Add('200')
            .Content
              .Add('text/html')
              .Schema(TJSONObject.Create
                .AddPair('description', 'Aqui por exemplo estou documentando um tipo de resposta desta requisi��o')
                .AddPair('type', 'string')
                .AddPair('example', 'pong'))
              .&End
            .&End
          .&End
        .&End
      .&End
    .Tags
      .Add
      .Name('Ping')
      .Description('Tamb�m podemos adicionar tags personalizadas para realizar um agrupamento de requisi��es')
      .&End
    .Extensions
      .Add('x-tagGroups', TJSONArray.Create
        .Add(TJSONObject.Create
          .AddPair('name', 'Grupo de rotas')
          .AddPair('tags', TJSONArray.Create
            .Add('Ping'))));

  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(9000,
    procedure
    begin
      THorseDocumentationController.AutoMapHorse;
      Writeln(Format('Server is runing on %s:%d', [THorse.Host, THorse.Port]));
      Writeln(Format('For see Documentation open %s:%d/horse/doc/html', [THorse.Host, THorse.Port]));
      Readln;
    end);
end.
