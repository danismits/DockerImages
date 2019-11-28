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

File=publish/Lekkercraft.dll
UnpublishedProjectFolder=Lekkercraft

if [ -f "$File" ]; 
then
    echo "Project is already published"	
else
	echo "publishing project"	
	dotnet publish Lekkercraft/Lekkercraft.csproj -c Release -o ../publish
fi

if [ -f "$File" ]; 
then
	if [ -d "$UnpublishedProjectFolder" ] 
	then
		echo "Old folder still exists. Removing it now"
		rm -rf "$UnpublishedProjectFolder"
	fi
fi

echo ":/home/container$ ${MODIFIED_STARTUP}"
${MODIFIED_STARTUP}
echo "Done"
