# Usage: scripts/export_docx.ps1 <SourceMarkdownPath> <DestDocxPath>

$ErrorActionPreference = 'Stop'

if ($args.Count -lt 2) {
    throw "Usage: scripts/export_docx.ps1 <SourceMarkdownPath> <DestDocxPath>"
}

$Source = $args[0]
$Dest = $args[1]

if (-not (Test-Path -LiteralPath $Source)) {
    throw "Source file not found: $Source"
}

# Ensure destination directory exists
$destDir = Split-Path -Path $Dest -Parent
if ($destDir -and -not (Test-Path -LiteralPath $destDir)) {
    New-Item -ItemType Directory -Force -Path $destDir | Out-Null
}

# Read source as UTF-8 text
$text = Get-Content -LiteralPath $Source -Raw -Encoding UTF8
$lines = $text -split "`r?`n"

$word = $null
$doc = $null
try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $doc = $word.Documents.Add()

    # Configure RTL + Hebrew defaults
    $normal = $doc.Styles.Item("Normal")
    $normal.ParagraphFormat.ReadingOrder = 2            # wdReadingOrderRtl
    $normal.ParagraphFormat.Alignment = 2               # wdAlignParagraphRight
    $normal.Font.Name = "Arial"

    foreach ($h in @("Heading 1","Heading 2","Heading 3")) {
        $st = $doc.Styles.Item($h)
        $st.ParagraphFormat.ReadingOrder = 2
        $st.ParagraphFormat.Alignment = 2
        $st.Font.Name = "Arial"
    }

    function Write-Paragraph([string]$text, [string]$styleName) {
        $sel = $word.Selection
        $sel.Style = $doc.Styles.Item($styleName)
        if ([string]::IsNullOrWhiteSpace($text)) {
            $sel.TypeParagraph() | Out-Null
        } else {
            $sel.TypeText($text) | Out-Null
            $sel.TypeParagraph() | Out-Null
        }
    }

    $inCode = $false
    foreach ($line in $lines) {
        if ($line -match '^```') {
            # Toggle code block, keep as Normal with monospace indicator
            $inCode = -not $inCode
            continue
        }
        if ($inCode) {
            Write-Paragraph $line "Normal"
            continue
        }
        if ($line -match '^\s*#{3}\s+(.*)') {
            Write-Paragraph $Matches[1] "Heading 3"
            continue
        }
        if ($line -match '^\s*#{2}\s+(.*)') {
            Write-Paragraph $Matches[1] "Heading 2"
            continue
        }
        if ($line -match '^\s*#\s+(.*)') {
            Write-Paragraph $Matches[1] "Heading 1"
            continue
        }
        if ($line -match '^\s*[-*]\s+(.*)') {
            Write-Paragraph ("• " + $Matches[1]) "Normal"
            continue
        }
        Write-Paragraph $line "Normal"
    }

    # Save as DOCX (wdFormatDocumentDefault = 16)
    $format = 16
    $doc.SaveAs([ref]$Dest, [ref]$format) | Out-Null
}
finally {
    if ($null -ne $doc) { $doc.Close($true) | Out-Null }
    if ($null -ne $word) { $word.Quit() | Out-Null }
}
