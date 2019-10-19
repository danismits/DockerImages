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

File=publish/DisBocus-Bot.dll
UnpublishedProjectFolder=DisBocus-Bot

if [ -f "$File" ]; 
then
    echo "Project is already published"
	if [ -d "$UnpublishedProjectFolder" ] 
	then
		echo "Old folder still exists"
	fi
else
	echo "publishing project"	
	dotnet publish DisBocus-Bot/DisBocus-Bot.csproj -c Release -o ../publish
fi

echo ":/home/container$ ${MODIFIED_STARTUP}"
${MODIFIED_STARTUP}
echo "Done"
