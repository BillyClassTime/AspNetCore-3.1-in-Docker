# Implementiing a Web App Project in Docker (Spanish/English)
<p>El código utliza un proyecto web con las siguientes especificaciones</p>

- Razor Pages web app with ASP.NET Core
    - Microsoft.VisualStudio.Web.CodeGeneration.Design
- SQLite database
    - Microsoft.EntityFrameworkCore.SQLite
    - Microsoft.EntityFrameworkCore.SqlServer

<p>Versiones en utilizadas:</p>
- DotNetCore version

![dotnet version](/images/dotnetversion.png?raw=true)

</p>
- Docker version

![docker version](images/dockerversion.png?raw=true)

## Pasos antes del despliegue en Docker
- Ejecutar la aplicación Razor web en local
- Verificar que no tenga ningún error

### Anyone Web app Project Works - Recomend for this the following tutorial:
Tutorial: Create a Razor Pages web app with ASP.NET Core

- This series includes the following tutorials:
    - Create a Razor Pages web app
    - Add a model to a Razor Pages app
    - Scaffold (generate) Razor pages
    - Work with a database
    - Update Razor pages
    - Add search
    - Add a new field
    - Add validation

[!NOTE] 
The current reviewing (and code in this project) goes in this step:
Update the generated pages in an ASP.NET Core app
https://docs.microsoft.com/en-us/aspnet/core/tutorials/razor-pages/da1?view=aspnetcore-3.1

### Deploy the project in local (Optional)
To deploy (Publish a web project)
dotnet publish -c Release -o ./content

##  Docker Section
### Creamos un fichero Docker para esta implementación
``` 
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
```

### Deploying in Docker
- From VS CODE -> Click Rigth Build image menu in Docker Extension
[!TIP]
docker build -t iis:latest . (DO NOT DO IT, IF YOU USE DOCKER EXTENSION IN VS CODE)
- docker run -d -p 8000:80 --name DotNetWebApp iis:latest

### Enter Data in Web Browser 
Open a browse from container and enter the next record
- Name: Boy Hood
- Date: July 11 2014
- Genre: Drama
- Price: 5.43


##  Recomended extra readings
- https://www.c-sharpcorner.com/article/entity-framework-core-with-sql-server-in-docker-container/
- https://www.c-sharpcorner.com/article/entity-framework-core-in-docker-container-part-ii-sqlite/

## Referencia de Imagenes para IIS
- https://github.com/microsoft/iis-docker
