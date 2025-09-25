unit Horse.Documentation.OpenApi.ExternalDocumentation;

interface

uses
  System.JSON,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  Horse.Documentation.OpenApi.Types,
  Horse.Documentation.OpenApi.Ancestor,
  Horse.Documentation.OpenApi.Interfaces;

type
  TExternalDocumentation<T> = class(TOpenApiAncestor, IExternalDocumentation<T>)
  private
    FParent: T;
    FDescription: string;
    FUrl: string;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): IExternalDocumentation<T>; static;
    function ToJson: TJSONObject;

    function Description: string; overload;
    function Description(const AValue: string): IExternalDocumentation<T>; overload;
    function Url: string; overload;
    function Url(const AValue: string): IExternalDocumentation<T>; overload;
    function &End: T;
  end;

implementation

{ TExternalDocumentation<T> }

constructor TExternalDocumentation<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
end;

function TExternalDocumentation<T>.Description: string;
begin
  Result := FDescription;
end;

function TExternalDocumentation<T>.Description(const AValue: string): IExternalDocumentation<T>;
begin
  Result := Self;
  FDescription := AValue;
end;

function TExternalDocumentation<T>.&End: T;
begin
  Result := FParent;
end;

class function TExternalDocumentation<T>.New(AParent: T): IExternalDocumentation<T>;
begin
  Result := TExternalDocumentation<T>.Create(AParent);
end;

function TExternalDocumentation<T>.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  Result.AddPair('url', FUrl);

  if not FDescription.IsEmpty then
    Result.AddPair('description', FDescription);
end;

function TExternalDocumentation<T>.Url: string;
begin
  Result := FUrl;
end;

function TExternalDocumentation<T>.Url(const AValue: string): IExternalDocumentation<T>;
begin
  Result := Self;
  FUrl := AValue;
end;

end.
