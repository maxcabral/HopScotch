
jQuery(document).ready(function() {

	jQuery("input[name='submit']").click(function(e) {
		var table_name = [];
		var field_names = [];
		var field_types = [];
		var field_nullables = [];

			jQuery("input[name=table_name]").each(function(j) {

				jQuery(this).parent(".form-row").parent().find("#table-with-name input[name=field-name]").each(function(i) {
					//field_names[i+1] = {field_name : $(this).val()};
					alert($(this).val());
				});

				jQuery(this).parent(".form-row").parent().find("#table-with-name select option:selected").each(function(k) {
					//field_types[k+1] = {field_type : $(this).val()};
					alert($(this).val());
				});

				jQuery(this).parent(".form-row").parent().find("#table-with-name input[name=field-nullable]").each(function(l) {
					//field_nullables[l+1] = {field_nullable : $(this).val()};
					alert($(this).val());
				});

				table_name[j] = {table :  $(this).val(), fields: {field_name : field_names, field_type: field_types, field_nullable : field_nullables}};

			});

			console.log(table_name);

			var myJsonString = JSON.stringify(table_name);

			//alert(myJsonString)

		e.preventDefault();
	});

	var to_append_field = '<div class="pt5 form-row">';
	to_append_field += '<label for="field_name">Field Name:</label>';
	to_append_field += '<input name="field-name" type="text">';
	to_append_field += '<label for="field_type">Data Type:</label>';
	to_append_field += '<select name="field-type">';
	to_append_field += '<option value="">Select</option>';
	to_append_field += '<option value="int">Int</option>';
	to_append_field += '<option value="real">Real</option>';
	to_append_field += '<option value="text">Text</option>';
	to_append_field += '<option value="blob">Blob</option>';
	to_append_field += '<option value="datetime">Datetime</option>';
	to_append_field += '<option value="boolean">Boolean</option>';
	to_append_field += '</select>';
	to_append_field += '<label for="field_nullable" class="reset-style">Not Null</label>';
	to_append_field += '<input name="field-nullable" class="pl5" type="checkbox" value="1">';
	to_append_field += '</div>';

	jQuery(".add_field").click(function(e) {
		jQuery(this).parent(".form-inline .form-row").last().before(to_append_field);

		e.preventDefault();
	});

	jQuery("input[name='add_table']").click(function(e) {

		var to_append = '<hr/>';
		to_append += '<div id="table-with-name">';
		to_append += '<div class="form-row">';
		to_append += '<label for="database_table">Table Name:</label>';
		to_append += '<input name="table_name" type="text">';
		to_append += '</div>';
		to_append += '<div class="pt5 form-row">';
		to_append += '<label>Field Name:</label>';
		to_append += '<input type="text" value="id" disabled name="field-name">';
		to_append += '<label>Data Type:</label>';
		to_append += '<select disabled name="field-type"><option>Int</option></select>';
		to_append += '<label class="reset-style">Not Null</label>';
		to_append += '<input class="pl5" type="checkbox" checked disabled name="field-nullable">';
		to_append += '<label class="reset-style">Primary Key</label>';
		to_append += '<input class="pl5" type="checkbox" checked disabled>';
		to_append += '</div>';
		to_append += '<div class="form-row">';
		to_append += '<label></label>';
		to_append += '<input type="submit" name="add_field" value="Add Field" class="btn new_add_field">';
		to_append += '</div>';
		to_append += '</div>';

		jQuery(".form-inline").append(to_append);

		jQuery(".new_add_field").on("click",function(ev) {
			jQuery(this).parent(".form-row").before(to_append_field);

			ev.preventDefault();
		});

		e.preventDefault();
	});	
});
