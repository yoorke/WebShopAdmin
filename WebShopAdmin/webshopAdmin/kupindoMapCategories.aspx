<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="kupindoMapCategories.aspx.cs" Inherits="WebShopAdmin.kupindoMapCategories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Mapiranje Kupindo kategorija</h1>
            </div>
        </div>
        <div class="row">
            
        </div>
        <div class="row">
            <div class="col-lg-5">
                <asp:DropDownList ID="cmbCategory" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="col-lg-5">
                <asp:DropDownList ID="cmbKupindoCategory" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="col-lg-2">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" Text="Sačuvaj" />
                </div>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <asp:GridView ID="dgvCategories" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-striped">
                        <Columns>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblCategoryID" runat="server" Text='<%#Eval("categoryID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Kategorija">
                                <ItemTemplate>
                                    <asp:Label ID="lblCategoryName" runat="server" Text='<%#Eval("categoryName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblKupindoCategoryID" runat="server" Text='<%#Eval("kupindoCategoryID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblKupindoCategoryName" runat="server" Text='<%#Eval("kupindoCategoryName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
