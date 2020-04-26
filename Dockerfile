# Stage 1
# Create a Initial Image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app

# Stage 2
# Create a Second Image from build and publish a version
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY . .
RUN dotnet restore

#State 3
FROM build As publish
RUN dotnet publish -c Release -o /app

# Stage 4
# Creating a final Image for expose the WebApp into Container
FROM base AS final
LABEL Author="Billy Vanegas"  
LABEL Maintainer="Project Web App  Deployment Example in Docker"  
COPY --from=publish /app .
WORKDIR /app
COPY MvcMovie.db .
ENTRYPOINT ["dotnet", "iis.dll"]