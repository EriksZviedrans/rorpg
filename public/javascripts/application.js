// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(document).ready(function() {
// db_browser
	jQuery("#db_browser").treeview({
		collapsed: true,
		animated: "fast",
		prerendered: false,
		persist: "location",
        	unique: true
		});

//hide/show elements
	jQuery("a#btnCreateSchema").click(function () {
		jQuery("#createschema").toggle("slow");
   		});
        jQuery("a#btnCreateTable").click(function () {
		jQuery("#createtable").toggle("slow");
   		});
//add rows
	jQuery("a#AddRow").click(function (){
		 jQuery('#table').append(jQuery('#table tbody' + ' tr:last').clone());
		 jQuery('a#AddRow').hide();
		jQuery('#update').removeAttr('disabled');
		});
//add arguments
	jQuery("a#btnAddArguments").click(function () {
         jQuery('#addarguments').append(jQuery('#addarguments' + ' tr:last').clone());
   		});
// del arguments
	jQuery("a#btnDelArguments").click(function () {
	 var n = jQuery("table#addarguments tbody tr").length;
	if ( n > 1)
          jQuery('table#addarguments tbody tr:last').remove();
   		});	
//table editor
         jQuery('#table').grid();
//table sorter
        jQuery("table").tablesorter({
                                headers: {
                                        0: {sorter: false}
                                         } 
                                   });	
});

function check_create_db(form){
var letter = /[a-zA-z]/; var allsym = /^[0-9a-zA-Z]+$/;
	if (form.database_name.value.length == 0)
		{
		alert ( "Enter the database name!" );
 		creatadb = false;
	 	return false;
		}
	else 
		{
		creatadb = true;
		}

	var num = form.database_name.value;
	if (letter.test(num[0]))
		{
		creatadb = true;
		}
	else 
		{
		alert ( "The first letter of the symbol should be!" )
		creatadb = false;
		return false;
		}
	if (allsym.test(num))
		{
		creatadb = true;
		}
	else 
		{
		alert ( "Only letters or digits!" )
		creatadb = false;
		return false;
		}
if (creatadb == true)
{
SubmitButt.type="submit";
}
}


function check_create_function(form){
var letter = /[a-zA-z]/; var allsym = /^[0-9]+$/;
	if (form.function_name.value.length == 0)
		{
		alert ( "Enter the function name!" );
 		creatafunction = false;
	 	return false;
		}
	else 
		{
		creatafunction  = true;
		}
	var num = form.function_name.value;
	if (letter.test(num[0]))
		{
		creatasequence = true;
		}
	else 
		{
		alert ( "The first letter of the symbol should be!" )
		creatasequence = false;
		return false;
		}
if (creatafunction == true)
{
SubmitButt.type="submit";
}
}

function check_create_sequence(form){
var letter = /[a-zA-z]/; var allsym = /^[0-9]+$/;
	if (form.sequence_name.value.length == 0)
		{
		alert ("Enter the sequence name!" );
 		creatasequence = false;
	 	return false;
		}
	else 
		{
		creatasequence = true;
		}
	var num = form.sequence_name.value;
	if (letter.test(num[0]))
		{
		creatasequence = true;
		}
	else 
		{
		alert ( "The first letter of the symbol should be!" )
		creatasequence = false;
		return false;
		}
	if (allsym.test(form.increment_by.value))
		{
		creatasequence = true;
		}
	else 
		{
		alert ( "Enter the number!" )
		creatasequence = false;
		return false;
		}
	if (allsym.test(form.min_value.value))
		{
		creatasequence = true;
		}
	else 
		{
		alert ( "Enter the minimum number!" )
		creatasequence = false;
		return false;
		}
	if (allsym.test(form.max_value.value))
		{
		creatasequence = true;
		}
	else 
		{
		alert ( "Enter the maximum number!" )
		creatasequence = false;
		return false;
		}
	if (allsym.test(form.start_value.value))
		{
		creatasequence = true;
		}
	else 
		{
		alert ( "Enter the number with which to start!" )
		creatasequence = false;
		return false;
		}
	if (allsym.test(form.cache_value.value))
		{
		creatasequence = true;
		}
	else 
		{
		alert ( "Enter the number!" )
		creatasequence = false;
		return false;
		}
if (creatasequence == true)
{
SubmitButt.type="submit";
}
}
function check_create_view(form){
var letter = /[a-zA-z]/; var allsym = /^[0-9a-zA-Z.]+$/;
	if (form.view_name.value.length == 0)
		{
		alert ( "Enter the view name!" );
 		creataview = false;
	 	return false;
		}
	else 
		{
		creataview = true;
		}

	var num = form.view_name.value;
	if (letter.test(num[0]))
		{
		creataview = true;
		}
	else 
		{
		alert ( "The first letter of the symbol should be!" )
		creataview = false;
		return false;
		}
	if (allsym.test(num))
		{
		creataview = true;
		}
	else 
		{
		alert ( "Only letters or digits!" )
		creataview = false;
		return false;
		}
if (creataview == true)
{
SubmitButt.type="submit";
}
}

function check_create_schema(form){
var letter = /[a-zA-z]/; var allsym = /^[0-9a-zA-Z]+$/;
	if (form.schema_name.value.length == 0)
		{
		alert ( "Enter the schema name!" );
 		creataschema = false;
	 	return false;
		}
	else 
		{
		creataschema = true;
		}

	var num = form.schema_name.value;
	if (letter.test(num[0]))
		{
		creataschema = true;
		}
	else 
		{
		alert ( "The first letter of the symbol should be!" )
		creataschema = false;
		return false;
		}
	if (allsym.test(num))
		{
		creataschema = true;
		}
	else 
		{
		alert ( "Only letters or digits!" )
		creataschema = false;
		return false;
		}
if (creataschema == true)
{
SubmitButt.type="submit";
}
}


function check_create_table(form){ 
	var a = 0, b = 0, c = 0; var nexts = new Boolean(false); var numrad = new Boolean(true);var letter = /[a-zA-z]/; var allsym = /^[0-9a-zA-Z]+$/;
	var allsym_name = /^[0-9a-zA-Z.]+$/;
	
	if (form.table_name.value.length == 0)
		{
		alert ( "Eneter the table name" );
 		nexts = false;
	 	return false;
		} 
	else 
		{
		nexts = true;
		}
	var num = form.table_name.value;
	if (letter.test(num[0]))
		{
		nexts = true;
		}
	else 
		{
		alert ( "The first letter of the symbol should be!" )
		nexts = false;
		return false;
		}
	if (allsym_name.test(num))
		{
		nexts = true;
		}
	else 
		{
		alert ( "Only letters or digits!" )
		nexts = false;
		return false;
		}
	
	if (form.number_of_column.value.length == 0)
		{
		alert ( "Number of columns!" );
 		nexts = false;
	 	return false;
		} 
	else 
		{
		nexts = true;
		}
	var num = form.number_of_column.value;
		for (var i=0; i < num.length; i++)
		{		
			if (num[i]>="0" && num[i]<="9")
			{
				numrad = true;
			}
			else
			{
				numrad = false;
			}
			if (num[i]>="a" && num[i]<="z")
			{
			b++;	
			}
			if(num[i]>="A" && num[i]<="Z")
			{
			b++;
			} 		
		}

	if (numrad == false || b>0)
 		{
		alert ( "Only letters or digits!" ); 
 		return false;	
		nexts = false;
		} 
 	else 
		{
		nexts = true;
		}

if (nexts == true)
{
SubmitButt.type="submit";
}
}

function check_create_table_final(form){ 
var letter = /[a-zA-z]/; var allsym = /^[0-9a-zA-Z]+$/;
	if (document.getElementById("column_name_").value.length == 0)
		{
		alert ( "Enter the column name!" );
 		creatastable = false;
	 	return false;
		}
	else 
		{
		creatastable = true;
		}
	var nums = document.getElementById("column_name_").value;
	if (letter.test(nums[0]))
		{
		creatastable = true;
		}
	else 
		{
		alert ( "The first letter of the symbol should be!" )
		creatastable = false;
		return false;
		}
	if (allsym.test(nums))
		{
		creatastable = true;
		}
	else 
		{
		alert ( "Only letters or digits" )
		creatastable = false;
		return false;
		}
if (creatastable == true)
{
SubmitButt.type="submit";
}
}


