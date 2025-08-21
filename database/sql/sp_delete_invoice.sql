DROP PROCEDURE IF EXISTS sp_delete_invoice;
CREATE PROCEDURE sp_delete_invoice(IN p_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo eliminar la factura' AS message;
    END;

    START TRANSACTION;
        DELETE FROM invoices WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Factura eliminada correctamente' AS message;
END;