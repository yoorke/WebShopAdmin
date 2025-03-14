﻿<%@ Page Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="webshopAdmin.product" Title="Proizvod | Admin panel" ValidateRequest="false" %>
<%@ Reference Control="customControls/AttributeControl.ascx" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Src="customControls/CustomStatus.ascx" TagPrefix="ws" TagName="customStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
    
    
        <!--PANEL POPUP-->
        <ajaxtoolkit:ToolkitScriptManager ID="ToolKitScriptManager1" runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>
        <div>
            <asp:Panel ID="pnlAddAttributeValue" runat="server" CssClass="popup" DefaultButton="btnAddAttributeValue">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for='<%=txtAttributeValue.ClientID %>'>Vrednost: </label>
                            <asp:TextBox ID="txtAttributeValue" runat="server" CssClass="form-control"></asp:TextBox>
                        </div><!--form-group-->
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <asp:Button ID="btnAddAttributeValue" runat="server" Text="Sačuvaj" OnClick="btnAddAttributeValue_Click" CssClass="btn btn-primary" CausesValidation="false" />
                        <asp:Button ID="btnCancelPopup" runat="server" Text="Odustani" CssClass="btn btn-primary" CausesValidation="false"  />
                    </div><!--col-->
                </div><!--row-->
            </asp:Panel>
        </div>
        
        <!--MODAL EXTENDER-->
        <ajaxtoolkit:ModalPopupExtender ID="modalExtender" runat="server" PopupControlID="pnlAddAttributeValue"
            TargetControlID="lnkShowPopup" DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCancelPopup"
            PopupDragHandleControlID="pnlAddAttributeValue"></ajaxtoolkit:ModalPopupExtender>
        <asp:LinkButton ID="lnkShowPopup" runat="server"></asp:LinkButton>
        <asp:HiddenField ID="lblAttributeID" runat="server" />
        <asp:HiddenField ID="lblAttributeName" runat="server" />
        <asp:HiddenField ID="lblType" runat="server" />
        <asp:HiddenField ID="lblProductID" runat="server" />
        
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header"><asp:Literal ID="lblPageHeader" runat="server" Text="Proizvod"></asp:Literal></h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" OnClientClick="disable(this)" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveAs" runat="server" Text="Kreiraj novi na osnovu" OnClick="btnSaveAs_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-primary" CausesValidation="false" />
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <%--<div class="row">
            <div class="col-lg-12">
                <asp:Label ID="lblStatus" runat="server" Visible="false"></asp:Label>
            </div><!--col-->
        </div><!--row-->--%>
        <div class="row margin-top-05">
            <div class="col-md-12">
                <ws:customStatus ID="customStatus" runat="server" visible="false"></ws:customStatus>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <asp:HiddenField ID="TabName" runat="server" />
                <ul class="nav nav-tabs" id="tabs" data-tabs="tabs">
                    <li class="active"><a href="#product" data-toggle="tab">Proizvod</a></li>
                    <li><a href="#images" data-toggle="tab">Slike</a></li>
                    <li><a href="#categories" data-toggle="tab">Kategorije</a></li>
                    <li><a href="#variants" data-toggle="tab">Varijante</a></li>
                    <li><a href="#promotions" data-toggle="tab">Promocije</a></li>
                    <li><a href="#specification" data-toggle="tab">Specifikacija</a></li>
                </ul><!--tabs-->
                <div id="tab-content" class="tab-content">
                    <div class="tab-pane active" id="product">
                        <div class="row">
                            <div class="col-lg-6">
                                <div role="form">
                                    <div class="form-group">
                                        <label for='<%=txtCode.ClientID %>'>Šifra:</label>
                                        <asp:TextBox ID="txtCode" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator1" runat="server" ControlToValidate="txtCode" ErrorMessage="Šifra je obavezan podatak" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for='<%=txtEan.ClientID %>'>Ean:</label>
                                        <asp:TextBox ID="txtEan" runat="server" CssClass="form-control"></asp:TextBox>                
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for='<%=cmbSupplier.ClientID %>'>Dobavljač:</label>
                                        <div class="input-group">
                                            <asp:DropDownList ID="cmbSupplier" runat="server" CssClass="form-control"></asp:DropDownList>
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-plus cursor-pointer" onclick="ShowModalPopupSupplier();return false;"></i></span>
                                            <%--<asp:ImageButton ID="btnAddSupplier" runat="server" ImageUrl="../images/add_icon.png" OnClientClick="ShowModalPopupSupplier();return false;" />--%>
                                        </div>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for='<%=txtSupplierCode.ClientID %>'>Šifra dobavljača:</label>
                                        <asp:TextBox ID="txtSupplierCode" runat="server" CssClass="form-control"></asp:TextBox>                
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for='<%=cmbBrand.ClientID %>'>Proizvođač:</label>
                                        <div class="input-group">
                                            <asp:DropDownList ID="cmbBrand" runat="server" CssClass="form-control"></asp:DropDownList>
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-plus cursor-pointer" onclick="ShowModalPopupManufacturer();return false;"></i></span>
                                        </div>
                                        <%--<asp:ImageButton ID="btnAddManufacturer" runat="server" ImageUrl="../images/add_icon.png" OnClientClick="ShowModalPopupManufacturer();return false;" />--%>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <label for='<%=txtName.ClientID %>'>Naziv:</label>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidator2" runat="server" ControlToValidate="txtName" ErrorMessage="Naziv je obavezan podatak" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div><!--form-group-->
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group">
                                                    <asp:CheckBox ID="chkApproved" runat="server" Text="Odobren" CssClass="checkbox" />
                                                    <asp:CheckBox ID="chkActive" runat="server" Text="Aktivan" CssClass="checkbox" />
                                                    <asp:CheckBox ID="chkLocked" runat="server" Text="Zaključan" CssClass="checkbox" />
                                                    <asp:CheckBox ID="chkInStock" runat="server" Text="Na stanju" CssClass="checkbox" />
                                                    <asp:CheckBox ID="chkPriceLocked" runat="server" Text="Zaključana cena" CssClass="checkbox" />
                                                    <asp:CheckBox ID="chkCanBeDelivered" runat="server" Text="Dostava" CssClass="checkbox" />
                                                    <asp:CheckBox ID="chkIsFreeDelivery" runat="server" Text="Besplatna dostava" CssClass="checkbox" />
                                                </div><!--form-group-->
                                            </div><!--col-->
                                        </div><!--row-->
                                    </div>
                                </div><!--form-->
                            </div><!--col-->
                            <div class="col-lg-6">
                                <div class="row">
                                    <div class="col-lg-12 text-right">
                                        <asp:Image ID="imgProduct" runat="server" ToolTip="Main" Height="50px" />
                                        <asp:Image ID="imgLarge" runat="server" ToolTip="Large" Height="50px" />
                                        <asp:Image ID="imgHome" runat="server" ToolTip="Home" Height="50px" />
                                        <asp:Image ID="imgThumb" runat="server" ToolTip="Thumb" Height="50px" />
                                    </div>
                                </div>
                                <div role="form">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for='<%=txtSupplierPrice.ClientID %>'>Nabavna cena:</label>
                                                <asp:TextBox ID="txtSupplierPrice" runat="server" CssClass="form-control text-right" Enabled="false"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for='<%=txtPrice.ClientID %>'>Cena:</label>
                                                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control text-right"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator3" runat="server" ControlToValidate="txtPrice" ErrorMessage="Cena je obavezan podatak" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div><!--form-group-->
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for='<%=txtWebPrice.ClientID %>'>Web cena:</label>
                                                <asp:TextBox ID="txtWebPrice" runat="server" CssClass="form-control text-right"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqiredFieldValidator4" runat="server" ControlToValidate="txtWebPrice" ErrorMessage="Web cena je obavezan podatak" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div><!--form-group-->
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for='<%=cmbUnitOfMeasure.ClientID %>'>Jedinica mere:</label>
                                        <asp:DropDownList ID="cmbUnitOfMeasure" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RangeValidator ID="rangeValidator2" runat="server" ControlToValidate="cmbUnitOfMeasure" MinimumValue="1" MaximumValue="999" ErrorMessage="Odaberite jedinicu mere" Display="Dynamic"></asp:RangeValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for='<%=cmbVat.ClientID %>'>PDV:</label>
                                        <div class="input-group">
                                            <asp:DropDownList ID="cmbVat" runat="server" CssClass="form-control text-right"></asp:DropDownList>
                                            <span class="input-group-addon"><i>%</i></span>
                                        </div>
                                    </div><!--form-group-->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for='<%=txtWeight.ClientID %>'>Težina</label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control text-right" Text="0"></asp:TextBox>
                                                    <span class="input-group-addon"><i>kg</i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="col-md-6">
                                            <div class="form-group">
                                                <label for="cmbWeightRange">Težina oseg</label>
                                                <asp:DropDownList ID="cmbWeightRange" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </div>
                                        </div>--%>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for='<%=txtSortIndex %>'>Indeks sortiranja</label>
                                                <asp:TextBox ID="txtSortIndex" runat="server" CssClass="form-control text-right" Text="0" TextMode="Number"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for='<%=txtInsertDate.ClientID %>'>Datum unosa:</label>
                                        <asp:TextBox ID="txtInsertDate" runat="server" Enabled="false" CssClass="form-control"></asp:TextBox>
                                    </div><!--form-group-->
                                    <div class="form-group">    
                                        <label for='<%=txtUpdateDate.ClientID %>'>Datum izmene:</label>
                                        <asp:TextBox ID="txtUpdateDate" runat="server" Enabled="false" CssClass="form-control"></asp:TextBox>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                        </div><!--row-->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for='<%=txtShortDescription.ClientID %>'>Kratak opis:</label>
                                    <asp:TextBox ID="txtShortDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for='<%=txtListDescription.ClientID %>'>Opis u listi:</label>
                                    <asp:TextBox ID="txtListDescription" runat="server" TextMode="MultiLine" Rows ="2" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for='<%=txtDescription.ClientID %>'>Opis:</label>
                                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                    <%--<CKEditor:CKEditorControl ID="txtDescription" runat="server" BasePath="/ckeditor" Height="300px" CssClass="form-control"></CKEditor:CKEditorControl>--%>
                                </div><!--form-group-->
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for='<%=txtDeclaration.ClientID %>'>Deklaracija:</label>
                                    <asp:TextBox ID="txtDeclaration" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for='<%=txtComment.ClientID %>'>Komentar:</label>
                                    <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="images">
                        <div class="row margin-top-2">
                            <div class="col-md-9">
                                <asp:Repeater ID="rptImages" runat="server" OnItemCommand="rptImages_ItemCommand" OnItemDataBound="rptImages_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="productImage">                                  
                                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%#Eval("imageUrl") %>' />
                                            <asp:Label ID="lblImageUrl" runat="server" Text='<%# Eval("imageUrl") %>' CssClass="imageUrl"></asp:Label>
                                            <asp:TextBox ID="txtSortOrder" runat="server" CssClass="sortOrder" Text='<%#Eval("sortOrder") %>'></asp:TextBox>
                                            <asp:LinkButton ID="btnDelete" CommandName="delete" runat="server" Text="Obriši" CssClass="deleteIcon"></asp:LinkButton>
                                        </div><!--productImage-->
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div><!--col-->
                            <div class="col-md-2">
                                <div class="row">
                                    <div class="col-lg-5">
                                        <div class="btn-group-vertical">
                                            <asp:LinkButton ID="btnConvertImage" runat="server" OnClick="btnConvertImage_Click" CssClass="btn btn-primary" CausesValidation="false" ToolTip="Konvertuj u WebP format">
                                                <span class="fa fa-clone"></span>
                                                <span>Konvertuj slike u webP format</span>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnResizeImage" runat="server" OnClick="btnResizeImage_Click" CssClass="btn btn-primary" CausesValidation="false" ToolTip="Podesi veličinu slika po tipovima">
                                                <span class="fa-solid fa-image"></span>
                                                <span>Podesi veličinu slika</span>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!--row-->
                        <div class="row margin-top-2">
                            <div class="col-lg-12">
                                Unos nove slike
                            </div>
                        </div>
                        <div class="row margin-top-05">
                            <div class="col-lg-5">
                                <asp:FileUpload ID="fluImage" runat="server" />
                           </div><!--col-->
                        </div><!--row-->
                        <div class="row margin-top-05">
                            <div class="col-lg-5">
                                <asp:Button ID="btnImageUpload" runat="server" Text="Dodaj" OnClick="btnImageUpload_Click" CssClass="btn btn-primary" CausesValidation="false" />
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="categories">
                        <div class="row">
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <label for='<%=cmbCategory.ClientID %>'>Kategorija:</label>
                                        <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                                    </div><!--form-group-->
                                </div><!--form-->
                            </div><!--col-->
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <div id="divProductInMultipleCategories" runat="server">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <label for='<%=cmbCategories.ClientID %>'>Kategorije:</label>
                                                </div>
                                            </div>
                                        
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:DropDownList ID="cmbCategories" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                                <div class="col-md-2">
                                                    <asp:Button ID="btnAddProductToCategory" runat="server" CssClass="btn btn-primary" OnClick="btnAddProductToCategory_Click" Text="Dodaj" CausesValidation="false" />
                                                </div>
                                            
                                            </div>
                                            <div class="row margin-top-05">
                                                <div class="col-md-10">
                                                    <label for='<%=lstCategories.ClientID %>'>Proizvod će se prikazivati u sledećim kategorijama:</label>
                                                    <asp:ListBox ID="lstCategories" runat="server" CssClass="form-control"></asp:ListBox>
                                                </div>
                                                <div class="col-md-2 margin-top-1-5">
                                                    <asp:Button ID="btnRemoveProductFromCategory" runat="server" CssClass="btn btn-primary" OnClick="btnRemoveProductFromCategory_Click" Text="Obriši" CausesValidation="false" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!--row-->
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Panel ID="pnlAttributes" runat="server">
                                    <div role="form">
                                        
                                    </div><!--form-->
                                </asp:Panel>            
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="variants">
                        <div class="row">
                            <div class="col-lg-12">
                                <div role="form">
                                    <div class="row">
                                        <div class="col-lg-2">
                                            <div class="form-group">
                                                <label for='<%=txtVariantCode.ClientID %>'>Šifra:</label>
                                                <asp:TextBox ID="txtVariantCode" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <div class="form-group">
                                                <label for='<%=txtVariantPrice.ClientID %>'>Cena:</label>
                                                <asp:TextBox ID="txtVariantPrice" runat="server" CssClass="form-control text-right" Enabled="false"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <div class="form-group">
                                                <asp:CheckBox ID="chkVariantIsInStock" runat="server" Text="Na stanju" CssClass="checkbox" Checked="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="row">
                                                <asp:Panel ID="pnlVariantAttributes" runat="server">

                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:Button ID="btnAddProductVariant" runat="server" CssClass="btn btn-primary" OnClick="btnAddProductVariant_Click" Text="Dodaj" Enabled="false" />
                                            <asp:Button ID="btnCreateAllProductVariants" runat="server" CssClass="btn btn-primary" OnClick="btnCreateAllProductVariants_Click" Text="Dodaj sve varijante" Enabled="true" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row"></div>
                            </div>
                        </div>
                        <div class="row margin-top-2">
                            <div class="col-lg-6">
                                <asp:GridView ID="dgvProductVariants" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-hover table-striped table-bordered"
                                    OnRowDeleting="dgvProductVariants_RowDeleting" DataKeyNames="ID">
                                    <Columns>
                                        <asp:TemplateField HeaderText="ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProductVariantID" runat="server" Text='<%#Eval("id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Šifra" ControlStyle-Width="100px" ItemStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCode" runat="server" Text='<%#Eval("code") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cena" ControlStyle-Width="100px" ItemStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPrice" runat="server" Text='<%#Eval("Price") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Na stanju" ControlStyle-Width="50px" ItemStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkIsInStock" runat="server" Checked='<%#Eval("isInStock") %>' OnCheckedChanged="chkIsInStock_CheckedChanged" AutoPostBack="true" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Atributi" ControlStyle-Width="200px" ItemStyle-Width="200px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAttributeValues" runat="server" Text='<%#Eval("attributesValues") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:CommandField ShowDeleteButton="true" DeleteText="" ControlStyle-Width="20px" DeleteImageUrl="images/delete_icon.png" ButtonType="Image" ItemStyle-Width="20px" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="promotions">
                        <div class="row">
                            <div class="col-lg-5">
                                <div role="form">
                                    <div class="form-group">
                                        <label for='<%=cmbPromotions.ClientID %>'>Promocija: </label>
                                        <asp:DropDownList ID="cmbPromotions" runat="server" OnSelectedIndexChanged="cmbPromotions_SelectedIndexChanged" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                    </div><!--form-control-->
                                    <div class="form-group">
                                        <label for='<%=txtPromotionPrice.ClientID %>'>Cena: </label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtPromotionPrice" runat="server" CssClass="form-control"></asp:TextBox>
                                            <span class="input-group-addon">din</span>
                                        </div>
                                        <asp:RangeValidator ID="rangeValidator1" runat="server" ControlToValidate="txtPromotionPrice" MinimumValue="1" MaximumValue="1000000" ErrorMessage="Morate uneti numeričku vrednost." Type="Integer"></asp:RangeValidator>
                                    </div><!--form-control-->
                                </div><!--form-->
                                <%--<asp:Button ID="btnClearPromotion" runat="server" Text="Obriši sa promocije" OnClick="btnClearPromotion_Click" />--%>
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                    <div class="tab-pane" id="specification">
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:TextBox ID="txtSpecification" runat="server" TextMode="MultiLine" Width="400px" Height="500px" CssClass="form-control"></asp:TextBox>
                            </div><!--col-->
                        </div><!--row-->
                    </div><!--tab-pane-->
                </div><!--tab-content-->
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    <%--<div id="topMenu">
        
    </div>
    
    <div id="mainContent">
        
        
        
        
        <div>
                        
                        
                        
                    </div>
        
        <ajaxtoolkit:TabContainer ID="TabContainer1" runat="server" Width="900px">
            <ajaxtoolkit:TabPanel ID="TabPanel1" HeaderText="Proizvod" runat="server">
                <ContentTemplate>
                
                    
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                    
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            
            <ajaxtoolkit:TabPanel ID="tbpImages" runat="server" HeaderText="Slike">
                <ContentTemplate>
                    
                    <div id="productImages">
                    
                    </div>

                    <p class="row">
                        
                    </p>
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            
            <ajaxtoolkit:TabPanel ID="tbpCategories" runat="server" HeaderText="Kategorije">
                <ContentTemplate>
                    <p class="row">
                        
                    </p>
                    
                    
                    
                    
                    
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            
            <ajaxtoolkit:TabPanel ID="tbpPromotions" runat="server" HeaderText="Promocije">
                <ContentTemplate>
                    <p class="row">
                        
                    </p>
                    
                    <p class="row">
                        
                    </p>
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            
            <ajaxtoolkit:TabPanel ID="tbpSpecification" runat="server" HeaderText="Specifikacija">
                <ContentTemplate>
                    
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
        </ajaxtoolkit:TabContainer>
    
    
        
        
        
    </div>--%>
   

</asp:Content>
<asp:Content ID="content3" runat="server" ContentPlaceHolderID="ContentPlaceHolderFooter">
<script type="text/javascript">
    var modalPopup = '<%= modalExtender.ClientID %>';
    function ShowModalPopup(id) {
        var lblAttributeID = document.getElementById('<%=lblAttributeID.ClientID %>');
        var hiddenID = id.toString().substring(0, id.toString().lastIndexOf('_')) + '_lblAttributeID';
        var hidden = document.getElementById(hiddenID);
        //alert(hidden);
        lblAttributeID.value = hidden.value;
        var attributeName = document.getElementById('<%=lblAttributeName.ClientID %>');
        //alert(attributeName);
        attributeName.value = id.toString().replace('ctl00_ContentPlaceHolder1_', '').substring(0, id.toString().replace('ctl00_ContentPlaceHolder1_', '').lastIndexOf('_'));
        //alert(lblAttributeID.value);
        var type = document.getElementById('<%=lblType.ClientID %>');
        type.value = 'attribute';
        var txtAttributeValue = document.getElementById('<%=txtAttributeValue.ClientID %>');

        $find(modalPopup).show();
        txtAttributeValue.focus();
        return false;
    }
    </script>
<script type="text/javascript">
    var modalPopup = '<%= modalExtender.ClientID  %>';
    function ShowModalPopupSupplier() {
        var type = document.getElementById('<%=lblType.ClientID  %>');
        type.value = 'supplier';
        $find(modalPopup).show();
        var txtAttributeValue = document.getElementById('<%=txtAttributeValue.ClientID %>');
        txtAttributeValue.focus();
        return false;
    }
</script>
<script type="text/javascript">
    var modalPopup = '<%= modalExtender.ClientID %>';
    function ShowModalPopupManufacturer() {
        var type = document.getElementById('<%=lblType.ClientID %>');
        type.value = 'brand';
        $find(modalPopup).show();
        txtAttributeValue = document.getElementById('<%=txtAttributeValue.ClientID %>');
        txtAttributeValue.focus();
        return false;
    }
</script>
<script type="text/javascript">
    $(function() {
        var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "product";
        $('#tabs a[href="#' + tabName + '"]').tab('show');
        $("#tabs a").click(function() {
            $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
        });
    });
</script>
<script>
    $(document).ready(function () {
        $('[id*=txtPrice]').change(function () {
            if($('[id*=txtWebPrice]').val() == '')
                $('[id*=txtWebPrice]').val($('[id*=txtPrice]').val());
        })

        CKEDITOR.replace('<%=txtDescription.ClientID%>', { filebrowserUploadUrl: '/webShopAdmin/uploadImage.ashx' });
        CKEDITOR.config.height = 300;
    })
</script>
    <script>
        function disable(control) {
            control.disable = true;
        }
    </script>
<script type="text/javascript">
    $(document).ready(function () {
        $("[id*=cmbSupplier]").select2();
        $("[id*=cmbBrand]").select2();
        $("[id*=cmbUnitOfMeasure]").select2();
        $("[id*=cmbVat]").select2();
        $("[id*=cmbCategory]").select2();
        $("[id*=cmbCategories]").select2();
        $("[id*=cmbPromotions]").select2();
    })
</script>
</asp:Content>