<!DOCTYPE html>
<html>
<head>
    <title>Expediente</title>
    <style>
        body { font-family: sans-serif; }
        h1 { text-align: center; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #000; padding: 5px; }
    </style>
</head>
<body>
    <h1>Expediente Único - SGP</h1>
    <p><strong>Recluso:</strong> <?php echo e($recluso->nombres); ?> <?php echo e($recluso->apellidos); ?></p>
    <p><strong>Cédula:</strong> <?php echo e($recluso->cedula_identidad); ?></p>
    <p><strong>Riesgo:</strong> <?php echo e($recluso->nivel_riesgo); ?></p>
    
    <h3>Causas</h3>
    <table>
        <thead>
            <tr><th>Nº Causa</th><th>Delito</th><th>Estado</th></tr>
        </thead>
        <tbody>
            <?php $__currentLoopData = $recluso->causas; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $causa): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
            <tr>
                <td><?php echo e($causa->numero_unico); ?></td>
                <td><?php echo e($causa->delito_principal); ?></td>
                <td><?php echo e($causa->estado_procesal); ?></td>
            </tr>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
        </tbody>
    </table>
</body>
</html>
<?php /**PATH /home/p2asolucionesve/Documentos/Proyectos/sgp/backend/resources/views/pdf/expediente.blade.php ENDPATH**/ ?>