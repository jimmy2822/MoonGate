function toggle_checkall(field_name, state) {
    var checkboxes = document.getElementsByTagName('input');
    var count = checkboxes.length;
    for (var i = 0; i< count; i++) {
        if (checkboxes[i].type == "checkbox" && checkboxes[i].name == field_name + "_ids[]") {
            checkboxes[i].checked = state;
        };
    };
};