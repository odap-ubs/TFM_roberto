# TFM_roberto

Estos son la mayoria de scripts utilizados para el analisis de muestras de RNAseq para la deteccion de neoantigenos;

1. Generacion de archivos Fastq (opcional)
2. Separacion de archivos Fastq en pair-end (unicamente si es pair end, en caso de single end no es necesario)
3. Trimmado (parametros del trimmado se pueden cambiar segun se necesite)
4. Control de calidad con Fastqc
5. Alineamiento y y cuantificacion de expresion (el script hace uso de una funcion no disponible en este apartado)
6. Añadir Read Groups
7. Marcado de duplicados
8. SplitNcigar
9. Base Recalibration
10. Haplotypecaller (primer variant calling)
11. Mutect2 apareado (segundo variant calling con muestra normal apareada)
12. Mutect2 apareado (segundo variant calling sin muestra normal apareada)
