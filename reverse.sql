CREATE FUNCTION dbo.MY_REVERSE(@input_string VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS 
BEGIN
    DECLARE @input_string VARCHAR(MAX) = 'hello world!';
    DECLARE @reversed_string VARCHAR(MAX) = '';
    DECLARE @index INT = LEN(@input_string);

    WHILE (@index > 0)
    BEGIN
        SET @reversed_string = @reversed_string + SUBSTRING(@input_string, @index, 1);
        SET @index = @index - 1;
    END

    RETURN @reversed_string;
END;