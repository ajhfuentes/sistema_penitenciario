SELECT XMLELEMENT(
    NAME "recluso",
    XMLATTRIBUTES(r.id AS "id_sistema"),
    XMLFOREST(
        r.cedula_identidad AS "cedula",
        r.nombres AS "nombres",
        r.apellidos AS "apellidos",
        r.nivel_riesgo AS "nivel_riesgo",
        r.estado_operativo AS "estado_operativo",
        r.sexo AS "sexo",
        r.fecha_nacimiento AS "fecha_nacimiento"
    )
) AS xml_recluso
FROM public.reclusos r
WHERE r.id = 7; -- Probamos con el recluso ID 7 (Martha García)
