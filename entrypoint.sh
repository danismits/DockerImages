#!/bin/bash
sleep 5

cd /home/container

# Output Current .NET Core Version
echo "NET Core Version:"
dotnet --version

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

if hash dotnet 2>/dev/null
then
	echo "Dotnet installed."
else
	echo "Dotnet is not installed. Please install dotnet."
	exit 1
fi

echo "publishing build"
dotnet publish -c Release -o ./publish -r ubuntu.16.04-x64

echo ":/home/container$ ${MODIFIED_STARTUP}"
${MODIFIED_STARTUP}
echo "Done"
