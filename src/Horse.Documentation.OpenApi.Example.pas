unit Horse.Documentation.OpenApi.Example;

interface

uses
  System.JSON,
  System.Rtti,
  System.Classes,
  System.TypInfo,
  System.SysUtils,
  System.Generics.Collections,
  Horse.Documentation.OpenApi.Utils,
  Horse.Documentation.OpenApi.Types,
  Horse.Documentation.OpenApi.Ancestor,
  Horse.Documentation.OpenApi.Interfaces;

type
  TExample<T> = class(TOpenApiAncestor, IExample<T>)
  private
    FParent: T;
    FSummary: string;
    FDescription: string;
    FValue: TJSONValue;
    FExternalValue: string;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): IExample<T>; static;
    function ToJson: TJSONObject;

    function Summary: string; overload;
    function Summary(const AValue: string): IExample<T>; overload;
    function Description: string; overload;
    function Description(const AValue: string): IExample<T>; overload;
    function Value: TJSONValue; overload;
    function Value(const AValue: TJSONValue): IExample<T>; overload;
    function ExternalValue: string; overload;
    function ExternalValue(const AValue: string): IExample<T>; overload;
    function &End: T;
  end;

implementation

{ TExample<T> }

constructor TExample<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
end;

function TExample<T>.Description: string;
begin
  Result := FDescription;
end;

function TExample<T>.Description(const AValue: string): IExample<T>;
begin
  Result := Self;
  FDescription := AValue;
end;

function TExample<T>.&End: T;
begin
  Result := FParent;
end;

function TExample<T>.ExternalValue: string;
begin
  Result := FExternalValue;
end;

function TExample<T>.ExternalValue(const AValue: string): IExample<T>;
begin
  Result := Self;
  FExternalValue := AValue;
end;

class function TExample<T>.New(AParent: T): IExample<T>;
begin
  Result := TExample<T>.Create(AParent);
end;

function TExample<T>.Summary: string;
begin
  Result := FSummary;
end;

function TExample<T>.Summary(const AValue: string): IExample<T>;
begin
  Result := Self;
  FSummary := AValue;
end;

function TExample<T>.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if not FDescription.IsEmpty then
    Result.AddPair('description', FDescription);

  if not FSummary.IsEmpty then
    Result.AddPair('summary', FSummary);

  if not FExternalValue.IsEmpty then
    Result.AddPair('externalValue', FExternalValue);

  if FValue <> nil then
    Result.AddPair('value', FValue);
end;

function TExample<T>.Value: TJSONValue;
begin
  Result := FValue;
end;

function TExample<T>.Value(const AValue: TJSONValue): IExample<T>;
begin
  Result := Self;
  FValue := AValue;
end;

end.
