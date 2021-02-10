cd "%2"
"C:\Program Files\7-Zip\7z.exe" -ttar -so a dummy.tar "%1" | "C:\Program Files\7-Zip\7z.exe" -si -tgzip a "%1.tgz"
move "%1.tgz" "%3\%1.tgz"