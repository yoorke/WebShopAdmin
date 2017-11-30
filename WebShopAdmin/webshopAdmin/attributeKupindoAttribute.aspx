<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="attributeKupindoAttribute.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.attributeKupindoAttribute" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Mapiranje Kupindo atributa</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Sačuvaj" OnClick="btnSave_Click" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
            </div>
            <div class="col-lg-6">
                <asp:Label ID="lblKupindoCategory" runat="server" CssClass="form-control"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <asp:GridView ID="dgvAttributes" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-striped"
                        OnRowDataBound="dgvAttributes_RowDataBound">
                        <Columns>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblKupindoAttributeID" runat="server" Text='<%#Eval("kupindoAttributeID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Kupindo atribut">
                                <ItemTemplate>
                                    <asp:Label ID="lblKupindoAttributeName" runat="server" Text='<%#Eval("kupindoAttributeName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Atribut">
                                <ItemTemplate>
                                    <asp:DropDownList ID="cmbAttribute" runat="server" CssClass="form-control"></asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblAttributeID" runat="server" Text='<%#Eval("attributeID") %>'></asp:Label>
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
