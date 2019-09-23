To Find Just The Children of An Oracle Database Object:

This script is very useful when you want to know the impact of dropping a view.

When an object is dropped, or becomes invalid, all the children of that object become invalid. ie. If a view becomes invalid, all the child procedures, functions, and packages that reference it also become invalid, however many layers deep.

This script only shows the most immediate child level.

———–

/*

By Rodger Lepinsky
Script to find all the child dependencies of an object.
If the object is dropped, or becomes invalid, all the children will become invalid.

Only searches one layer deep.
Successive generations of children are not displayed.

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