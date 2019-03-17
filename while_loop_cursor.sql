declare @sql varchar(max)
declare @delete varchar(max)
declare @data_table varchar(50)
declare data  cursor for 
    select id   -- name of the table you have to query
    from id_copy      -- where these table names are stored

open data
fetch next from data into @data_table

while (@@fetch_status = 0) 
begin
    -- result_table = name of the table you want the results to be stored
    -- control_table = name of the control table you mentioned
    set @sql = 'SET IDENTITY_INSERT table_name ON;
    insert into table_name (columns)
                select * FROM table_name (nolock) where id in ('+@data_table+');
                SET IDENTITY_INSERT settlements_archive Off '
	--print(@sql)
	SET @delete = 'DELETE FROM id_copy WHERE id = '+ @data_table
    print(@sql)
	print(@delete)

    fetch next from data into @data_table
end

close data 
deallocate data 