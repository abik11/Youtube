###########################
# .SYNOPSIS
# The Get-PlaylistDuration function counts the whole duration of audio files in given directory
# .DESCRIPTION
# The Get-PlaylistDuration function uses Shell COM object to get the data about the duration of
# each audio file in given directory and then returns in format hh:mm:ss as a string.
# .EXAMPLE
# Get-PlaylistDuration -Playlist .\music\romanticSongs
# .INPUTS
# System.String
#   Path to a directory that contains audio files
# .OUTPUTS
# System.String
#   A string of a format hh:mm:ss describing the duration of all the audio files in given directory
# .LINKS
# https://msdn.microsoft.com/pl-pl/library/windows/desktop/bb774094(v=vs.85).aspx
###########################
function Get-PlaylistDuration{
    [cmdletbinding()]
    Param(
        # Path to a directory that contains audio files
        [Parameter(mandatory = $true, position = 0)]
        [Alias('Playlist', 'Dir')]
        [string]$PlaylistDir
    )
    $shell = New-Object -ComObject Shell.Application
    $files = Get-ChildItem $PlaylistDir
    $folder = Split-Path ($files | Select-Object -First 1).FullName.ToString() 
    $shellFolder = $shell.NameSpace($folder)

    $hours = 0; $minutes = 0; $seconds = 0;
    $files | ForEach-Object { 
      $file = Split-Path $_ -leaf
      $shellFile = $shellfolder.ParseName($file)
      $time = $shellfolder.GetDetailsOf($shellfile, 27) -split ":"
      $hours += $time[0]
      $minutes += $time[1]
      $seconds += $time[2]
    }

    $totalMinutes = ($hours*60) + $minutes + ($seconds/60)
    $totalHours = $totalMinutes / 60 
    $moduloMinutes = $totalMinutes % 60 
    $moduloSeconds = $moduloMinutes % 60
    
    return "{0:##}:{1:##}:{2:##}" `
        -f [math]::Floor($totalHours), [math]::Floor($moduloMinutes), [math]::Floor($moduloSeconds)
}
