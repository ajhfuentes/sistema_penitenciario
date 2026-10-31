<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Recluso;
use App\Models\CausaPenal;
use App\Models\BoletaExcarcelacion;
use Barryvdh\DomPDF\Facade\Pdf;

class ExportController extends Controller
{
    public function exportarExpedientePdf($reclusoId)
    {
        $recluso = Recluso::with(['causas', 'celda.pabellon'])->findOrFail($reclusoId);
        
        $pdf = Pdf::loadView('pdf.expediente', compact('recluso'));
        
        // Descarga el PDF con el nombre basado en la cédula
        return $pdf->download("expediente_{$recluso->cedula_identidad}.pdf");
    }

    public function exportarCausaPdf($causaId)
    {
        $causa = CausaPenal::with('reclusos')->findOrFail($causaId);
        
        $pdf = Pdf::loadView('pdf.causa', compact('causa'));
        
        return $pdf->download("causa_{$causa->numero_unico}.pdf");
    }

    public function exportarBoletaXml($boletaId)
    {
        $boleta = BoletaExcarcelacion::with('recluso')->findOrFail($boletaId);
        
        // Generamos el XML usando una vista de Blade
        $xml = view('xml.boleta', compact('boleta'))->render();
        
        return response($xml, 200)
            ->header('Content-Type', 'application/xml')
            ->header('Content-Disposition', "attachment; filename=boleta_{$boleta->numero_boleta}.xml");
    }
}
