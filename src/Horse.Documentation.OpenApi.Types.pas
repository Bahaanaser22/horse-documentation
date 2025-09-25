unit Horse.Documentation.OpenApi.Types;

interface

uses
  System.JSON,
  System.Rtti,
  System.TypInfo,
  System.SysUtils,
  System.Generics.Collections;

type
  /// <summary>Define os locais poss�veis para um par�metro.</summary>
  TParameterLocation = (plQuery, plHeader, plPath, plCookie);

  TParameterLocationHelper = record helper for TParameterLocation
  public
    function ToString: string;
  end;

  /// <summary>Define os estilos de serializa��o para um par�metro.</summary>
  TParameterStyle = (psMatrix, psLabel, psSimple, psForm, psSpaceDelimited, psPipeDelimited, psDeepObject);

  TParameterStyleHelper = record helper for TParameterStyle
  public
    function ToString: string;
  end;

  /// <summary>Define os tipos de esquemas de seguran�a.</summary>
  TSecuritySchemeType = (sstApiKey, sstHttp, sstMutualTLS, sstOAuth2, sstOpenIdConnect);

  TSecuritySchemeTypeHelper = record helper for TSecuritySchemeType
  public
    function ToString: string;
  end;

  /// <summary>Define a localiza��o de uma chave de API.</summary>
  TApiKeyLocation = (aklQuery, aklHeader, aklCookie);

  TApiKeyLocationHelper = record helper for TApiKeyLocation
  public
    function ToString: string;
  end;

  /// <summary>
  ///   Uma lista especializada para as interfaces da OpenAPI.
  ///   Permite a cria��o autom�tica de inst�ncias de uma classe de
  ///   implementa��o registrada, facilitando o uso do padr�o Builder.
  /// </summary>
  TOpenApiList<T, O> = class(TList<T>)
  private
    FOwner: O;
    FImplClass: TClass;
    FCreateMethod: TRttiMethod;
    FRttiContext: TRttiContext;
  public
    /// <summary>
    ///   Cria a lista e a prepara para o padr�o Builder.
    /// </summary>
    /// <param name="AOwner">
    ///   A inst�ncia do objeto "pai" ao qual os novos itens pertencer�o.
    ///   Usado para a navega��o de volta com a fun��o &End.
    /// </param>
    /// <param name="AImplClass">
    ///   A classe concreta que implementa a interface T.
    ///   Esta classe DEVE ter um m�todo est�tico "New" que aceita o Owner como par�metro.
    ///   Ex: class function New(AOwner: IOpenApi): IServer;
    /// </param>
    constructor Create(AOwner: O; AImplClass: TClass = nil); overload;

    /// <summary>
    ///   Cria uma lista simples, sem a capacidade de adicionar
    ///   automaticamente novas inst�ncias.
    /// </summary>
    constructor Create; overload;
    destructor Destroy; override;

    /// <summary>
    ///   Cria uma nova inst�ncia da classe registrada,
    ///   adiciona-a � lista e a retorna para constru��o fluente.
    ///   S� funciona se a lista foi criada com o construtor que recebe AImplClass.
    /// </summary>
    function Add: T; overload;

    /// <summary>
    ///   Cria uma nova inst�ncia da classe registrada, adiciona-a ao mapa com
    ///   a chave especificada e a retorna para constru��o fluente.
    /// </summary>
    function Add(const AValue: T): O; overload;

    /// <summary>
    ///   Alias para Add. Cria uma nova inst�ncia, adiciona e retorna.
    /// </summary>
    function Append: T;

    /// <summary>
    ///   Alias para Add. Cria uma nova inst�ncia, adiciona e retorna.
    /// </summary>
    function Push: T;

    /// <summary>
    ///   Remove o �ltimo elemento da lista e o retorna, sem liberar sua mem�ria.
    /// </summary>
    function Pop: T;

    function ToJson: TJSONArray;
  end;

  /// <summary>Um mapa especializado para as interfaces da OpenAPI.</summary>
  TOpenApiMap<T, O> = class(TDictionary<string, T>)
  private
    FOwner: O;
    FImplClass: TClass;
    FCreateMethod: TRttiMethod;
    FRttiContext: TRttiContext;
  public
    /// <summary>
    ///   Cria o mapa e o prepara para o padr�o Builder.
    /// </summary>
    /// <param name="AOwner">
    ///   A inst�ncia do objeto "pai" ao qual os novos itens pertencer�o.
    /// </param>
    /// <param name="AImplClass">
    ///   A classe concreta que implementa a interface T.
    ///   Deve ter um m�todo est�tico "New" que aceita o Owner como par�metro.
    /// </param>
    constructor Create(AOwner: O; AImplClass: TClass = nil); overload;

    /// <summary>
    ///   Cria um mapa simples, sem a capacidade de adicionar
    ///   automaticamente novas inst�ncias.
    /// </summary>
    constructor Create; overload;
    destructor Destroy; override;

    /// <summary>
    ///   Cria uma nova inst�ncia da classe registrada, adiciona-a ao mapa com
    ///   a chave especificada e a retorna para constru��o fluente.
    /// </summary>
    function Add(const AKey: string): T; overload;

    /// <summary>
    ///   Cria uma nova inst�ncia da classe registrada, adiciona-a ao mapa com
    ///   a chave especificada e a retorna para constru��o fluente.
    /// </summary>
    function Add(const AKey: string; const AValue: T): O; overload;

    function ToJson: TJSONObject;
  end;

implementation

uses
  Horse.Documentation.OpenApi.Utils,
  Horse.Documentation.OpenApi.Interfaces;

{ TOpenApiList<T, O> }

constructor TOpenApiList<T, O>.Create;
begin
  // AOwnsObjects = True � o padr�o para TObjectList, o que garante que as
  // interfaces adicionadas ser�o liberadas quando a lista for destru�da.
  inherited Create;
  FImplClass    := nil;
  FCreateMethod := nil;
end;

destructor TOpenApiList<T, O>.Destroy;
begin
  FRttiContext.Free;
  inherited;
end;

constructor TOpenApiList<T, O>.Create(AOwner: O; AImplClass: TClass);
var
  LRttiType: TRttiType;
  LMethod: TRttiMethod;
begin
  Create;
  FOwner := AOwner;
  FImplClass := AImplClass;

  if FImplClass = nil then
    Exit;

  FRttiContext := TRttiContext.Create;
  FRttiContext.KeepContext;
  LRttiType := FRttiContext.GetType(FImplClass);

  for LMethod in LRttiType.GetMethods('New') do
  begin
    if LMethod.IsStatic and (Length(LMethod.GetParameters) = 1) then
    begin
      FCreateMethod := LMethod;
      Exit;
    end;
  end;

  if FCreateMethod = nil then
    raise ENotSupportedException.CreateFmt(
      'A classe "%s" n�o possui um m�todo de f�brica compat�vel (ex: class function New(AOwner: T): T).',
      [FImplClass.ClassName]);
end;

function TOpenApiList<T, O>.Add: T;
var
  LNewInstanceValue: TValue;
begin
  if FCreateMethod = nil then
    raise ENotImplemented.Create(
      'O m�todo Add sem par�metros s� pode ser usado com o construtor ' +
      'que especifica uma classe de implementa��o (AImplClass).');

  LNewInstanceValue := FCreateMethod.Invoke(FImplClass, [TValue.From<O>(FOwner)]);
  Result := LNewInstanceValue.AsType<T>;
  inherited Add(Result);
end;

function TOpenApiList<T, O>.Add(const AValue: T): O;
begin
  inherited Add(AValue);
  Result := FOwner;
end;

function TOpenApiList<T, O>.Append: T;
begin
  Result := Add;
end;

function TOpenApiList<T, O>.Push: T;
begin
  Result := Add;
end;

function TOpenApiList<T, O>.ToJson: TJSONArray;
var
  LItem: T;
begin
  Result := TJSONArray.Create;
  for LItem in Self do
  begin
    if FImplClass <> nil then
      Result.AddElement(TValue.From<T>(LItem).AsType<IOpenApiAncestor>.ToJson)
    else
      Result.AddElement(TUtils.ValueToJson(TValue.From<T>(LItem)))
  end;
end;

function TOpenApiList<T, O>.Pop: T;
begin
  if Count = 0 then
    raise EListError.Create('A lista est� vazia.');

  Result := Last;
  Delete(Count - 1);
end;

{ TOpenApiMap<T, O> }

function TOpenApiMap<T, O>.Add(const AKey: string): T;
var
  LNewInstanceValue: TValue;
begin
  // Otimizado: Usa o FCreateMethod armazenado
  if FCreateMethod = nil then
    raise ENotImplemented.Create(
      'O m�todo Add com cria��o autom�tica s� pode ser usado com o construtor ' +
      'que especifica uma classe de implementa��o (AImplClass).');

  if ContainsKey(AKey) then
    Exit(Items[AKey]);

  LNewInstanceValue := FCreateMethod.Invoke(FImplClass, [TValue.From<O>(FOwner)]);
  Result := LNewInstanceValue.AsType<T>;
  inherited Add(AKey, Result);
end;

constructor TOpenApiMap<T, O>.Create(AOwner: O; AImplClass: TClass);
var
  LRttiType: TRttiType;
  LMethod: TRttiMethod;
begin
  Create; // Chama o construtor padr�o para inicializar
  FOwner := AOwner;
  FImplClass := AImplClass;

  if FImplClass = nil then
    Exit;

  FRttiContext := TRttiContext.Create;
  FRttiContext.KeepContext;
  LRttiType := FRttiContext.GetType(FImplClass);

  for LMethod in LRttiType.GetMethods('New') do
  begin
    if LMethod.IsStatic and (Length(LMethod.GetParameters) = 1) then
    begin
      FCreateMethod := LMethod;
      Exit;
    end;
  end;

  if FCreateMethod = nil then
    raise ENotSupportedException.CreateFmt(
      'A classe "%s" n�o possui um m�todo de f�brica compat�vel (ex: class function New(AOwner: T): T).',
      [FImplClass.ClassName]);
end;

function TOpenApiMap<T, O>.Add(const AKey: string; const AValue: T): O;
begin
  // Otimizado: Usa o FCreateMethod armazenado
  if FCreateMethod <> nil then
    raise ENotImplemented.Create(
      'O m�todo Add sem cria��o autom�tica s� pode ser usado com o construtor ' +
      'que n�o especifica uma classe de implementa��o (AImplClass).');

  inherited Add(AKey, AValue);
  Result := FOwner;
end;

constructor TOpenApiMap<T, O>.Create;
begin
  inherited Create;
  FImplClass    := nil;
  FCreateMethod := nil;
end;

destructor TOpenApiMap<T, O>.Destroy;
begin
  FRttiContext.Free;
  inherited;
end;

function TOpenApiMap<T, O>.ToJson: TJSONObject;
var
  LPair: TPair<string, T>;
begin
  Result := TJSONObject.Create;
  for LPair in Self do
  begin
    if FImplClass <> nil then
      Result.AddPair(LPair.Key, TValue.From<T>(LPair.Value).AsType<IOpenApiAncestor>.ToJson)
    else
      Result.AddPair(LPair.Key, TUtils.ValueToJson(TValue.From<T>(LPair.Value)));
  end;
end;

{ TParameterLocationHelper }

function TParameterLocationHelper.ToString: string;
begin
  case Self of
    plQuery:  Result := 'query';
    plHeader: Result := 'header';
    plPath:   Result := 'path';
    plCookie: Result := 'cookie';
  end;
end;

{ TParameterStyleHelper }

function TParameterStyleHelper.ToString: string;
begin
  case Self of
    psMatrix:         Result := 'matrix';
    psLabel:          Result := 'label';
    psSimple:         Result := 'simple';
    psForm:           Result := 'form';
    psSpaceDelimited: Result := 'spaceDelimited';
    psPipeDelimited:  Result := 'pipeDelimited';
    psDeepObject:     Result := 'deepObject';
  end;
end;

{ TSecuritySchemeTypeHelper }

function TSecuritySchemeTypeHelper.ToString: string;
begin
  case Self of
    sstApiKey:        Result := 'apiKey';
    sstHttp:          Result := 'http';
    sstMutualTLS:     Result := 'mutualTLS';
    sstOAuth2:        Result := 'oauth2';
    sstOpenIdConnect: Result := 'openIdConnect';
  end;
end;

{ TApiKeyLocationHelper }

function TApiKeyLocationHelper.ToString: string;
begin
  case Self of
    aklQuery:  Result := 'query';
    aklHeader: Result := 'header';
    aklCookie: Result := 'cookie';
  end;
end;

end.
