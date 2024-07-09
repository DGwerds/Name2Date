try {
    # Ruta de la carpeta que contiene las im谩genes
    $folderPath = "C:\Users\santi\Im醙enes\Random"

    # Obtener todos los archivos .jpg y .png en la carpeta
    $files = Get-ChildItem -Path $folderPath

    # Recorrer cada archivo y renombrarlo seg煤n la fecha de creaci贸n
    foreach ($file in $files) {
        # Obtener la fecha de creaci贸n del archivo
        $creationDate = (Get-Item $file.FullName).CreationTime
        # Formatear la fecha en un formato adecuado para el nombre de archivo
        $dateString = $creationDate.ToString("yyyy-MM-dd")
        # Construir el nuevo nombre de archivo con la extensi贸n original
        $fileExtension = $file.Extension
        # Construir el nuevo nombre de archivo con la extensi髇 original
        $newFileName = "$dateString$fileExtension"
        # Ruta completa para el nuevo nombre
        $newFilePath = Join-Path -Path $folderPath -ChildPath $newFileName
        
        # Verificar si el nuevo nombre de archivo ya existe
        $counter = 1
        while (Test-Path $newFilePath) {
            # Si el archivo existe, agregar un sufijo num閞ico
            $newFileName = "$dateString`_$counter$fileExtension"
            $newFilePath = Join-Path -Path $folderPath -ChildPath $newFileName
            $counter++
        }

        # Renombrar el archivo
        Rename-Item -Path $file.FullName -NewName $newFileName
        Write-Output "Renamed: $($file.Name) -> $newFileName"
    }
} catch {
    Write-Error "Error: $($_.Exception.Message)"
}

# Pausar la ejecuci贸n para que la ventana no se cierre autom谩ticamente
Write-Output "Presiona cualquier tecla para cerrar la ventana..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
