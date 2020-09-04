param (

    $base = ".",

    $dpth = 2
)

$gitFolderName = ".git"

function Go () {

    $gitFolders = Get-ChildItem -Path $base -depth $dpth -Recurse -Force | Where-Object { $_.Mode -match "h" -and $_.FullName -like "*\$gitFolderName" }

    ForEach ($gitFolder in $gitFolders) {

        $folder = $gitFolder.FullName.Substring(0, $gitFolder.FullName.Length - $gitFolderName.Length)

        Write-Host "'$folder'" -foregroundColor "green"

        Push-Location $folder 
        
        #& git status

        & git add .
        & git commit -m "backup"
        & git push origin master

        Pop-Location
    }
}

function Main () {  

    Go   
}

Main

# .\git.ps1