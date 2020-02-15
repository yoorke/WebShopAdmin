<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="productCopyData.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.productCopyData" %>
<%@ Register Src="customControls/CustomStatus.ascx" TagPrefix="ws" TagName="CustomStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Kopiranje podataka za proizvod</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-3">
                <div class="form-group">
                    <label for="txtOldID">ID sa kojeg se kopira:</label>
                    <asp:TextBox ID="txtOldID" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="form-group">
                    <label for="txtNewID">ID na koji se kopira:</label>
                    <asp:TextBox ID="txtNewID" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <asp:Button ID="btnCopyData" runat="server" OnClick="btnCopyData_Click" CssClass="btn btn-primary" Text="Kopiraj" />
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-md-12">
                <ws:CustomStatus ID="customStatus" runat="server" visible="false"></ws:CustomStatus>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
