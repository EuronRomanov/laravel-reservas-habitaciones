DROP PROCEDURE IF EXISTS sp_create_payment;
CREATE PROCEDURE sp_create_payment(
    IN p_reservation_id BIGINT,
    IN p_method ENUM('card','cash','transfer','wallet'),
    IN p_amount DECIMAL(10,2),
    IN p_status ENUM('pending','authorized','captured','failed','refunded'),
    IN p_transaction_ref VARCHAR(255),
    IN p_details JSON
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo crear el pago' AS message;
    END;

    START TRANSACTION;
        INSERT INTO payments (reservation_id, method, amount, status, transaction_ref, details, created_at, updated_at)
        VALUES (p_reservation_id, p_method, p_amount, p_status, p_transaction_ref, p_details, NOW(), NOW());
    COMMIT;
    SELECT 'OK' AS status, 'Pago creado correctamente' AS message;
END;