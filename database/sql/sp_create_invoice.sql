DROP PROCEDURE IF EXISTS sp_create_invoice;
CREATE PROCEDURE sp_create_invoice(
    IN p_reservation_id BIGINT,
    IN p_number VARCHAR(255),
    IN p_issue_date DATE,
    IN p_subtotal DECIMAL(10,2),
    IN p_tax DECIMAL(10,2),
    IN p_total DECIMAL(10,2),
    IN p_pdf_path VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo crear la factura' AS message;
    END;

    START TRANSACTION;
        INSERT INTO invoices (reservation_id, number, issue_date, subtotal, tax, total, pdf_path, created_at, updated_at)
        VALUES (p_reservation_id, p_number, p_issue_date, p_subtotal, p_tax, p_total, p_pdf_path, NOW(), NOW());
    COMMIT;
    SELECT 'OK' AS status, 'Factura creada correctamente' AS message;
END;
