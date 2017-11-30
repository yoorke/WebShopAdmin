<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="retails.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.retails" %>
<%@ Register Src="~/webshopAdmin/customControls/CustomStatus.ascx" TagName="CustomStatus" TagPrefix="ws" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Prodajna mesta</h1>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <asp:Button ID="btnAddRetail" runat="server" Text="Dodaj prodajno mesto" OnClick="btnAddRetail_Click" CssClass="btn btn-primary" />
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <ws:CustomStatus ID="customStatus" runat="server"></ws:CustomStatus>
                <div class="table-responsive">
                    <asp:GridView ID="dgvRetails" runat="server" AutoGenerateColumns="false" OnRowDataBound="dgvRetails_RowDataBound"
                        OnRowDeleting="dgvRetails_RowDeleting" DataKeyNames="retailID"
                        cssClass="table table-hover table-bordered table-condensed table-striped" OnRowCommand="dgvRetails_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="ID" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblRetailID" runat="server" Text='<%#Eval("retailID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Naziv">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnkRetail" runat="server" NavigateUrl='<%#"~/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/retail.aspx?id=" + Eval("retailID") %>'>
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Adresa">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("address") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mesto">
                                <ItemTemplate>
                                    <asp:Label ID="lblCity" runat="server" Text='<%#Eval("city.Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowDeleteButton="true" DeleteText="" ControlStyle-Width="20px" DeleteImageUrl="images/delete_icon.png" ButtonType="Image" ItemStyle-Width="20px" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
