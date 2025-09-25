unit Horse.Documentation.OpenApi.Interfaces;

interface

uses
  System.JSON,
  System.Rtti,
  Horse.Documentation.OpenApi.Types;

type
  IInfo = interface;
  IContact = interface;
  ILicense = interface;
  IServer<T> = interface;
  IServerVariable<T> = interface;
  IPathItem<T> = interface;
  IOperation<T> = interface;
  IResponses<T> = interface;
  IComponents = interface;
  ISchema = TJSONValue;
  IDiscriminator = interface;
  IXML = interface;
  IMediaType<T> = interface;
  IEncoding<T> = interface;
  IResponse<T> = interface;
  IParameter<T> = interface;
  IExample<T> = interface;
  IRequestBody<T> = interface;
  ISecurityRequirement<T> = interface;
  IHeader<T> = interface;
  ISecurityScheme = interface;
  IOAuthFlows = interface;
  ILink<T> = interface;
  ITag = interface;
  IExternalDocumentation<T> = interface;

  /// <summary>
  ///   Interface base para todas as interfaces do modelo OpenAPI.
  ///   Implementa a funcionalidade comum de "Specification Extensions" (campos x-...).
  /// </summary>
  IOpenApiAncestor = interface(IInterface)
    ['{7BB3A54B-97E3-4556-917E-6A1AACA2D43F}']
    /// <summary>
    ///   Um mapa de nomes de extens�o para seus valores.
    ///   Permite que dados customizados sejam adicionados � especifica��o.
    /// </summary>
    function Extensions: TOpenApiMap<TJSONValue, IOpenApiAncestor>;

    /// <summary>Realiza a exporta��o do objeto para uma string do valor json</summary>
    function ToJson: TJSONObject;
  end;

  /// <summary>Este � a interface raiz de uma Descri��o OpenAPI.</summary>
  IOpenApi = interface(IOpenApiAncestor)
    ['{923B615D-D6FA-44F0-9DE7-B0B519C5F278}']
    /// <summary>
    ///   REQUIRED. Esta string DEVE ser o n�mero da vers�o da Especifica��o
    ///   OpenAPI que o Documento OpenAPI utiliza. O campo `openapi` DEVE ser
    ///   usado por ferramentas para interpretar o Documento OpenAPI.
    ///   Isso n�o est� relacionado � string `info.version` da API.
    /// </summary>
    function Openapi: string; overload;
    function Openapi(const AValue: string): IOpenApi; overload;

    /// <summary>
    ///   REQUIRED. Fornece metadados sobre a API. Os metadados PODEM ser
    ///   usados por ferramentas conforme necess�rio.
    /// </summary>
    function Info: IInfo;

    /// <summary>
    ///   O valor padr�o para a palavra-chave `$schema` dentro de
    ///   Schema Objects contidos neste documento OAS.
    ///   Isto DEVE estar no formato de uma URI.
    /// </summary>
    function JsonSchemaDialect: string; overload;
    function JsonSchemaDialect(const AValue: string): IOpenApi; overload;

    /// <summary>
    ///   Um array de Server Objects, que fornecem informa��es de conectividade
    ///   para um servidor alvo. Se o campo `servers` n�o for fornecido, ou for
    ///   um array vazio, o valor padr�o seria um Server Object com um valor de `url` de `/`.
    /// </summary>
    function Servers: TOpenApiList<IServer<IOpenApi>, IOpenApi>;

    /// <summary>Os caminhos e opera��es dispon�veis para a API.</summary>
    function Paths: TOpenApiMap<IPathItem<IOpenApi>, IOpenApi>;

    /// <summary>
    ///   Os webhooks de entrada que PODEM ser recebidos como parte desta API e
    ///   que o consumidor da API PODE escolher implementar. O nome da chave � uma
    ///   string �nica para se referir a cada webhook.
    /// </summary>
    function Webhooks: TOpenApiMap<IPathItem<IOpenApi>, IOpenApi>;

    /// <summary>Um elemento para conter v�rios Objetos para a Descri��o OpenAPI.</summary>
    function Components: IComponents;

    /// <summary>
    ///   Uma declara��o de quais mecanismos de seguran�a podem ser usados em
    ///   toda a API. A lista de valores inclui Security Requirement Objects
    ///   alternativos que podem ser usados.
    /// </summary>
    function Security: TOpenApiList<ISecurityRequirement<IOpenApi>, IOpenApi>;

    /// <summary>
    ///   Uma lista de tags usadas pela Descri��o OpenAPI com metadados adicionais.
    ///   A ordem das tags pode ser usada para refletir sua ordem pelas ferramentas
    ///   de parsing. Cada nome de tag na lista DEVE ser �nico.
    /// </summary>
    function Tags: TOpenApiList<ITag, IOpenApi>;

    /// <summary>Documenta��o externa adicional.</summary>
    function ExternalDocs: IExternalDocumentation<IOpenApi>;
  end;

  /// <summary>
  ///   O objeto fornece metadados sobre a API. Os metadados PODEM ser usados
  ///   pelos clientes se necess�rio, e PODEM ser apresentados em ferramentas de
  ///   edi��o ou gera��o de documenta��o por conveni�ncia.
  /// </summary>
  IInfo = interface(IOpenApiAncestor)
    ['{97248BEA-0621-489A-9F05-371EFFFD1BE2}']
    /// <summary>REQUIRED. O t�tulo da API.</summary>
    function Title: string; overload;
    function Title(const AValue: string): IInfo; overload;

    /// <summary>Um breve resumo da API.</summary>
    function Summary: string; overload;
    function Summary(const AValue: string): IInfo; overload;

    /// <summary>
    ///   Uma descri��o da API. A sintaxe CommonMark PODE ser usada
    ///   para representa��o de texto rico.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IInfo; overload;

    /// <summary>
    ///   Uma URI para os Termos de Servi�o da API.
    ///   Isto DEVE estar no formato de uma URI.
    /// </summary>
    function TermsOfService: string; overload;
    function TermsOfService(const AValue: string): IInfo; overload;

    /// <summary>As informa��es de contato para a API exposta.</summary>
    function Contact: IContact;

    /// <summary>As informa��es de licen�a para a API exposta.</summary>
    function License: ILicense;

    /// <summary>
    ///   REQUIRED. A vers�o do Documento OpenAPI (que � distinta da vers�o
    ///   da Especifica��o OpenAPI ou da vers�o da API sendo descrita).
    /// </summary>
    function Version: string; overload;
    function Version(const AValue: string): IInfo; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: IOpenApi;
  end;

  /// <summary>Informa��es de contato para a API exposta.</summary>
  IContact = interface(IOpenApiAncestor)
    ['{944F4590-19E1-456D-8E2E-AE1DFB46BC4D}']
    /// <summary>O nome de identifica��o da pessoa/organiza��o de contato.</summary>
    function Name: string; overload;
    function Name(const AValue: string): IContact; overload;

    /// <summary>
    ///   A URI para as informa��es de contato.
    ///   Isto DEVE estar no formato de uma URI.
    /// </summary>
    function Url: string; overload;
    function Url(const AValue: string): IContact; overload;

    /// <summary>
    ///   O endere�o de e-mail da pessoa/organiza��o de contato.
    ///   Isto DEVE estar no formato de um endere�o de e-mail.
    /// </summary>
    function Email: string; overload;
    function Email(const AValue: string): IContact; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: IInfo;
  end;

  /// <summary>Informa��es de licen�a para a API exposta.</summary>
  ILicense = interface(IOpenApiAncestor)
    ['{27C15FFB-8150-43A5-B982-7916EF0DB591}']
    /// <summary>REQUIRED. O nome da licen�a usada para a API</summary>
    function Name: string; overload;
    function Name(const AValue: string): ILicense; overload;

    /// <summary>
    ///   Uma express�o de licen�a SPDX para a API. O campo `identifier`
    ///   � mutuamente exclusivo do campo `url`.
    /// </summary>
    function Identifier: string; overload;
    function Identifier(const AValue: string): ILicense; overload;

    /// <summary>
    ///   Uma URI para a licen�a usada para a API. Isto DEVE estar no formato
    ///   de uma URI. O campo `url` � mutuamente exclusivo do campo `identifier`.
    /// </summary>
    function Url: string; overload;
    function Url(const AValue: string): ILicense; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: IInfo;
  end;

  /// <summary>Um objeto representando um Servidor.</summary>
  IServer<T> = interface(IOpenApiAncestor)
    ['{06E202C2-E3EA-467E-81D8-4192EE2953F7}']
    /// <summary>
    ///   REQUIRED. Uma URL para o host de destino. Esta URL suporta Vari�veis de
    ///   Servidor e PODE ser relativa, para indicar que a localiza��o do host �
    ///   relativa � localiza��o onde o documento que cont�m o Server Object est�
    ///   sendo servido. Substitui��es de vari�veis ser�o feitas quando uma
    ///   vari�vel for nomeada entre {chaves}.
    /// </summary>
    function Url: string; overload;
    function Url(const AValue: string): IServer<T>; overload;

    /// <summary>
    ///   Uma string opcional descrevendo o host designado pela URL.
    ///   A sintaxe CommonMark PODE ser usada para representa��o de texto rico.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IServer<T>; overload;

    /// <summary>
    ///   Um mapa entre um nome de vari�vel e seu valor. O valor � usado para
    ///   substitui��o no template de URL do servidor.
    /// </summary>
    function Variables: TOpenApiMap<IServerVariable<T>, IServer<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>
  ///   Um objeto representando uma Vari�vel de Servidor para substitui��o
  ///   no template de URL do servidor.
  /// </summary>
  IServerVariable<T> = interface(IOpenApiAncestor)
    ['{07910CC7-8542-4647-AE59-9ED2C9537C44}']
    /// <summary>
    ///   Uma enumera��o de valores de string a serem usados se as op��es de
    ///   substitui��o forem de um conjunto limitado. O array N�O DEVE estar vazio.
    /// </summary>
    function &Enum: TOpenApiList<string, IServerVariable<T>>;

    /// <summary>
    ///   REQUIRED. O valor padr�o a ser usado para substitui��o, que DEVE ser
    ///   enviado se um valor alternativo n�o for fornecido. Se o `enum` for
    ///   definido, o valor DEVE existir nos valores do enum.
    /// </summary>
    function &Default: string; overload;
    function &Default(const AValue: string): IServerVariable<T>; overload;

    /// <summary>
    ///   Uma descri��o opcional para a vari�vel do servidor. A sintaxe CommonMark
    ///   PODE ser usada para representa��o de texto rico.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IServerVariable<T>; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: IServer<T>;
  end;

  /// <summary>
  ///   Cont�m um conjunto de objetos reutiliz�veis para diferentes aspectos do OAS.
  ///   Todos os objetos definidos aqui n�o t�m efeito na API a menos que sejam
  ///   explicitamente referenciados de fora do Components Object.
  /// </summary>
  IComponents = interface(IOpenApiAncestor)
    ['{D7383B27-1D05-43ED-9BF7-BCEC70D502DE}']
    /// <summary>Um objeto para conter Schema Objects reutiliz�veis.</summary>
    function Schemas: TOpenApiMap<ISchema, IComponents>;

    /// <summary>Um objeto para conter Response Objects reutiliz�veis.</summary>
    function Responses: TOpenApiMap<IResponse<IComponents>, IComponents>;

    /// <summary>Um objeto para conter Parameter Objects reutiliz�veis.</summary>
    function Parameters: TOpenApiMap<IParameter<IComponents>, IComponents>;

    /// <summary>Um objeto para conter Example Objects reutiliz�veis.</summary>
    function Examples: TOpenApiMap<IExample<IComponents>, IComponents>;

    /// <summary>Um objeto para conter Request Body Objects reutiliz�veis.</summary>
    function RequestBodies: TOpenApiMap<IRequestBody<IComponents>, IComponents>;

    /// <summary>Um objeto para conter Header Objects reutiliz�veis.</summary>
    function Headers: TOpenApiMap<IHeader<IComponents>, IComponents>;

    /// <summary>Um objeto para conter Security Scheme Objects reutiliz�veis.</summary>
    function SecuritySchemes: TOpenApiMap<ISecurityScheme, IComponents>;

    /// <summary>Um objeto para conter Link Objects reutiliz�vei</summary>
    function Links: TOpenApiMap<ILink<IComponents>, IComponents>;

    /// <summary>Um objeto para conter Callback Objects reutiliz�veis.</summary>
    function Callbacks: TOpenApiMap<IPathItem<IComponents>, IComponents>;

    /// <summary>Um objeto para conter Path Item Objects reutiliz�veis.</summary>
    function PathItems: TOpenApiMap<IPathItem<IComponents>, IComponents>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: IOpenApi;
  end;

  /// <summary>
  ///   Descreve as opera��es dispon�veis em um �nico caminho.
  ///   Um Path Item PODE estar vazio, devido a restri��es de ACL. O caminho
  ///   em si ainda � exposto, mas os visualizadores de documenta��o n�o saber�o
  ///   quais opera��es e par�metros est�o dispon�veis.
  /// </summary>
  IPathItem<T> = interface(IOpenApiAncestor)
    ['{CC112B05-5ADD-4C24-A0E7-D652D6158065}']
    /// <summary>
    ///   (Mapeia para o campo '$ref') Permite uma defini��o referenciada
    ///   deste item de caminho. O valor DEVE estar no formato de uma URI, e a
    ///   estrutura referenciada DEVE ser na forma de um Path Item Object.
    /// </summary>
    function Ref: string; overload;
    function Ref(const AValue: string): IPathItem<T>; overload;

    /// <summary>
    ///   Um resumo opcional em string, destinado a se aplicar a todas as
    ///   opera��es neste caminho.
    /// </summary>
    function Summary: string; overload;
    function Summary(const AValue: string): IPathItem<T>; overload;

    /// <summary>
    ///   Uma descri��o opcional em string, destinada a se aplicar a todas as
    ///   opera��es neste caminho. A sintaxe CommonMark PODE ser usada.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IPathItem<T>; overload;

    /// <summary>Uma defini��o de uma opera��o GET neste caminho.</summary>
    function Get: IOperation<IPathItem<T>>;

    /// <summary>Uma defini��o de uma opera��o PUT neste caminho.</summary>
    function Put: IOperation<IPathItem<T>>;

    /// <summary>Uma defini��o de uma opera��o POST neste caminho.</summary>
    function Post: IOperation<IPathItem<T>>;

    /// <summary>Uma defini��o de uma opera��o DELETE neste caminho.</summary>
    function &Delete: IOperation<IPathItem<T>>;

    /// <summary>Uma defini��o de uma opera��o OPTIONS neste caminho.</summary>
    function Options: IOperation<IPathItem<T>>;

    /// <summary>Uma defini��o de uma opera��o HEAD neste caminho.</summary>
    function Head: IOperation<IPathItem<T>>;

    /// <summary>Uma defini��o de uma opera��o PATCH neste caminho.</summary>
    function Patch: IOperation<IPathItem<T>>;

    /// <summary>Uma defini��o de uma opera��o TRACE neste caminho.</summary>
    function Trace: IOperation<IPathItem<T>>;

    /// <summary>
    ///   Um array `servers` alternativo para servir todas as opera��es neste
    ///   caminho. Se um array `servers` for especificado no n�vel do OpenAPI
    ///   Object, ele ser� sobrescrito por este valor.
    /// </summary>
    function Servers: TOpenApiList<IServer<IPathItem<T>>, IPathItem<T>>;

    /// <summary>
    ///   Uma lista de par�metros que s�o aplic�veis a todas as opera��es
    ///   descritas sob este caminho. Estes par�metros podem ser sobrescritos
    ///   no n�vel da opera��o, mas n�o podem ser removidos l�. A lista PODE
    ///   usar o Reference Object para vincular a par�metros definidos nos
    ///   `components`.
    /// </summary>
    function Parameters: TOpenApiList<IParameter<IPathItem<T>>, IPathItem<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>Descreve uma �nica opera��o de API em um caminho.</summary>
  IOperation<T> = interface(IOpenApiAncestor)
    ['{929B89FA-01F8-4BA8-B5A3-67334281DCF4}']
    /// <summary>
    ///   Uma lista de tags para controle da documenta��o da API. As tags podem
    ///   ser usadas para agrupamento l�gico de opera��es por recursos ou
    ///   qualquer outro qualificador.
    /// </summary>
    function Tags: TOpenApiList<string, IOperation<T>>;

    /// <summary>Um breve resumo do que a opera��o faz.</summary>
    function Summary: string; overload;
    function Summary(const AValue: string): IOperation<T>; overload;

    /// <summary>
    ///   Uma explica��o detalhada do comportamento da opera��o. A sintaxe
    ///   CommonMark PODE ser usada para representa��o de texto rico.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IOperation<T>; overload;

    /// <summary>Documenta��o externa adicional para esta opera��o.</summary>
    function ExternalDocs: IExternalDocumentation<IOperation<T>>;

    /// <summary>
    ///   String �nica usada para identificar a opera��o. O id DEVE ser �nico
    ///   entre todas as opera��es descritas na API. O valor de operationId �
    ///   case-sensitive.
    /// </summary>
    function OperationId: string; overload;
    function OperationId(const AValue: string): IOperation<T>; overload;

    /// <summary>
    ///   Uma lista de par�metros aplic�veis a esta opera��o. Se um par�metro
    ///   j� estiver definido no Path Item, a nova defini��o o sobrescrever�.
    /// </summary>
    function Parameters: TOpenApiList<IParameter<IOperation<T>>, IOperation<T>>;

    /// <summary>O corpo da requisi��o aplic�vel a esta opera��o.</summary>
    function RequestBody: IRequestBody<IOperation<T>>;

    /// <summary>
    ///   A lista de respostas poss�veis conforme s�o retornadas da execu��o
    ///   desta opera��o.
    /// </summary>
    function Responses: IResponses<IOperation<T>>;

    /// <summary>
    ///   Um mapa de poss�veis callbacks "out-of-band" relacionados � opera��o
    ///   pai. A chave � um identificador �nico para o Callback Object.
    /// </summary>
//    function Callbacks: TOpenApiMap<IPathItem<IOperation<T>>, IOperation<T>>;

    /// <summary>
    ///   Declara esta opera��o como obsoleta. Consumidores DEVEM evitar o uso
    ///   da opera��o declarada. O valor padr�o � `false`.
    /// </summary>
    function Deprecated: Boolean; overload;
    function Deprecated(const AValue: Boolean): IOperation<T>; overload;

    /// <summary>
    ///   Uma declara��o de quais mecanismos de seguran�a podem ser usados para
    ///   esta opera��o. Esta defini��o sobrescreve qualquer `security`
    ///   declarado no n�vel superior.
    /// </summary>
    function Security: TOpenApiList<ISecurityRequirement<IOperation<T>>, IOperation<T>>;

    /// <summary>
    ///   Um array `servers` alternativo para servir esta opera��o. Se um array
    ///   `servers` for especificado no Path Item Object ou no OpenAPI Object,
    ///   ele ser� sobrescrito por este valor.
    /// </summary>
    function Servers: TOpenApiList<IServer<IOperation<T>>, IOperation<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>Permite referenciar um recurso externo para documenta��o estendida.</summary>
  IExternalDocumentation<T> = interface(IOpenApiAncestor)
    ['{20AB5D24-5935-445C-956A-1A7180601631}']
    /// <summary>
    ///   Uma descri��o da documenta��o de destino. A sintaxe CommonMark PODE
    ///   ser usada para representa��o de texto rico.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IExternalDocumentation<T>; overload;

    /// <summary>
    ///   REQUIRED. A URI para a documenta��o de destino.
    ///   Isto DEVE estar no formato de uma URI.
    /// </summary>
    function Url: string; overload;
    function Url(const AValue: string): IExternalDocumentation<T>; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>
  ///   Descreve um �nico par�metro de opera��o.
  ///   Um par�metro �nico � definido por uma combina��o de nome e localiza��o (`in`).
  /// </summary>
  IParameter<T> = interface(IOpenApiAncestor)
    ['{16C19AC0-94A5-49E5-9E39-DCD45D6BF125}']
    /// <summary>
    ///   REQUIRED. O nome do par�metro. Nomes de par�metros s�o case-sensitive.
    ///   - Se `in` for "path", `name` DEVE corresponder a uma express�o de template no caminho.
    ///   - Se `in` for "header" e `name` for "Accept", "Content-Type" ou "Authorization",
    ///     a defini��o do par�metro DEVE ser ignorada.
    /// </summary>
    function Name: string; overload;
    function Name(const AValue: string): IParameter<T>; overload;

    /// <summary>
    ///   REQUIRED. A localiza��o do par�metro.
    ///   Valores poss�veis s�o "query", "header", "path" ou "cookie".
    /// </summary>
    function &In: TParameterLocation; overload;
    function &In(const AValue: TParameterLocation): IParameter<T>; overload;

    /// <summary>
    ///   Uma breve descri��o do par�metro. Pode conter exemplos de uso.
    ///   A sintaxe CommonMark PODE ser usada.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IParameter<T>; overload;

    /// <summary>
    ///   Determina se este par�metro � obrigat�rio. Se a localiza��o for "path",
    ///   este campo � REQUIRED e seu valor DEVE ser `true`. Caso contr�rio, o
    ///   valor padr�o � `false`.
    /// </summary>
    function Required: Boolean; overload;
    function Required(const AValue: Boolean): IParameter<T>; overload;

    /// <summary>
    ///   Especifica que um par�metro � obsoleto e DEVE ser descontinuado.
    ///   O valor padr�o � `false`.
    /// </summary>
    function Deprecated: Boolean; overload;
    function Deprecated(const AValue: Boolean): IParameter<T>; overload;

    /// <summary>
    ///   Se `true`, clientes PODEM passar um valor de string de comprimento zero.
    ///   V�lido apenas para par�metros `query`. O valor padr�o � `false`.
    ///   O uso deste campo N�O � RECOMENDADO.
    /// </summary>
    function AllowEmptyValue: Boolean; overload;
    function AllowEmptyValue(const AValue: Boolean): IParameter<T>; overload;

    /// <summary>
    ///   Descreve como o valor do par�metro ser� serializado.
    ///   Padr�es (baseado em `in`): "query" -> "form"; "path" -> "simple";
    ///   "header" -> "simple"; "cookie" -> "form".
    /// </summary>
    function Style: TParameterStyle; overload;
    function Style(const AValue: TParameterStyle): IParameter<T>; overload;

    /// <summary>
    ///   Quando `true`, valores de `array` ou `object` geram par�metros separados.
    ///   Padr�o � `true` para `style`="form", e `false` para os outros.
    /// </summary>
    function Explode: Boolean; overload;
    function Explode(const AValue: Boolean): IParameter<T>; overload;

    /// <summary>
    ///   Permite que caracteres reservados definidos por RFC6570 passem sem codifica��o.
    ///   Aplica-se apenas a par�metros `query`. O valor padr�o � `false`.
    /// </summary>
    function AllowReserved: Boolean; overload;
    function AllowReserved(const AValue: Boolean): IParameter<T>; overload;

    /// <summary>
    ///   O schema que define o tipo usado para o par�metro.
    ///   Mutuamente exclusivo com o campo `content`.
    /// </summary>
    function Schema: ISchema; overload;
    function Schema(const AValue: ISchema): IParameter<T>; overload;

    /// <summary>Exemplo do valor potencial do par�metro. Mutuamente exclusivo com `examples`.</summary>
    function Example: TJSONValue; overload;
    function Example(const AValue: TJSONValue): IParameter<T>; overload;

    /// <summary>Exemplos do valor potencial do par�metro. Mutuamente exclusivo com `example`.</summary>
    function Examples: TOpenApiMap<IExample<IParameter<T>>, IParameter<T>>;

    /// <summary>
    ///   Um mapa contendo as representa��es para o par�metro. A chave � o
    ///   media type. O mapa DEVE conter apenas uma entrada.
    ///   Mutuamente exclusivo com o campo `schema`.
    /// </summary>
    function Content: TOpenApiMap<IMediaType<IParameter<T>>, IParameter<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>Descreve um �nico corpo de requisi��o.</summary>
  IRequestBody<T> = interface(IOpenApiAncestor)
    ['{08CD08D9-EE62-4AD6-BFEC-1A2A63CA44EF}']
    /// <summary>
    ///   Uma breve descri��o do corpo da requisi��o. Pode conter exemplos de uso.
    ///   A sintaxe CommonMark PODE ser usada.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IRequestBody<T>; overload;

    /// <summary>
    ///   REQUIRED. O conte�do do corpo da requisi��o. A chave � um media type ou
    ///   uma faixa de media types e o valor o descreve. Para requisi��es que
    ///   correspondem a m�ltiplas chaves, apenas a chave mais espec�fica � aplic�vel.
    /// </summary>
    function Content: TOpenApiMap<IMediaType<IRequestBody<T>>, IRequestBody<T>>;

    /// <summary>Determina se o corpo da requisi��o � obrigat�rio na requisi��o. O padr�o � `false`.</summary>
    function Required: Boolean; overload;
    function Required(const AValue: Boolean): IRequestBody<T>; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>Cada Media Type Object fornece schema e exemplos para o media type identificado por sua chave.</summary>
  IMediaType<T> = interface(IOpenApiAncestor)
    ['{25508D82-EE7A-4EF2-88F0-41EE5C0C31FD}']
    /// <summary>O schema que define o conte�do da requisi��o, resposta, par�metro ou header.</summary>
    function Schema: ISchema; overload;
    function Schema(const AValue: ISchema): IMediaType<T>; overload;

    /// <summary>
    ///   Exemplo do media type. Mutuamente exclusivo com `examples`.
    ///   Se presente, SOBRESCREVE qualquer `example` no schema.
    /// </summary>
    function Example: TJSONValue; overload;
    function Example(const AValue: TJSONValue): IMediaType<T>; overload;

    /// <summary>
    ///   Exemplos do media type. Mutuamente exclusivo com `example`.
    ///   Se presente, SOBRESCREVE qualquer `example` no schema.
    /// </summary>
    function Examples: TOpenApiMap<IExample<IMediaType<T>>, IMediaType<T>>;

    /// <summary>
    ///   Um mapa entre um nome de propriedade e sua informa��o de codifica��o.
    ///   A chave DEVE existir no schema como uma propriedade. O campo `encoding`
    ///   DEVE ser aplicado apenas a Request Body Objects quando o media type for
    ///   `multipart` ou `application/x-www-form-urlencoded`.
    /// </summary>
    function Encoding: TOpenApiMap<IEncoding<IMediaType<T>>, IMediaType<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>Uma �nica defini��o de codifica��o aplicada a uma �nica propriedade de schema.</summary>
  IEncoding<T> = interface(IOpenApiAncestor)
    ['{2DECD134-8FFE-4621-A2CB-5E81A5CE2140}']
    /// <summary>
    ///   O Content-Type para codificar uma propriedade espec�fica. O valor � uma
    ///   lista separada por v�rgulas de media types espec�ficos ou curingas.
    ///   O valor padr�o depende do tipo da propriedade.
    /// </summary>
    function ContentType: string; overload;
    function ContentType(const AValue: string): IEncoding<T>; overload;

    /// <summary>
    ///   Um mapa que permite que informa��es adicionais sejam fornecidas como
    ///   headers. Este campo DEVE ser ignorado se o media type do corpo da
    ///   requisi��o n�o for `multipart`.
    /// </summary>
//    function Headers: TOpenApiMap<IHeader<T>, IEncoding<T>>;

    /// <summary>
    ///   Descreve como um valor de propriedade espec�fico ser� serializado.
    ///   Segue os mesmos valores que os par�metros `query`. DEVE ser ignorado
    ///   se o media type n�o for `application/x-www-form-urlencoded`.
    /// </summary>
    function Style: TParameterStyle; overload;
    function Style(const AValue: TParameterStyle): IEncoding<T>; overload;

    /// <summary>
    ///   Quando `true`, valores de `array` ou `object` geram par�metros
    ///   separados. O padr�o � `true` para `style`="form", e `false` para os outros.
    ///   DEVE ser ignorado se o media type n�o for `application/x-www-form-urlencoded`.
    /// </summary>
    function Explode: Boolean; overload;
    function Explode(const AValue: Boolean): IEncoding<T>; overload;

    /// <summary>
    ///   Quando `true`, os valores dos par�metros s�o serializados usando
    ///   expans�o reservada (RFC6570). O padr�o � `false`. DEVE ser ignorado
    ///   se o media type n�o for `application/x-www-form-urlencoded`.
    /// </summary>
    function AllowReserved: Boolean; overload;
    function AllowReserved(const AValue: Boolean): IEncoding<T>; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>Descreve uma �nica resposta de uma opera��o de API.</summary>
  IResponse<T> = interface(IOpenApiAncestor)
    ['{F008308F-9B49-4EA4-BF63-44CE5AC56613}']
    /// <summary>
    ///   REQUIRED. Uma descri��o da resposta. A sintaxe CommonMark
    ///   PODE ser usada.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IResponse<T>; overload;

    /// <summary>
    ///   Mapeia um nome de header para sua defini��o. Nomes de header s�o
    ///   case-insensitive. Se um header de resposta for definido com o nome
    ///   "Content-Type", ele DEVE ser ignorado.
    /// </summary>
    function Headers: TOpenApiMap<IHeader<IResponse<T>>, IResponse<T>>;

    /// <summary>Um mapa contendo descri��es dos poss�veis payloads de resposta. A chave � um media type.</summary>
    function Content: TOpenApiMap<IMediaType<IResponse<T>>, IResponse<T>>;

    /// <summary>
    ///   Um mapa de links de opera��es que podem ser seguidos a partir da resposta.
    ///   A chave do mapa � um nome curto para o link.
    /// </summary>
    function Links: TOpenApiMap<ILink<IResponse<T>>, IResponse<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>
  ///   Um cont�iner para as respostas esperadas de uma opera��o.
  ///   O cont�iner mapeia um c�digo de resposta HTTP para a resposta esperada.
  /// </summary>
  IResponses<T> = interface(IOpenApiAncestor)
    ['{664D48C4-6A68-405E-9EB1-EC26002C268D}']
    /// <summary>
    ///   A documenta��o de respostas que n�o sejam as declaradas para c�digos
    ///   de resposta HTTP espec�ficos. Use este campo para cobrir respostas
    ///   n�o declaradas.
    /// </summary>
    function &Default: IResponse<IResponses<T>>;

    /// <summary>
    ///   Mapeia um c�digo de status HTTP (ou um intervalo como '2XX') para a
    ///   sua defini��o de resposta.
    /// </summary>
    function StatusCodes: TOpenApiMap<IResponse<IResponses<T>>, IResponses<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>Agrupa um valor de exemplo interno ou externo com metadados b�sicos de resumo e descri��o.</summary>
  IExample<T> = interface(IOpenApiAncestor)
    ['{25EF470D-559B-4D93-BCB1-7712E04A2A40}']
    /// <summary>Breve descri��o para o exemplo.</summary>
    function Summary: string; overload;
    function Summary(const AValue: string): IExample<T>; overload;

    /// <summary>Longa descri��o para o exemplo. A sintaxe CommonMark PODE ser usada.</summary>
    function Description: string; overload;
    function Description(const AValue: string): IExample<T>; overload;

    /// <summary>Exemplo literal embutido. O campo `value` e o campo `externalValue` s�o mutuamente exclusivos.</summary>
    function Value: TJSONValue; overload;
    function Value(const AValue: TJSONValue): IExample<T>; overload;

    /// <summary>
    ///   Uma URI que identifica o exemplo literal. O campo `value` e o campo
    ///   `externalValue` s�o mutuamente exclusivos.
    /// </summary>
    function ExternalValue: string; overload;
    function ExternalValue(const AValue: string): IExample<T>; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>
  ///   O Link Object representa um poss�vel link em tempo de design para uma
  ///   resposta. A presen�a de um link n�o garante a capacidade do chamador de
  ///   invoc�-lo com sucesso, mas fornece uma rela��o conhecida e um mecanismo
  ///   de travessia entre respostas e outras opera��es.
  /// </summary>
  ILink<T> = interface(IOpenApiAncestor)
    ['{CA398A79-6F4C-42BD-A961-78A08DDED763}']
    /// <summary>
    ///   Uma refer�ncia URI a uma opera��o OAS. Este campo � mutuamente exclusivo
    ///   do campo `operationId`, e DEVE apontar para um Operation Object.
    /// </summary>
    function OperationRef: string; overload;
    function OperationRef(const AValue: string): ILink<T>; overload;

    /// <summary>
    ///   O nome de uma opera��o OAS existente e resol�vel, conforme definido
    ///   com um `operationId` �nico. Este campo � mutuamente exclusivo do
    ///   campo `operationRef`.
    /// </summary>
    function OperationId: string; overload;
    function OperationId(const AValue: string): ILink<T>; overload;

    /// <summary>
    ///   Um mapa que representa par�metros a serem passados para uma opera��o.
    ///   A chave � o nome do par�metro, enquanto o valor pode ser uma constante
    ///   ou uma express�o a ser avaliada e passada para a opera��o vinculada.
    /// </summary>
    function Parameters: TOpenApiMap<string, ILink<T>>;

    /// <summary>
    ///   Um valor literal ou uma express�o para usar como corpo da requisi��o
    ///   ao chamar a opera��o de destino.
    /// </summary>
    function RequestBody: TJSONValue; overload;
    function RequestBody(const AValue: TJSONValue): ILink<T>; overload;

    /// <summary>Uma descri��o do link. A sintaxe CommonMark PODE ser usada.</summary>
    function Description: string; overload;
    function Description(const AValue: string): ILink<T>; overload;

    /// <summary>Um objeto de servidor a ser usado pela opera��o de destino.</summary>
    function Server: IServer<ILink<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>
  ///   Lista os esquemas de seguran�a necess�rios para executar uma opera��o.
  ///   Cada inst�ncia representa um objeto no array de seguran�a principal.
  /// </summary>
  ISecurityRequirement<T> = interface(IOpenApiAncestor)
    ['{E5F8C8A0-7B3A-4E1B-9A0B-9B4B1C5D7D3F}']
    /// <summary>
    ///   Define o nome do esquema de seguran�a para este requisito.
    /// </summary>
    /// <remarks>
    ///   O nome fornecido DEVE corresponder a um esquema de seguran�a
    ///   previamente declarado na se��o `components/securitySchemes`.
    ///   Este nome se tornar� a chave no objeto JSON gerado.
    ///   Exemplo: 'apiKey', 'petstore_auth'.
    /// </remarks>
    function SchemeName: string; overload;
    function SchemeName(const AValue: string): ISecurityRequirement<T>; overload;

    /// <summary>
    ///   Retorna uma lista para adicionar os escopos (scopes) necess�rios
    ///   para este esquema de seguran�a.
    /// </summary>
    /// <remarks>
    ///   - Para esquemas do tipo `oauth2` ou `openIdConnect`, esta � a lista de
    ///     nomes de escopos necess�rios (ex: 'read:pets', 'write:pets').
    ///   - Para outros tipos de esquema (como 'apiKey' ou 'http'), a
    ///     especifica��o determina que a lista deve existir, mas seu conte�do n�o
    ///     � definido. Nesses casos, a lista geralmente fica vazia.
    /// </remarks>
    function Scopes: TOpenApiList<string, ISecurityRequirement<T>>;

    /// <summary>Retorna para o objeto anterior (a lista de requisitos).</summary>
    function &End: T;
  end;

  /// <summary>Descreve um �nico header para respostas HTTP e para partes individuais em representa��es `multipart`.</summary>
  IHeader<T> = interface(IOpenApiAncestor)
    ['{27292B69-44B4-4872-A0E3-3B945C8B637B}']
    /// <summary>
    ///   Uma breve descri��o do header. Pode conter exemplos de uso.
    ///   A sintaxe CommonMark PODE ser usada.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): IHeader<T>; overload;

    /// <summary>Determina se este header � obrigat�rio. O valor padr�o � `false`.</summary>
    function Required: Boolean; overload;
    function Required(const AValue: Boolean): IHeader<T>; overload;

    /// <summary>Especifica que o header � obsoleto e DEVE ser descontinuado. O valor padr�o � `false`.</summary>
    function Deprecated: Boolean; overload;
    function Deprecated(const AValue: Boolean): IHeader<T>; overload;

    /// <summary>
    ///   Descreve como o valor do header ser� serializado. O valor padr�o
    ///   (e �nico valor legal para headers) � "simple".
    /// </summary>
    function Style: TParameterStyle; overload;
    function Style(const AValue: TParameterStyle): IHeader<T>; overload;

    /// <summary>
    ///   Quando `true`, valores de `array` ou `object` geram um �nico header
    ///   com uma lista de valores separados por v�rgula. O valor padr�o � `false`.
    /// </summary>
    function Explode: Boolean; overload;
    function Explode(const AValue: Boolean): IHeader<T>; overload;

    /// <summary>
    ///   O schema que define o tipo usado para o header.
    ///   Mutuamente exclusivo com o campo `content`.
    /// </summary>
    function Schema: ISchema;

    /// <summary>Exemplo do valor potencial do header. Mutuamente exclusivo com `examples`.</summary>
    function Example: TJSONValue; overload;
    function Example(const AValue: TJSONValue): IHeader<T>; overload;

    /// <summary>Exemplos do valor potencial do header. Mutuamente exclusivo com `example`.</summary>
    function Examples: TOpenApiMap<IExample<IHeader<T>>, IHeader<T>>;

    /// <summary>
    ///   Um mapa contendo as representa��es para o header. A chave � o
    ///   media type. O mapa DEVE conter apenas uma entrada.
    ///   Mutuamente exclusivo com o campo `schema`.
    /// </summary>
    function Content: TOpenApiMap<IMediaType<IHeader<T>>, IHeader<T>>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: T;
  end;

  /// <summary>
  ///   Adiciona metadados a uma �nica tag que � usada pelo Operation Object.
  ///   N�o � obrigat�rio ter um Tag Object por tag definida nas inst�ncias
  ///   do Operation Object.
  /// </summary>
  ITag = interface(IOpenApiAncestor)
    ['{B58BFAF7-C0FC-48D6-9687-27383C6F346E}']
    /// <summary>REQUIRED. O nome da tag.</summary>
    function Name: string; overload;
    function Name(const AValue: string): ITag; overload;

    /// <summary>
    ///   Uma descri��o para a tag. A sintaxe CommonMark PODE ser usada
    ///   para representa��o de texto rico.
    /// </summary>
    function Description: string; overload;
    function Description(const AValue: string): ITag; overload;

    /// <summary>Documenta��o externa adicional para esta tag.</summary>
    function ExternalDocs: IExternalDocumentation<ITag>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: IOpenApi;
  end;

  /// <summary>
  ///   Quando corpos de requisi��o ou payloads de resposta podem ser um de
  ///   v�rios schemas diferentes, um Discriminator Object d� uma dica sobre o
  ///   schema esperado do documento.
  /// </summary>
  IDiscriminator = interface(IOpenApiAncestor)
    /// <summary>
    ///   REQUIRED. O nome da propriedade no payload que conter� o valor
    ///   discriminador. Esta propriedade DEVE ser obrigat�ria no schema do
    ///   payload, pois o comportamento quando a propriedade est� ausente �
    ///   indefinido.
    /// </summary>
    function PropertyName: string; overload;
    function PropertyName(const AValue: string): IDiscriminator; overload;

    /// <summary>Um objeto para manter mapeamentos entre valores de payload e nomes de schema ou refer�ncias URI.</summary>
    function Mapping: TOpenApiMap<string, IDiscriminator>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: ISchema;
  end;

  /// <summary>Um objeto de metadados que permite defini��es de modelo XML mais refinadas.</summary>
  IXML = interface(IOpenApiAncestor)
    ['{01351F7C-D1BA-45E4-864A-73DDB8622511}']
    /// <summary>
    ///   Substitui o nome do elemento/atributo usado para a propriedade de
    ///   schema descrita.
    /// </summary>
    function Name: string; overload;
    function Name(const AValue: string): IXML; overload;

    /// <summary>
    ///   A URI da defini��o de namespace. O valor DEVE estar no formato de uma
    ///   URI n�o-relativa.
    /// </summary>
    function Namespace: string; overload;
    function Namespace(const AValue: string): IXML; overload;

    /// <summary>O prefixo a ser usado para o `name`.</summary>
    function Prefix: string; overload;
    function Prefix(const AValue: string): IXML; overload;

    /// <summary>
    ///   Declara se a defini��o da propriedade se traduz em um atributo em
    ///   vez de um elemento. O valor padr�o � `false`.
    /// </summary>
    function Attribute: Boolean; overload;
    function Attribute(const AValue: Boolean): IXML; overload;

    /// <summary>
    ///   PODE ser usado apenas para uma defini��o de array. Significa se o
    ///   array � encapsulado (wrapped) ou n�o. O valor padr�o � `false`.
    /// </summary>
    function Wrapped: Boolean; overload;
    function Wrapped(const AValue: Boolean): IXML; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: ISchema;
  end;

  /// <summary>Define um esquema de seguran�a que pode ser usado pelas opera��es.</summary>
  ISecurityScheme = interface(IOpenApiAncestor)
    ['{FC662617-B7E8-4221-AC7F-9CE34D0769F9}']
    /// <summary>
    ///   REQUIRED. O tipo do esquema de seguran�a. Valores v�lidos s�o:
    ///   "apiKey", "http", "mutualTLS", "oauth2", "openIdConnect".
    /// </summary>
    function &Type: TSecuritySchemeType; overload;
    function &Type(const AValue: TSecuritySchemeType): ISecurityScheme; overload;

    /// <summary>Uma descri��o para o esquema de seguran�a. A sintaxe CommonMark PODE ser usada.</summary>
    function Description: string; overload;
    function Description(const AValue: string): ISecurityScheme; overload;

    /// <summary>(apiKey) REQUIRED. O nome do header, query ou par�metro de cookie a ser usado.</summary>
    function Name: string; overload;
    function Name(const AValue: string): ISecurityScheme; overload;

    /// <summary>
    ///   (apiKey) REQUIRED. A localiza��o da chave de API. Valores v�lidos s�o:
    ///   "query", "header" ou "cookie".
    /// </summary>
    function &In: TApiKeyLocation; overload;
    function &In(const AValue: TApiKeyLocation): ISecurityScheme; overload;

    /// <summary>
    ///   (http) REQUIRED. O nome do esquema de Autentica��o HTTP a ser usado
    ///   no header Authorization. O valor � case-insensitive.
    /// </summary>
    function Scheme: string; overload;
    function Scheme(const AValue: string): ISecurityScheme; overload;

    /// <summary>
    ///   (http "bearer") Uma dica para o cliente sobre como o token bearer �
    ///   formatado. Primariamente para fins de documenta��o.
    /// </summary>
    function BearerFormat: string; overload;
    function BearerFormat(const AValue: string): ISecurityScheme; overload;

    /// <summary>
    ///   (oauth2) REQUIRED. Um objeto contendo informa��es de configura��o para
    ///   os tipos de fluxo suportados.
    /// </summary>
    function Flows: IOAuthFlows;

    /// <summary>
    /// (openIdConnect) REQUIRED. URL "Well-known" para descobrir os metadados
    /// do provedor OpenID Connect.
    /// </summary>
    function OpenIdConnectUrl: string; overload;
    function OpenIdConnectUrl(const AValue: string): ISecurityScheme; overload;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: IComponents;
  end;

  /// <summary>Detalhes de configura��o para um fluxo OAuth suportado.</summary>
  IOAuthFlow = interface(IOpenApiAncestor)
    ['{3F6E2653-4077-48F7-9C15-DD62ACF6B1DD}']
    /// <summary>
    ///   REQUIRED (`implicit`, `authorizationCode`). A URL de autoriza��o a ser
    ///   usada para este fluxo.
    /// </summary>
    function AuthorizationUrl: string; overload;
    function AuthorizationUrl(const AValue: string): IOAuthFlow; overload;

    /// <summary>
    ///   REQUIRED (`password`, `clientCredentials`, `authorizationCode`). A URL
    ///   do token a ser usada para este fluxo.
    /// </summary>
    function TokenUrl: string; overload;
    function TokenUrl(const AValue: string): IOAuthFlow; overload;

    /// <summary>A URL a ser usada para obter tokens de atualiza��o (refresh tokens).</summary>
    function RefreshUrl: string; overload;
    function RefreshUrl(const AValue: string): IOAuthFlow; overload;

    /// <summary>
    ///   REQUIRED. Os escopos dispon�veis para o esquema de seguran�a OAuth2.
    ///   Um mapa entre o nome do escopo e uma breve descri��o.
    /// </summary>
    function Scopes: TOpenApiMap<string, IOAuthFlow>;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: IOAuthFlows;
  end;

  /// <summary>Permite a configura��o dos fluxos OAuth suportados.</summary>
  IOAuthFlows = interface(IOpenApiAncestor)
    ['{2768F687-9BCC-4D9D-84D9-CDAD33C12405}']
    /// <summary>Configura��o para o fluxo OAuth Implicit.</summary>
    function Implicit: IOAuthFlow;

    /// <summary>Configura��o para o fluxo OAuth Resource Owner Password.</summary>
    function Password: IOAuthFlow;

    /// <summary>Configura��o para o fluxo OAuth Client Credentials.</summary>
    function ClientCredentials: IOAuthFlow;

    /// <summary>Configura��o para o fluxo OAuth Authorization Code.</summary>
    function AuthorizationCode: IOAuthFlow;

    /// <summary>Retorna para o objeto anterior.</summary>
    function &End: ISecurityScheme;
  end;

implementation

end.
