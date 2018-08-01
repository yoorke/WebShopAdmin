<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="brand.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.brand" %>
<%@ Register Src="customControls/CustomStatus.ascx" TagName="CustomStatus" TagPrefix="ws" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-md-12">
                <h1 class="page-header">Proizvođač</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="btn-group">
                    <asp:Button ID="btnSaveBrand" runat="server" Text="Sačuvaj" OnClick="btnSaveBrand_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-default" CausesValidation="false" />
                </div>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-md-12">
                <ws:CustomStatus ID="customStatus" runat="server"></ws:CustomStatus>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-md-5">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <asp:HiddenField ID="lblBrandID" runat="server" />
                        <label for='<%# txtName.ClientID %>' class="control-label col-md-2">Naziv: </label>
                        <div class="col-md-5">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="requiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Naziv je obavezan podatak" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group background-gray padding-05">
                        <label for='<%#fluImageUpload.ClientID %>' runat="server" class="col-md-12">Logo: </label>
                        <div class="col-md-12 margin-top-05">
                            <div class="brand-image">
                                <asp:Image ID="imgImage" runat="server" />
                            </div>
                        </div>
                        <div class="col-md-12 margin-top-05">
                            <asp:FileUpload ID="fluImageUpload" runat="server" />
                        </div>
                        <div class="col-md-12 margin-top-05">
                            <asp:Button ID="btnImageUpload" runat="server" OnClick="btnImageUpload_Click" Text="Sačuvaj sliku" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
