<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="retail.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.retail" %>
<%@ Register Src="customControls/CustomStatus.ascx" TagName="CustomStatus" TagPrefix="ws" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Prodajno mesto: <asp:Literal ID="lblRetailName" runat="server"></asp:Literal></h1>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-default" CausesValidation="false" />
                 </div>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <ws:CustomStatus ID="customStatus" runat="server"></ws:CustomStatus>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-6">
                <asp:HiddenField ID="lblRetailID" runat="server" />
                <div class="form-group">
                    <label for="txtName">Naziv:</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="requiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Naziv je obavezan podatak" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label for="txtAddress">Adresa:</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="cmbCity">Mesto:</label>
                    <asp:DropDownList ID="cmbCity" runat="server" CssClass="form-control"></asp:DropDownList>
                    <asp:RangeValidator ID="rangeValidator1" runat="server" ControlToValidate="cmbCity" MinimumValue="0" MaximumValue="99999" ErrorMessage="Odaberite mesto"></asp:RangeValidator>
                </div>
                <div class="form-group">
                    <label for="txtPhone">Telefon:</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtMobilePhone">Mobilni:</label>
                    <asp:TextBox ID="txtMobilePhone" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtLocation">Lokacija:</label>
                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="chkIsActive">Aktivno:</label>
                    <asp:CheckBox ID="chkIsActive" runat="server" CssClass="checkbox" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
