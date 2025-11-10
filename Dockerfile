FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS base
USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
ARG TARGETARCH
WORKDIR /src
COPY ["product-app-aws.csproj", ""]
RUN dotnet restore "product-app-aws.csproj" -a $TARGETARCH
COPY . .
WORKDIR "/src/"
RUN dotnet build "product-app-aws.csproj" -c Release -o /app/build -a $TARGETARCH

FROM build AS publish
ARG TARGETARCH
RUN dotnet publish "product-app-aws.csproj" -c Release -o /app/publish -a $TARGETARCH

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "product-app-aws.dll"]
