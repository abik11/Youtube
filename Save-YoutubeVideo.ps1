###########################
# .SYNOPSIS
# The Save-YoutubeVideo function downloads youtube video from given link
# .DESCRIPTION
# The Save-YoutubeVideo  function uses youtube-dl.exe program to download youtube videos from 
# given URL. Downloaded video file has the same name as the video on youtube.
# It is a good idea to update youtube-dl.exe from time to time when it will throw unexpected errors.
# .EXAMPLE
# 'https://www.youtube.com/watch?v=0mFFFc_oyBo' | Save-YoutubeVideo
# .INPUTS
# System.String
#   URI to the youtube video that will be downloaded
# .LINKS
# https://github.com/rg3/youtube-dl
###########################
function Save-YoutubeVideo {
    [cmdletbinding()]
    Param(
        # Youtube video URL 
        [Parameter(mandatory = $true, ValueFromPipeline = $true, position = 0)]
        [Alias('Href', 'Link')]
        [string] $URL,
        # Output directory where to put downloaded video, ex. 'D:\videos', 'my\secret\vids'
        [Parameter(position = 1)]
        [Alias('Out', 'O')]
        [string] $OutputDir = "\Output",
        # Directory where youtube-dl.exe is put, it is recommended to leave this default
        [Alias('YTDir')]
        [string] $YoutubeDownloaderDir = "."
    )
    Begin {
        [string]$Dir = Get-YoutubeDlDir -YTDir $YoutuveDownloaderDir
    }
    Process {       
        Write-Verbose "Downloading the video..."
        & "$Dir\youtube-dl.exe" $URL -o "$OutputDir\%(title)s.%(ext)s"
    }
}
