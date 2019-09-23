To Find Just The Parents of an Oracle Database Object:

Parent objects must be created first, before creating the child object. If the parent object is dropped, all subsequent child objects will become invalid.

This info is very important in new environments, such as moving from Dev to Test. Or Test to Prod.


——

/*

By Rodger Lepinsky
Script to find all the parents that the object is dependent on,
what must be created and valid first, before the object can be created and valid.

Only searches one layer of dependency
Successive generations of parents are not displayed.

*/

accept ls_REF_name prompt “Enter an object to find references to: ” ;

Select
TYPE || ‘ ‘ ||
OWNER || ‘.’ || NAME || ‘ references ‘ ||
REFERENCED_TYPE || ‘ ‘ ||
REFERENCED_OWNER || ‘.’ || REFERENCED_NAME
as DEPENDENCIES
From all_dependencies
Where name = UPPER(LTRIM(RTRIM( ‘&ls_REF_name’ )))
AND (REFERENCED_OWNER <> ‘SYS’
AND REFERENCED_OWNER <> ‘SYSTEM’
AND REFERENCED_OWNER <> ‘PUBLIC’
)
AND (OWNER <> ‘SYS’
AND OWNER <> ‘SYSTEM’
AND OWNER <> ‘PUBLIC’
)
order by OWNER, name,
REFERENCED_TYPE ,
REFERENCED_OWNER ,
REFERENCED_name
/