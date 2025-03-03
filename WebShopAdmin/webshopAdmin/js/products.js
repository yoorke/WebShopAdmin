function GetProductsFromKimtec(){
    $('#ctl00_ContentPlaceHolder1_divPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "/webshopAdmin/WebMethods.aspx/GetProductsFromKimtec",
        data:"",
        contentType:"application/json;charset=utf-8",
        dataType:"json",
        success: function(msg){
            //alert(JSON.parse(msg.d));
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
            $('#messageBox').show();
            $('#messageBoxText')[0].innerHTML = JSON.parse(msg.d);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
        }
    });
}

function GetProductsSpecificationFromKimtec(){
    $('#ctl00_ContentPlaceHolder1_divPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "/webshopAdmin/WebMethods.aspx/GetProductsSpecificationFromKimtec",
        data: "",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(msg){
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
            $('#messageBox').show();
            $('#messageBoxText')[0].innerHTML = JSON.parse(msg.d);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
        }
    });
}

function GetCategoriesFromKimtec(){
    $('#ctl00_ContentPlaceHolder1_divPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "/webshopAdmin/WebMethods.aspx/GetCategoriesFromKimtec",
        data: "",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(msg){
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
            $('#messageBox').show();
            $('#messageBoxText')[0].innerHTML = JSON.parse(msg.d);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
        }
    });
}

function btnMessageBoxClose_Click(){
    $('#messageBox').hide();
}

function SaveProduct(code, isApproved, isActive, categoryID, type) {
    var url = '';
    switch (type) {
        case 'ewe': url = '/webshopAdmin/WebMethods.aspx/SaveProduct'; break;
        case 'threeg': url = '/webshopAdmin/WebMethods.aspx/SaveProductThreeg'; break;
    }
    $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify({ 'code': code, 'isApproved': isApproved, 'isActive': isActive, 'categoryID': parseInt(categoryID) }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            //alert(msg);
            //return 1;
            SetSaveStatus(++saveProductsCurrent, saveProductsCount);
            if (msg.d.indexOf('Not saved') > -1){
                $('#errorStatus')[0].innerText += msg.d + '\n';
                $('#errorStatus').show();
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //alert(jqXHR.responseText);
            $('#errorStatus')[0].innerText += JSON.parse(jqXHR.responseText).Message + "\n";
            $('#errorStatus').show();
        }
    })
}

function SaveProductKimtec(code, isApproved, isActive, categoryID) {
    var kimtecCategoryID = $('#ctl00_ContentPlaceHolder1_cmbKimtecCategory').val();
    $.ajax({
        type: 'POST',
        url: '/webshopAdmin/WebMethods.aspx/SaveProductKimtec',
        data: JSON.stringify({ 'code': code, 'isApproved': isApproved, 'isActive': isActive, 'categoryID': parseInt(categoryID), 'kimtecCategoryID': kimtecCategoryID }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            SetSaveStatus(++saveProductsCurrent, saveProductsCount);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#errorStatus')[0].innerText += JSON.parse(jqXHR.responseText).Message + '\n';
            $('#errorStatus').show();
        }
    })
}

//function SaveProductThreeg(code, isApproved, isActive, categoryID) {
    //alert(code + ' ' + isApproved + ' ' + isActive + ' ' + categoryID);
    //SaveProduct(code, isApproved, isActive, categoryID, 'threeg');
//}

var saveProductsCount = 0;
var saveProductsCurrent = 0;

function btnSaveProducts_Click(type) {
    var i = 0;
    var isApproved = $('#ctl00_ContentPlaceHolder1_chkApproved')[0].checked;
    var isActive = $('#ctl00_ContentPlaceHolder1_chkActive')[0].checked;
    var categoryID = $('#ctl00_ContentPlaceHolder1_cmbCategory').val();
    //var count = 0;
    //var current = 0;
    saveProductsCount = 0;
    $('#ctl00_ContentPlaceHolder1_dgvProducts > tbody > tr').each(function () {
        if(i++ > 0)
        if (this.cells[0].children[0].children[0].checked)
            saveProductsCount++;
    })
    i = 0;
    //$('#saveStatus').innerText = current + '/' + count;
    $('#saveStatus').show();
    $('#errorStatus').hide();
    
    saveProductsCurrent = 0;
    SetSaveStatus(0, saveProductsCount);
    $('#ctl00_ContentPlaceHolder1_dgvProducts > tbody > tr').each(function () {
        if (i++ > 0)
            if (this.cells[0].children[0].children[0].checked) {
                var code = this.cells[1].innerText;
                switch (type) {
                    //type == 'ewe' ? SaveProduct(code, isApproved, isActive, categoryID) : SaveProductKimtec(code, isApproved, isActive, categoryID);
                    case 'ewe': SaveProduct(code, isApproved, isActive, categoryID, 'ewe'); break;
                    case 'kimtec': SaveProductKimtec(code, isApproved, isActive, categoryID); break;
                    case 'threeg': SaveProduct(code, isApproved, isActive, categoryID, 'threeg'); break;
                }
                //$('#saveStatus')[0].innerText = ++current + '/' + count;
            }
    })
    //$('#saveStatus')[0].innerText = "Sačuvano" + saveProductsCount + " proizvoda";
}

function SetSaveStatus(current, count) {
    if (current < count)
        $('#saveStatus')[0].innerText = current + '/' + count;
    else
        $('#saveStatus')[0].innerText = "Sačuvano " + count + " proizvoda";
}

function btnChangeCategory_Click() {
    var newCategoryID = parseInt($('[id*=cmbNewCategory]').val());
    var i = 0;
    var productsCount = 0;
    var productsProcessed = 0;
    if (newCategoryID > 1) {
        $('[id*=dgvProducts] > tbody > tr').each(function () {
            if (i++ > 0)
                if (this.cells[0].children[0].children[0].checked)
                
                    productsCount++;
        })
        i = 0;
        setChangeCategoryStatus(productsProcessed, productsCount, 'success');
        $('[id*=dgvProducts] > tbody > tr').each(function () {
            if (i++ > 0) {
                if (this.cells[0].children[0].children[0].checked) {
                    var productID = parseInt(this.cells[1].children[0].innerText);

                    $.ajax({
                        type: 'POST',
                        url: '/webshopAdmin/WebMethods.aspx/ChangeCategory',
                        data: JSON.stringify({ "productID": productID, "newCategoryID": newCategoryID }),
                        contentType: 'application/json;charset=utf-8',
                        dataType: 'json',
                        success: function (msg) {
                            ++productsProcessed;
                            setChangeCategoryStatus(productsProcessed, productsCount, 'success');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            productsProcessed++;
                            //setChangeCategoryStatus(productsProcessed, productsCount, 'danger');
                            setChangeCategoryErrorStatus(textStatus + ', ' + productID)
                        }
                    })
                }
            }
        })
    }
}

function setChangeCategoryStatus(processed, total, status) {
    //$('#statusBox').addClass("alert alert-" + status);
    $('#statusBox').show();
    $('#statusBox')[0].innerText = 'Sačuvano ' + processed + '/' + total;
}

function setChangeCategoryErrorStatus(status) {
    $('#errorStatusBox').show();
    $('#errorStatusBox')[0].innerHTML += '<div>' + status + '</div>';
}

function SaveImportProduct(supplierCode) {
    let i = 0;
    let saveProductsCount = 0;
    let isApproved = $('[id*=chkApproved]')[0].checked;
    let isActive = $('[id*=chkActive]')[0].checked;
    let categoryID = $('[id*=cmbCategory]').val();
    let savedProducts = 0;

    $('[id*=dgvProducts] > tbody > tr').each(function () {
        if (i++ > 0) {
            if (this.cells[0].children[0].children[0].checked) {
                saveProductsCount++;
            }
        }
    });
    i = 0;

    SetSaveStatus(0, saveProductsCount);
    $('#saveStatus').show();
    $('#errorStatus').hide();

    $('[id*=dgvProducts] > tbody > tr').each(function () {
        if (i++ > 0) {
            if (this.cells[0].children[0].children[0].checked) {
                let code = this.cells[1].innerText;

                $.ajax({
                    type: 'POST',
                    url: '/webshopAdmin/WebMethods.aspx/SaveImportProduct',
                    data: JSON.stringify({
                        'supplierCode': supplierCode,
                        'productCode': code,
                        'isApproved': isApproved,
                        'isActive': isActive,
                        'categoryID': parseInt(categoryID)
                    }),
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'json',
                    success: function (msg) {
                        SetSaveStatus(++savedProducts, saveProductsCount);
                        if (msg.d.indexOf('Not saved') > -1) {
                            $('#errorStatus')[0].innerText += msg.d + '\n';
                            $('#errorStatus').show();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#errorStatus')[0].innerText += JSON.parse(jqXHR.responseText).Message + '\n';
                        //$('#errorStatus')[0].innerText += errorThrown;
                        $('#errorStatus').show();
                    }
                });
            }
        }
    });
}

function setProductActiveState(checkbox) {
    let productID = $(checkbox).closest('tr').find('td')[1].children[0].innerText;
    let isChecked = checkbox.checked;

    $.ajax({
        type: 'POST',
        url: '/webshopAdmin/WebMethods.aspx/SetActive',
        data: JSON.stringify({
            'productID': productID,
            'isActive': isChecked
        }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            $('#statusBox')[0].innerText = 'Artikal uspešno ' + (isChecked ? 'aktiviran' : 'deaktiviran') + '.';
            $('#statusBox').show();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#errorStatus')[0].innerText += errorThrown;
            $('#errorSTatus').show();
        }
    });
}

function setProductApprovedState(checkbox) {
    let productID = $(checkbox).closest('tr').find('td')[1].children[0].innerText;
    let isChecked = checkbox.checked;

    $.ajax({
        type: 'POST',
        url: '/webshopAdmin/WebMethods.aspx/SetApproved',
        data: JSON.stringify({
            'productID': productID,
            'isApproved': isChecked
        }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            $('#statusBox')[0].innerText = 'Artikal uspešno ' + (isChecked ? 'odobren' : 'isključen') + '.';
            $('#statusBox').show();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#errorStatus')[0].innerText += errorThrown;
            $('#errorStatus').show();
        }
    });
}

function setProductIsInStock(checkbox) {
    let productID = $(checkbox).closest('tr').find('td')[1].children[0].innerText;
    let isChecked = checkbox.checked;

    $.ajax({
        type: 'POST',
        url: '/webshopAdmin/WebMethods.aspx/SetIsInStock',
        data: JSON.stringify({
            'productID': productID,
            'isInStock': isChecked
        }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            $('#statusBox')[0].innerText = 'Artikal uspešno postavljen kao ' + (isChecked ? 'dostupan' : 'nedostupan') + '.';
            $('#statusBox').show();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#errorStatus')[0].innerText += errorThrown;
            $('#errorStatus').show();
        }
    });
}

function setProductIsLocked(checkbox) {
    let productID = $(checkbox).closest('tr').find('td')[1].children[0].innerText;
    let isChecked = checkbox.checked;

    $.ajax({
        type: 'POST',
        url: '/webshopAdmin/WebMethods.aspx/SetIsLocked',
        data: JSON.stringify({
            'productID': productID,
            'isLocked': isChecked
        }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            $('#statusBox')[0].innerText = 'Artikal uspešno ' + (isChecked ? 'zaključan' : 'otključan') + '.';
            $('#statusBox').show();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#errorStatus')[0].innerText += errorThrown;
            $('#errorStatus').show();
        }
    });
}

function setProductIsPriceLocked(checkbox) {
    let productID = $(checkbox).closest('tr').find('td')[1].children[0].innerText;
    let isChecked = checkbox.checked;

    $.ajax({
        type: 'POST',
        url: '/webshopAdmin/WebMethods.aspx/SetIsPriceLocked',
        data: JSON.stringify({
            'productID': productID,
            'isPriceLocked': isChecked
        }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            $('#statusBox')[0].innerText = 'Cena artikla uspešno ' + (isChecked ? 'zaključana' : 'otključana') + '.';
            $('#statusBox').show();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#errorStatus')[0].innerText += errorThrown;
            $('#errorStatus').show();
        }
    });
}

function setProductSortIndex(textbox) {
    let productID = $(textbox).closest('tr').find('td')[1].children[0].innerText;
    let sortIndex = textbox.value;

    $.ajax({
        type: 'POST',
        url: '/webshopAdmin/WebMethods.aspx/SetSortIndex',
        data: JSON.stringify({
            'productID': productID,
            'sortIndex': sortIndex
        }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            $('#statusBox')[0].innerText = 'Index sortiranja sačuvan';
            $('#statusBox').show();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#errorStatus')[0].innerText += errorThrown;
            $('#errorStatus').show();
        }
    })
}

function deleteProduct(productID, button) {
    if (confirm('Da li ste sigurni da želite da obrišete artikal sa ID: ' + productID + '?')) {
        $.ajax({
            type: 'POST',
            url: '/webshopAdmin/WebMethods.aspx/DeleteProduct',
            data: JSON.stringify({
                'productID': productID
            }),
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            success: function (msg) {
                if (msg.d === true) {
                    $(button.closest('tr')).remove();

                    $('#statusBox')[0].innerText = 'Artikal sa ID: ' + productID + ' uspešno obrisan';
                    $('#statusBox').show();
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $('#errorStatus')[0].innerText += errorThrown;
                $('#errorStatus').show();
            }
        });
    }
}