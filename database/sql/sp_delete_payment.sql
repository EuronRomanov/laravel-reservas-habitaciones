DROP PROCEDURE IF EXISTS sp_delete_payment;
CREATE PROCEDURE sp_delete_payment(IN p_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo eliminar el pago' AS message;
    END;

    START TRANSACTION;
        DELETE FROM payments WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Pago eliminado correctamente' AS message;
END;
