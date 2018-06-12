<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="brands.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.brands" %>
<%@ Register Src="customControls/CustomStatus.ascx" TagName="CustomStatus" TagPrefix="ws" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-md-12">
                <h1 class="page-header">Proizvođači</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="btn-group">
                    <asp:Button ID="btnAddBrand" runat="server" Text="Dodaj proivođača" OnClick="btnAddBrand_Click" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <ws:CustomStatus id="customStatus" runat="server"></ws:CustomStatus>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-md-12">
                <div class="table-responsive">
                    <asp:GridView ID="dgvBrands" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-striped"
                        OnRowDeleting="dgvBrands_RowDeleting" DataKeyNames="brandID">
                        <Columns>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblBrandID" runat="server" Text='<%#Eval("brandID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ControlStyle-Width="50px" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Image ID="imgLogo" runat="server" ImageUrl='<%#"/images/brand/" + Eval("logoUrl") %>' Width="50px" Height="20px" Visible='<%#Eval("logoUrl") != null && Eval("logoUrl") != string.Empty %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Naziv">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnkNaziv" runat="server" NavigateUrl='<%#"/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/brand.aspx?id=" + Eval("brandID") %>'>
                                        <asp:Label ID="lblNaziv" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowDeleteButton="true" DeleteText="" DeleteImageUrl="images/delete_icon.png" ButtonType="Image" ItemStyle-Width="20px" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
