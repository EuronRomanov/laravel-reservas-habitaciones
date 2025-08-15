
CREATE PROCEDURE sp_create_invoice(
    IN p_payment_id BIGINT,
    IN p_total DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo crear la factura' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        INSERT INTO invoices (payment_id, total, created_at, updated_at)
        VALUES (p_payment_id, p_total, NOW(), NOW());
    COMMIT;
    SELECT 'OK' AS status, 'Factura creada correctamente' AS message;
END;


CREATE PROCEDURE sp_delete_invoice(IN p_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo eliminar la factura' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        DELETE FROM invoices WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Factura eliminada correctamente' AS message;
END;
