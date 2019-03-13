# Youtube
Module for downloading youtube videos from given list

## Install 
First you need to download [ffmpeg.exe](https://www.ffmpeg.org/download.html) and [youtube-dl.exe](https://youtube-dl.org/) and put both exe files in the main directory of Youtube module. <br />
Then use following command to import it: <br />
`ipmo Youtube.psd1`

## Usage
You can download youtube videos or download them and convert to MP3, use the following commands:
```powershell
Save-YoutubeTextPlaylistAsMP3 -Playlist songs\playlist.txt          #downloading list of videos as MP3
'https://www.youtube.com/watch?v=0mFFFc_oyBo' | Save-YoutubeVideo   #downloading signle video
```

The videos on the list must be separated by the new line, for example:
```text
https://www.youtube.com/watch?v=0mFFFc_oyBo
https://www.youtube.com/watch?v=bAKYqXil5fM
```
### Updating youtube-dl
Often you may see an error with the following message:
```
Make sure you are using the latest version; type  youtube-dl -U  to update.
```
All you have to do to solve the issue is to run the command: `youtube-dl -U` as said in the error message, which will update youtube-dl to the newest version.
