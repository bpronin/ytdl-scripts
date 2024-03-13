param(
    [Parameter(Position = 0)]
    [String] $URL,
    [String] $OutputDir = "d:\temp",
    [String] $FfmpegHome = "c:\opt\ffmpeg\bin",
    [String] $YtdlHome = "c:\opt\yt-download"
)

if (-not $URL) {
    $Clip = $(Get-Clipboard) -as [System.URI]
    if ($Clip.AbsoluteURI -and $Clip.Scheme -match '[http|https]') {
        if (-not ($URL = Read-Host "URL [$Clip]")) { 
            $URL = $Clip
        }            
    }
    else {
        $URL = Read-Host "URL"
    }
}

if ($MaxSize = Read-Host "Max file size [all]") { 
    $MaxSizeOption = "--max-filesize $MaxSize"
}

Invoke-Expression ("$YtdlHome\yt-dlp --format bestaudio[ext=m4a] --add-metadata --write-thumbnail --no-part " + 
    "$MaxSizeOption --ffmpeg-location $FfmpegHome --output `"$OutputDir\%(title)s.%(ext)s`" $URL")

if ($LastExitCode -ne 0) {
    Read-Host 'Press any key'    
}
