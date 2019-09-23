To Find Both Parent And Child Dependencies Of An Object:

This is the script I will usually use first. It can produce a lot of output.

It can also give you some insights. ie. PACKAGE APPS.FND_GLOBAL is required by hundreds of other triggers and views.  Over 14K in total.  Wow!

———–

/*


Script to find all dependencies of an object.
Both parents and children.

Only searches one layer in each direction.
Successive generations of parents or children are not displayed.

*/

accept ls_REF_name prompt “Enter an object to find references to: ” ;

Select
TYPE || ‘ ‘ ||
OWNER || ‘.’ || NAME || ‘ references ‘ ||
REFERENCED_TYPE || ‘ ‘ ||
REFERENCED_OWNER || ‘.’ || REFERENCED_NAME
as DEPENDENCIES
From all_dependencies
Where referenced_name = UPPER(LTRIM(RTRIM( ‘&ls_REF_name’ )))
or name = UPPER(LTRIM(RTRIM( ‘&ls_REF_name’ )))
AND (REFERENCED_OWNER <> ‘SYS’
AND REFERENCED_OWNER <> ‘SYSTEM’
AND REFERENCED_OWNER <> ‘PUBLIC’
)
AND (OWNER <> ‘SYS’
AND OWNER <> ‘SYSTEM’
AND OWNER <> ‘PUBLIC’
)
order by 1
/

