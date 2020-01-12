<%@ Page Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="customPage.aspx.cs" Inherits="webshopAdmin.customPage" Title="Untitled Page" ValidateRequest="false" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        //$(function(){
            //CKEDITOR.replace('<%=txtContent.ClientID %>',
            //{
                //filebrowserUploadUrl: '/administrator/uploadImage.ashx' });
            //});
    </script>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header"><asp:Literal ID="lblTitleHeading" runat="server" Text="Unos nove stranice"></asp:Literal></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div ID="divAlert" runat="server" visible="false">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <asp:Label ID="lblAlert" runat="server"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group margin-bottom-10">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" CssClass="btn btn-primary" OnClick="btnSave_Close" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" CssClass="btn btn-primary" OnClick="btnSaveClose_Click" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" CssClass="btn btn-primary" OnClick="btnClose_Click" />
                </div>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-6">
                <div class="form-horizontal">
                <div class="form-group">
                    <label for="cmbCustomPageCategory" class="control-label col-sm-2">Kategorija: </label>
                    <asp:DropDownList ID="cmbCustomPageCategory" runat="server" CssClass="form-control" Width="50%"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="txtTitle" class="control-label col-sm-2">Title: </label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtDescription" class="control-label col-sm-2">Opis: </label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Width="50%" TextMode="MultiLine" Height="50px"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtUrl" class="control-label col-sm-2">Url: </label>
                    <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtHead" class="control-label col-sm-2">Head: </label>
                    <asp:TextBox ID="txtHead" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtFooter" class="control-label col-sm-2">Footer: </label>
                    <asp:TextBox ID="txtFooter" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtHeading" class="control-label col-sm-2">Naslov: </label>
                    <asp:TextBox ID="txtHeading" runat="server" CssClass="form-control" Width="50%"></asp:TextBox>
                </div>
                
                </div>
                
            
            </div>
            <div class="col-lg-6">
                <div class="form-horizontal">
                <div class="form-group">
                    <label for="txtInsertDate" runat="server" class="control-label col-sm-3">Datum unosa: </label>    
                    <asp:TextBox ID="txtInsertDate" runat="server" CssClass="form-control" Width="50%" Enabled="false"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtUpdateDate" runat="server" class="control-label col-sm-3">Datum izmene: </label>
                    <asp:TextBox ID="txtUpdateDate" runat="server" CssClass="form-control" Width="50%" Enabled="false"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:CheckBox ID="chkIsActive" runat="server" CssClass="checkbox-inline" Text="Aktivan" />
                </div>
                
                </div>
                </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
            <div class="form-group">
                <asp:TextBox ID="txtContent" TextMode="MultiLine" runat="server"></asp:TextBox>
                    <%--<label for="txtContent" class="control-label col-sm-1">Sadržaj: </label>--%>
                    <%--<CKEditor:CKEditorControl ID="txtContent" runat="server" BasePath="/ckeditor" Width="100%" Height="300px"></CKEditor:CKEditorControl>--%>
             </div>
            </div>
        </div>
        <div class="row form-horizontal">
            <div class="col-md-6">
                <div class="form-group">
                    <div class="col-md-4 col-md-offset-2">
                        <input type="text" id="txtSearchName" class="form-control" placeholder="Naziv" />
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox ID="txtProductID" runat="server" CssClass="form-control" placeholder="Product ID" ></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-2">Artikal: </label>
                    <div class="col-md-8">
                        <asp:DropDownList ID="cmbProduct" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="col-md-1">
                <div class="row">
                    <div class="col-md-12">
                        <asp:Button ID="btnAddProduct" runat="server" Text=">>" OnClick="btnAddProduct_Click" CssClass="btn btn-default" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:Button ID="btnRemoveProduct" runat="server" Text="<<" OnClick="btnRemoveProduct_Click" CssClass="btn btn-default" />
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <asp:ListBox ID="lstProduct" runat="server" CssClass="form-control" SelectionMode="Multiple" Height="150px"></asp:ListBox>
            </div>
        </div>
        
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
    <script>
        $(function () {
            CKEDITOR.replace('<%=txtContent.ClientID%>', { filebrowserUploadUrl: '/webShopAdmin/uploadImage.ashx' });
            CKEDITOR.config.height = 500;
        })
    </script>
    <script>
        $(document).ready(function () {
            $('[id*=txtTitle]').change(function () {
                $('[id*=txtUrl]').val(createFriendlyUrl($('[id*=txtTitle]').val()));
            })

            $('[id*=txtProductID]').on('change', function () {
                if ($('[id*=txtProductID]').val().trim() != '')
                    $('[id*=cmbProduct]').val($('[id*=txtProductID]').val());
            })

            $('[id*=txtSearchName]').on('change', function () {
                var searchString = $('[id*=txtSearchName]').val().toLowerCase().trim();
                //if (searchString != '') {
                    var isSet = false;
                    $('[id*=cmbProduct] > option').each(function () {
                        this.style.display = this.text.toLowerCase().indexOf(searchString) > -1 ? '' : 'none';
                        if (this.style.display == '' && !isSet) {
                            $('[id*=cmbProduct]').val(this.value);
                            isSet = true;
                        }
                    })
                //}
            })
        })
    </script>
</asp:Content>
