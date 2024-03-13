param(
    [String] $downloader = ".\yt-dlp.exe",
    [String] $outputdir = "D:\Temp\",
    [Parameter(Position=0, mandatory=$true)]
    [String] $url
)

# $command = "$downloader `
#     --format-sort-force -S ""abr,acodec"" `
#     --part --write-thumbnail `
#     --external-downloader ffmpeg --external-downloader-args ""ffmpeg_i:-t 00:00:10.00"" `
#     --output ""$outputdir%(title)s.%(ext)s"" `
#     $url" 

# $command = "$downloader --format-sort-force -S ""abr,acodec"" -k --part --write-thumbnail --output ""$outputdir%(title)s.%(ext)s"" $url"    
# Write-Host $command -ForegroundColor DarkGreen

$command = "$downloader --list-formats $url"    
Invoke-Expression $command

$format_id = Read-Host "Select format id" 
if ($format_id) {
    Invoke-Expression "$downloader --format $format_id --add-metadata --embed-thumbnail --output ""$outputdir%(title)s.%(ext)s"" $url"
}else {
    Write-Host "Nothing selected" -ForegroundColor DarkYellow
}
