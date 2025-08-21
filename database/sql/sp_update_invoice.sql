DROP PROCEDURE IF EXISTS sp_update_invoice;
CREATE PROCEDURE sp_update_invoice(
    IN p_id BIGINT,
    IN p_tax DECIMAL(10,2),
    IN p_total DECIMAL(10,2),
    IN p_pdf_path VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo actualizar la factura' AS message;
    END;

    START TRANSACTION;
        UPDATE invoices
        SET tax = p_tax,
            total = p_total,
            pdf_path = p_pdf_path,
            updated_at = NOW()
        WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Factura actualizada correctamente' AS message;
END;
