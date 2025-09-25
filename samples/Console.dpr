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
# Informações Gerais

Aqui no summary é um local onde você pode colocar desde uma breve descrição do que é esta documentação da sua API,
até mesmo uma introdução completa documentando as especificações técnicas de como consumir seu projeto.

Perceba que podemos utilizar uma escrita com **markdown**, e o texto será convertido para um html.

# Nível 1

Dentro do markdown ele tem várias formatações práticas, e neste projeto nao seria diferente, perceça que conseguimos
colocar vários blocos de documentação e também subníveis, e tudo será interpretado e colocado no menu lateral.

## Nível 2

Aqui é o segundo nivel de documentação do markdown
'''     )
      .&End
    .Paths
      .Add('/ping')
      .Description(
'''
Graças a função ``THorseDocumentationController.AutoMapHorse``, todas as rotas presente no servidor Horse são mapeadas
para a nossa documentação, mas apenas para ela dizer um ``estou aqui``, mas com a nossa biblioteca você também pode
documentar rota por rota também, adicionando informações importantes para cada uma delas.
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
                .AddPair('description', 'Aqui por exemplo estou documentando um tipo de resposta desta requisição')
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
      .Description('Também podemos adicionar tags personalizadas para realizar um agrupamento de requisições')
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
