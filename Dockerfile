# Use the official .NET SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy .csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the build output from the build stage
COPY --from=build /app/out .

# Expose port (adjust to match your API's launch settings)
EXPOSE 8080

# Set the entry point for the container
ENTRYPOINT ["dotnet", "TodoApi.dll"]
