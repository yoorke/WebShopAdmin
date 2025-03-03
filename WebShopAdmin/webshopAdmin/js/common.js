function ChangeDateFormat(date) {
    var formattedDate = date.toString().substring(3, 5) + '.' + date.toString().substring(0, 2) + '.' + date.toString().substring(6);
    return formattedDate.toString();
}

function createFriendlyUrl(name) {
    name = name.toLowerCase().trim();
    var notAllowed = ['š', 'ć', 'č', 'ž', ',', '"', ' ', '&'];
    var replacement = ['s', 'c', 'c', 'z', '-', '-', '-', '-'];

    for (var i = 0; i < notAllowed.length; i++) {
        name = name.replace(new RegExp(notAllowed[i], 'g'), replacement[i]);
    }

    name = name.replace(new RegExp('\\.', 'g'), '-');
    name = name.replace(new RegExp('\\+', 'g'), '-');
    name = name.replace(new RegExp('\\(', 'g'), '-');
    name = name.replace(new RegExp('\\)', 'g'), '-');
    name = name.replace(new RegExp('\\*', 'g'), '-');
    name = name.replace(new RegExp('\\%', 'g'), '-');
    name = name.replace(new RegExp('\\$', 'g'), '-');
    name = name.replace(new RegExp('đ', 'g'), 'dj');
    name = name.replace(new RegExp('----', 'g'), '-');
    name = name.replace(new RegExp('---', 'g'), '-');
    name = name.replace(new RegExp('--', 'g'), '-');

    return name;
}

function searchTable(tableName, searchControlName) {
    var searchControl = $('#' + searchControlName)[0];
    searchControl.onkeyup = function () {
        var searchValue = $(this).val().toLowerCase().trim();

        $('[id*=' + tableName + '] tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().trim().indexOf(searchValue) > -1);
        });
    };
}

function checkAllInTable(tableId, checkbox) {
    let table = $(tableId)[0];
    $("#" + table.id + " input[type='checkbox']").each(function () {
        if (this.id.indexOf('SelectAll') === -1) {
            this.checked = checkbox.checked;
        }
    });
}