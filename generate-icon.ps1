# Generates favicon.ico from the checkmark design
Add-Type -AssemblyName System.Drawing

$sizes = @(16, 32, 48, 64, 128, 256)
$bitmaps = @()

foreach ($size in $sizes) {
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

    # Background (rounded rectangle approximation via gradient)
    $bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Point(0, 0)),
        (New-Object System.Drawing.Point($size, $size)),
        [System.Drawing.Color]::FromArgb(124, 92, 252),
        [System.Drawing.Color]::FromArgb(155, 130, 253)
    )
    $radius = [Math]::Floor($size * 0.22)
    $rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
    $g.FillRectangle($bgBrush, $rect)

    # Checkmark
    $penWidth = [Math]::Max(1, [Math]::Floor($size * 0.09))
    $checkPen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, $penWidth)
    $checkPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $checkPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $checkPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round

    $x1 = $size * 0.28
    $y1 = $size * 0.52
    $x2 = $size * 0.42
    $y2 = $size * 0.66
    $x3 = $size * 0.72
    $y3 = $size * 0.34

    $g.DrawCurve($checkPen, @(
        (New-Object System.Drawing.PointF($x1, $y1)),
        (New-Object System.Drawing.PointF($x2, $y2)),
        (New-Object System.Drawing.PointF($x3, $y3))
    ))

    $g.Dispose()
    $bitmaps += $bmp
}

# Save as multi-size ICO
$icoPath = Join-Path $PSScriptRoot "favicon.ico"
$fs = [System.IO.File]::Create($icoPath)
$bw = New-Object System.IO.BinaryWriter($fs)

# ICO header
$bw.Write([UInt16]0)        # reserved
$bw.Write([UInt16]1)        # type: 1 = icon
$bw.Write([UInt16]($bitmaps.Count))  # image count

# Calculate offsets
$dirSize = 6 + ($bitmaps.Count * 16)
$offset = $dirSize

$imageEntries = @()

for ($i = 0; $i -lt $bitmaps.Count; $i++) {
    $bmp = $bitmaps[$i]
    $ms = New-Object System.IO.MemoryStream
    $bmp.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
    $pngBytes = $ms.ToArray()
    $ms.Dispose()

    $w = if ($bmp.Width -ge 256) { 0 } else { $bmp.Width }
    $h = if ($bmp.Height -ge 256) { 0 } else { $bmp.Height }

    $imageEntries += @{
        Width = $w
        Height = $h
        PngBytes = $pngBytes
        Offset = $offset
    }

    $offset += $pngBytes.Length
}

# Write directory entries
foreach ($entry in $imageEntries) {
    $bw.Write([Byte]$entry.Width)
    $bw.Write([Byte]$entry.Height)
    $bw.Write([Byte]0)        # colors
    $bw.Write([Byte]0)        # reserved
    $bw.Write([UInt16]1)      # planes
    $bw.Write([UInt16]32)     # bits per pixel
    $bw.Write([UInt32]$entry.PngBytes.Length)
    $bw.Write([UInt32]$entry.Offset)
}

# Write image data
foreach ($entry in $imageEntries) {
    $bw.Write($entry.PngBytes)
}

$bw.Dispose()
$fs.Dispose()

# Cleanup bitmaps
foreach ($bmp in $bitmaps) { $bmp.Dispose() }

Write-Host "Created: $icoPath"
