<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="companySettings.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.companySettings" %>
<%@ Register Src="customControls/CustomStatus.ascx" TagName="CustomStatus" TagPrefix="Ws2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Podešavanja</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" OnClick="btnSave_Click" Text="Sačuvaj" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <Ws2:CustomStatus ID="csStatus" runat="server" Visible="false"></Ws2:CustomStatus>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-3">
                <div class="form-group">
                    <label for="txtCompanyName">Naziv kompanije:</label>
                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtPhone">Telefon:</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtWorkingHours">Radno vreme:</label>
                    <asp:TextBox ID="txtWorkingHours" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="form-group">
                    <label for="txtDeliveryCost">Cena dostave:</label>
                    <asp:TextBox ID="txtDeliveryCost" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtFreeDeliveryTotalValue">Min vrednost za besplatnu dostavu:</label>
                    <asp:TextBox ID="txtFreeDeliveryTotalValue" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtExchangeRate">Kurs:</label>
                    <asp:TextBox ID="txtExchangeRate" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
