<%@ Page Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="products.aspx.cs" Inherits="webshopAdmin.products" Title="Proizvodi | Admin panel" MaintainScrollPositionOnPostback="true" %>
<%@ Register src="customControls/CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Proizvodi</h1>
            </div>
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12 margin-top-05">
                <div class="btn-group">
                    <%--<asp:Button ID="btnAddProduct" runat="server" Text="Dodaj proizvod" OnClick="btnAddProduct_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnApproveAll" runat="server" Text="Odobri selektovane" OnClick="btnApproveAll_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnActivateAll" runat="server" Text="Aktiviraj selektovane" OnClick="btnActivateAll_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnDeleteAll" runat="server" Text="Obriši selektovane" OnClick="btnDeleteAll_Click" CssClass="btn btn-primary" />                    --%>
                    <asp:LinkButton ID="btnAddProduct" runat="server" OnClick="btnAddProduct_Click" CssClass="btn btn-primary" ToolTip="Dodaj proizvod"><span class="fa fa-plus"></span></asp:LinkButton>
                </div>
                <div class="btn-group">
                    <asp:LinkButton ID="btnApproveAll" runat="server" OnClick="btnApproveAll_Click" CssClass="btn btn-primary" ToolTip="Odobri selektovane"><span class="fa fa-check"></span></asp:LinkButton>
                    <asp:LinkButton ID="btnDeapproveAll" runat="server" OnClick="btnDeapproveAll_Click" CssClass="btn btn-primary" ToolTip="Ne prikazuj selektovane"><span class="fa fa-times"></span></asp:LinkButton>
                </div>
                <div class="btn-group">
                    <asp:LinkButton ID="btnActivateAll" runat="server" OnClick="btnActivateAll_Click" CssClass="btn btn-primary" ToolTip="Aktiviraj selektovane"><span class="fa fa-check-square"></span></asp:LinkButton>
                    <asp:LinkButton ID="btnDeactivateAll" runat="server" OnClick="btnDeactivateAll_Click" CssClass="btn btn-primary" ToolTip="Deaktiviraj selektovane"><span class="fa fa-times"></span></asp:LinkButton>
                </div>
                <div class="btn-group">
                    <asp:LinkButton ID="btnDeleteAll" runat="server" OnClick="btnDeleteAll_Click" CssClass="btn btn-primary" ToolTip="Obriši selektovane"><span class="fa fa-trash"></span></asp:LinkButton>
                </div><!--btn-group-->
                <div class="btn-group">
                    <asp:LinkButton ID="btnCopyData" runat="server" OnClick="btnCopyData_Click" CssClass="btn btn-primary" ToolTip="Kopiraj podatke"><span class="fa fa-copy"></span></asp:LinkButton>
                </div>
            </div>
        </div>
        <asp:Panel runat="server" DefaultButton="btnShowProducts">
        <div class="row margin-top-2">
            <div class="col-lg-4">
                <div role="form">
                    <div class="form-group">
                        <label for="cmbCategory">Kategorija:</label>
                        <asp:DropDownList ID="cmbCategory" runat="server" CssClass="form-control"></asp:DropDownList>        
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="cmbSupplier">Dobavljač:</label>
                        <asp:DropDownList ID="cmbSupplier" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="cmbApproved">Odobreno:</label>
                        <asp:DropDownList ID="cmbApproved" runat="server" CssClass="form-control"></asp:DropDownList>        
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="cmbPromotion">Promocija:</label>
                        <asp:DropDownList id="cmbPromotion" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="cmbHasImage">Slika:</label>
                        <asp:DropDownList ID="cmbHasImage" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                        
                    
                </div><!--form-->
            </div><!--col-->
            <div class="col-lg-4">
                <div role="form">
                    <div class="form-group">
                        <label for="cmbActive">Aktivno:</label>
                        <asp:DropDownList ID="cmbActive" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="cmbBrand">Proizvođač:</label>
                        <asp:DropDownList ID="cmbBrand" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div><!--form-group-->
                    <div class="form-group">
                        <label for="txtSearch">Pretraga:</label>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="cmbSort">Sortiraj po:</label>
                        <asp:DropDownList ID="cmbSort" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div><!--form-->
            </div><!--col-->
            <div class="col-lg-4 background-gray padding-05">
                <div class="row">
                    <div class="col-lg-12 padding-bottom-05">
                        <label for="cmbPromotions">Promocija:</label>
                        <asp:DropDownList ID="cmbPromotions" runat="server" CssClass="form-control"></asp:DropDownList>
                        <asp:Button ID="btnAddToPromotion" runat="server" OnClick="btnAddToPromotion_Click" Text="Dodaj na promociju" CssClass="btn btn-primary margin-top-05" />
                        <asp:Button ID="btnDeleteFromPromotion" runat="server" OnClick="btnDeleteFromPromotion_Click" Text="Obriši sa promocije" CssClass="btn btn-primary margin-top-05" />
                    </div>
                </div>                
                <div class="row margin-top-05" id="divAdditionalCategory" runat="server">
                    <div class="col-lg-12">
                        <label for="cmbAdditionallyCategory">Dodatna kategorija:</label>
                        <asp:DropDownList ID="cmbAdditionallyCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                        <asp:Button ID="btnSaveProductCategory" runat="server" OnClick="btnSaveProductCategory_Click" Text="Dodaj kategoriju" CssClass="btn btn-primary margin-top-05" />
                    </div>
                </div>
                <div class="row margin-top-05">
                    <div class="col-lg-12">
                        <label for="cmbNewCategory">Kategorija:</label>
                        <asp:DropDownList ID="cmbNewCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                        <button type="button" id="btnChangeCategory" class="btn btn-primary margin-top-05" onclick="btnChangeCategory_Click()">Prebaci u kategoriju</button>
                    </div>
                </div>
                <div class="row margin-top-05">
                    <div class="col-md-12">
                        <label for="cmbCustomPage">Stranica:</label>
                        <asp:DropDownList ID="cmbCustomPage" runat="server" CssClass="form-control"></asp:DropDownList>
                        <asp:Button ID="btnAddProductsToCustomPage" runat="server" CssClass="btn btn-primary margin-top-05" OnClick="btnAddProductsToCustomPage_Click" Text="Dodaj proizvode na stranicu" />
                    </div>
                </div>
            </div>
        </div><!--row-->
        <div class="row">
            <div class="col-lg-5 margin-top-05">
                <asp:Button ID="btnShowProducts" runat="server" OnClick="btnShowProducts_Click" Text="Prikaži" CssClass="btn btn-primary" />
            </div><!--col-->
                
            
        </div><!--row-->
            </asp:Panel>
        <div class="row margin-top-05">
            <div class="col-lg-12 pull-right">
                
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-05">
            <div class="col-lg-4">
                
            </div>
            <div class="col-lg-4">

            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <uc1:CustomStatus ID="csStatus" runat="server" Visible="false" />        
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div id="statusBox" class="alert alert-success text-center" style="display:none"></div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div id="errorStatusBox" class="alert alert-danger text-center" style="display:none"></div>
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-lg-6">
                <label for="lblProductsCount">Ukupno proizvoda:</label>
                <asp:Label ID="lblProductsCount" runat="server"></asp:Label>
            </div><!--col-->
            <div class="col-lg-6">
                <div class="row">
                    <div class="col-lg-9">
                        <label for="cmbPageSize" class="pull-right">Proizvoda po stranici:</label>
                    </div><!--col-->
                    <div class="col-lg-3">
                        <asp:DropDownList ID="cmbPageSize" runat="server" OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                    </div><!--col-->
                </div><!--row-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12 margin-top-05">
                <div class="table-responsive">
                    <asp:GridView ID="dgvProducts" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-striped"
                        OnRowDeleting="dgvProducts_RowDeleting" DataKeyNames="productID" PagerSettings-Mode="Numeric" PageSize="10" AllowPaging="true" AllowSorting="true" OnPageIndexChanging="dgvProducts_PageIndexChanging" OnRowDataBound="dgvProducts_RowDataBound">
                        <Columns>

                            <asp:TemplateField ControlStyle-Width="30px" ItemStyle-Width="30px">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkSelectAll" runat="server" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="ID" ControlStyle-Width="50px" Visible="true" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("productID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ControlStyle-Width="50px" ItemStyle-Width="50px" Visible="false">
                                <ItemTemplate>
                                    <asp:Image ID="imgProduct" runat="server" ImageUrl='<%#Eval("ImageUrl") %>'></asp:Image>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Šifra">
                                <ItemTemplate>
                                    <asp:Label ID="lblCode" runat="server" Text='<%#Eval("code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Proizv" ControlStyle-Width="70px">
                                <ItemTemplate>
                                    <asp:Label ID="lblBrand" runat="server" Text='<%#Eval("brandName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Naziv">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/product.aspx?id="+Eval("productID") %>'>
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Opis" ControlStyle-Width="100px" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("description") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Cena" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("price")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Web" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblWebPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("webPrice")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Prom" ControlStyle-Width="50px" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Label ID="lblPromotionPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("promotionPrice")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Odob" ControlStyle-Width="20px" ItemStyle-Width="20px">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkApproved" runat="server" Checked='<%#Eval("isApproved") %>' AutoPostBack="true" OnCheckedChanged="chkApproved_CheckChanged" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Akt" ControlStyle-Width="20px" ItemStyle-Width="20px">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkActive" runat="server" Checked='<%#Eval("isActive") %>' AutoPostBack="true" OnCheckedChanged="chkActive_CheckChanged" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Zaklj" ControlStyle-Width="20px" ItemStyle-Width="20px">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkLocked" runat="server" Checked='<%#Eval("isLocked") %>' OnCheckedChanged="chkLocked_CheckedChanged" AutoPostBack="true" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Na stanju" ControlStyle-Width="20px" ItemStyle-Width="20px">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkInStock" runat="server" Checked='<%#Eval("isInStock") %>' OnCheckedChanged="chkInStock_CheckedChanged" AutoPostBack="true" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Zak. cena" ControlStyle-Width="20px" ItemStyle-Width="20px">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkPriceLocked" runat="server" Checked='<%#Eval("isPriceLocked") %>' OnCheckedChanged="chkPriceLocked_CheckedChanged" AutoPostBack="true" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Datum unosa" ControlStyle-Width="70px" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <asp:Label ID="lblInsertDate" runat="server" Text='<%#Eval("insertDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Datum izmene" ControlStyle-Width="70px" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <asp:Label ID="lblUpdateDate" runat="server" Text='<%#Eval("updateDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnkProductPage" runat="server" NavigateUrl='<%#"~/proizvodi/" + (bool.Parse(ConfigurationManager.AppSettings["includeParentUrlInCategoryUrl"]) ? Eval("FullCategoryUrl") : "proizvod") + "/" + Eval("name") + "-" + Eval("productID") %>' Target="_blank"><span class="fa fa-fw fa-sign-in"></span></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ShowDeleteButton="true" DeleteText="" ControlStyle-Width="20px" DeleteImageUrl="images/delete_icon.png" ButtonType="Image" ItemStyle-Width="20px" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    
    
    
    
    <%--<div id="topMenu">
        <div class="column">
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
        </div>
        
        <div class="column">
            <p class="row">
                
            </p>
            <p class="row">
                
            </p>
            <p class="row">
                
            </p>
        </div>
    </div>
    
    
    
    <div id="mainContent">
        
        
        
        
    
    </div>--%>

<script type="text/javascript">
    function SelectAll(id) {

        //get reference of GridView control
        var grid = document.getElementById("<%= dgvProducts.ClientID %>");

        //variable to contain the cell of the grid
        var cell;

        if (grid.rows.length > 0) {
            //loop starts from 1. rows[0] points to the header.

            for (i = 1; i < grid.rows.length; i++) {
                //get the reference of first column
                cell = grid.rows[i].cells[0];

                //loop according to the number of childNodes in the cell

                for (j = 0; j < cell.childNodes.length; j++) {
                    //if childNode type is CheckBox
                    for (k = 0; k < cell.childNodes[j].childNodes.length; k++) {

                        if (cell.childNodes[j].childNodes[k].type == "checkbox") {
                            //assign the status of the Select All checkbox to the cell checkbox within the grid
                            cell.childNodes[j].childNodes[k].checked = document.getElementById(id).checked;
                        }
                    }
                }
            }
        }
    }
    </script>

</asp:Content>
