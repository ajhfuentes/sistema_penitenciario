-- 1. Crear la función que ejecutará el trigger
CREATE OR REPLACE FUNCTION public.fn_verificar_capacidad_celda()
RETURNS TRIGGER AS $$
DECLARE
    v_capacidad_maxima INTEGER;
    v_total_actual INTEGER;
BEGIN
    -- Si el recluso no tiene celda asignada, se permite la operación
    IF NEW.celda_id IS NULL THEN
        RETURN NEW;
    END IF;

    -- Obtener la capacidad máxima permitida de la celda
    SELECT capacidad_maxima INTO v_capacidad_maxima
    FROM public.celdas
    WHERE id = NEW.celda_id;

    -- Contar cuántos reclusos ya están asignados a esa celda
    SELECT COUNT(*) INTO v_total_actual
    FROM public.reclusos
    WHERE celda_id = NEW.celda_id AND id <> COALESCE(NEW.id, 0);

    -- Evaluar la regla: si el total actual alcanza o supera la capacidad, abortar
    IF v_total_actual >= v_capacidad_maxima THEN
        RAISE EXCEPTION 'ERROR DE INTEGRIDAD: La celda seleccionada ha alcanzado su capacidad máxima permitida (%) y no admite más reclusos.', v_capacidad_maxima;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Asociar la función como un Trigger BEFORE INSERT OR UPDATE en la tabla reclusos
DROP TRIGGER IF EXISTS trg_control_capacidad_celda ON public.reclusos;

CREATE TRIGGER trg_control_capacidad_celda
BEFORE INSERT OR UPDATE OF celda_id
ON public.reclusos
FOR EACH ROW
EXECUTE FUNCTION public.fn_verificar_capacidad_celda();