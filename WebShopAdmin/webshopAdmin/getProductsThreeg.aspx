<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="getProductsThreeg.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.getProductsThreeg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="divPleaseWait" runat="server" class="pleaseWait" style="display:none">
        <span>Molim, sačekajte</span>
    </div>
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Preuzimanje proizvoda 3g</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5">
                <div class="form-group">
                    <label for="cmbCategory">Kategorija:</label>
                    <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
            <div class="col-md-6 col-md-offset-1">
                <div class="form-group">
                    <label for="cmbThreegCategory1">Kategorija 1:</label>
                    <asp:DropDownList ID="cmbThreegCategory1" runat="server" OnSelectedIndexChanged="cmbThreegCategory1_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="cmbThreegCategory1">Kategorija 2:</label>
                    <asp:DropDownList ID="cmbThreegCategory2" runat="server" OnSelectedIndexChanged="cmbThreegCategory2_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5">
                <asp:ListBox ID="lstCategory" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" CssClass="form-control"></asp:ListBox>
            </div>
            <div class="col-md-1">
                <asp:Button ID="btnAddCategory" runat="server" Text="<" OnClick="btnAddCategory_Click" CssClass="btn btn-default" />
                <asp:Button ID="btnRemoveCategory" runat="server" Text=">" OnClick="btnRemoveCategory_Click" CssClass="btn btn-default" />
            </div>
            <div class="col-md-6">
                <asp:ListBox ID="lstThreegSubCategory" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" OnDataBound="lstThreegSubCategory_DataBound" OnDataBinding="lstThreegSubCategory_DataBinding" CssClass="form-control"></asp:ListBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <asp:Button ID="btnLoadProducts" runat="server" Text="Učitaj" OnClick="btnLoadProducts_Click" OnClientClick="showPleaseWait()" CssClass="btn btn-primary" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <asp:Panel ID="pnlOptions" runat="server" Visible="false">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:CheckBox ID="chkSelectNew" runat="server" Text="Obeleži nove" OnCheckedChanged="chkSelectNew_CheckedChanged" AutoPostBack="true" CssClass="checkbox" />
                        </div>
                        <div class="col-md-3">
                            <asp:CheckBox ID="chkActive" runat="server" Text="Akiviraj" CssClass="checkbox" />
                        </div>
                        <div class="col-md-3">
                            <asp:CheckBox ID="chkApproved" runat="server" Text="Odobri" CssClass="checkbox" />
                        </div>
                        <div class="col-md-3">
                            <input type="button" onclick="btnSaveProducts_Click('threeg')" value="Sačuvaj" class="btn btn-primary" />
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <span id="saveStatus" class="status success" style="display:none"></span>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <span id="errorStatus" class="status danger" style="display:none"></span>
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-md-12">
                <div class="table-responsive">
                    <asp:GridView ID="dgvProducts" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-condensed table-striped table-bordered"
                        OnRowDataBound="dgvProducts_RowDataBound">
                        <Columns>
                            <asp:TemplateField ControlStyle-Width="30px">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkSelectAll" runat="server" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSave" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Šifra" ControlStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblSupplierCode" runat="server" Text='<%#Eval("sifra") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Barkod" ControlStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblEan" runat="server" Text='<%#Eval("barkod") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Proizvođač" ControlStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblManufacturer" runat="server" Text='<%#Eval("brand") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="200px">
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("naziv") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cena" ControlStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("vpCena")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mp cena" ControlStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblMpPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("mpCena")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ControlStyle-Width="20px">
                                <ItemTemplate>
                                    <asp:Image ID="imgStatus" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Postoji" ControlStyle-Width="100px" Visible="false">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkExists" runat="server" Checked='<%#int.Parse(Eval("exists").ToString()) == 1 %>' />
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
    <script type="text/javascript">
        function showPleaseWait() {
            document.getElementById('<%=divPleaseWait.ClientID%>').style.display = "block";
        }
    </script>
</asp:Content>
