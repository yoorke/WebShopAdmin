<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="importProducts.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.importProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="divPleaseWait" runat="server" class="pleaseWait" style="display:none">
        <span>Molim, sačekajte</span>
    </div>
    <asp:HiddenField ID="lblSupplierCode" runat="server" />
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Preuzimanje proizvoda <asp:Label ID="lblSupplierName" runat="server"></asp:Label></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <asp:Label ID="lblStatus" runat="server" Visible="false" style="display:block;text-align:center"></asp:Label>
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-lg-5">
                <div class="form-group">
                    <label for="cmbCategory">Kategorija</label>
                    <asp:DropDownList ID="cmbCategory" runat="server" OnSelectedIndexChanged="cmbCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
            <div class="col-lg-6 col-lg-offset-1">
                <div class="form-group">
                    <label for="cmbImportCategory">Kategorija dobavljača</label>
                    <asp:DropDownList ID="cmbImportCategory" runat="server" OnSelectedIndexChanged="cmbImportCategory_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-5">
                <asp:ListBox ID="lstCategory" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" CssClass="form-control"></asp:ListBox>
            </div>
            <div class="col-lg-1">
                <asp:Button ID="btnAddCategory" runat="server" Text="<" OnClick="btnAddCategory_Click" CssClass="btn btn-default" />
                <asp:Button ID="btnRemoveCategory" runat="server" Text=">" OnClick="btnRemoveCategory_Click" CssClass="btn btn-default" />
            </div>
            <div class="col-lg-6">
                <asp:ListBox ID="lstImportCategory" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" OnDataBound="lstImportCategory_DataBound" OnDataBinding="lstImportCategory_DataBinding" CssClass="form-control"></asp:ListBox>
            </div>
        </div>
        <div class="row margin-top-05">
            <div class="col-lg-6">
                <div class="btn-group">
                    <asp:Button ID="btnGetProducts" runat="server" Text="Preuzmi proizvode" CssClass="btn btn-primary" OnClick="btnGetProducts_Click" OnClientClick="showPleaseWait()" />
                    <asp:Button ID="btnUpdatePriceAndStock" runat="server" Text="Užuriraj cene i stanja" CssClass="btn btn-primary" OnClick="btnUpdatePriceAndStock_Click" OnClientClick="showPleaseWait()" />
                </div>
            </div>
            <div class="col-lg-6">
                <asp:Button ID="btnUpdateCategories" runat="server" Text="Osveži kategorije" CssClass="btn btn-primary" OnClick="btnUpdateCategories_Click" OnClientClick="showPleaseWait()" />
                <asp:CheckBox ID="chkIncludeParentCategory" runat="server" CssClass="checkbox" Text="Uključi i osnovnu kategoriju u uvoz" Checked="false" Enabled="false" />
            </div>
        </div>
        <div id="divLoadControls" runat="server" visible="false">
            <div class="row margin-top-2">
                <div class="col-lg-4">
                    <div class="form-group">
                        <label for="">Proizvođač</label>
                        <asp:DropDownList ID="cmbManufacturer" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="row margin-top-05">
                <div class="col-lg-6">
                    <asp:Button ID="btnLoadProducts" runat="server" CssClass="btn btn-primary" Text="Učitaj proizvode" OnClientClick="showPleaseWait()" OnClick="btnLoadProducts_Click" />
                </div>
            </div>
        </div>
        <div class="row margin-top-2">
            <div class="col-lg-5">
                <asp:Panel ID="pnlOptions" runat="server" Visible="false">
                    <div class="form-group">
                        <%--<asp:CheckBox ID="chkSelectNew" runat="server" Text="Obeleži nove" OnCheckedChanged="chkSelectNew_CheckedChanged" AutoPostBack="true" CssClass="checkbox" />--%>
                        <div>
                            <input id="chkSelectNew" type="checkbox" onclick="selectNew(this)" />
                            <span>Obeleži nove</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:CheckBox ID="chkActive" runat="server" Text="Aktiviraj" CssClass="checkbox" />
                    </div>
                    <div class="form-group">
                        <asp:CheckBox ID="chkApproved" runat="server" Text="Odobri" CssClass="checkbox" />
                    </div>
                    <div class="form-group">
                        <input ID="btnSave" runat="server" type="button" value="Sačuvaj" class="btn btn-default" />
                    </div>
                </asp:Panel>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <span id="saveStatus" class="status success" style="display:none"></span>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <span id="errorStatus" class="status danger" style="display:none"></span>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <asp:GridView ID="dgvProducts" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-bordered table-condensed table-striped"
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
                                <asp:Label ID="lblSupplierCode" runat="server" Text='<%#Eval("code") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Barkod" ControlStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblEan" runat="server" Text='<%#Eval("ean") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Proizvođač" ControlStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblManufacturer" runat="server" Text='<%#Eval("manufacturer") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cena" ControlStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="lblPrice" runat="server" Text='<%#String.Format("{0:N2}", Eval("b2bPrice")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Postoji" ControlStyle-Width="100px" Visible="false">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkExists" runat="server" Checked='<%#Eval("imported") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ControlStyle-Width="20px">
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
    <script type="text/javascript">
        $(document).ready(function(){
            $("[id*=cmbCategory]").select2();
            $("[id*=cmbImportCategory]").select2();
            $("[id*=cmbManufacturer]").select2();
        })
    </script>
    <script type="text/javascript">
        function showPleaseWait() {
            $("[id*=divPleaseWait").show();
        }
    </script>
    <script type="text/javascript">
        function selectNew(checkbox) {
            let index = 0;
            $('[id*=dgvProducts] tr').each(function () {
                if (index > 0) {
                    if ($(this).find('img')[0].src.indexOf('not-exists') > -1) {
                        $(this).find('input[type=checkbox]')[0].checked = checkbox.checked;
                    }
                }
                index++;
            })
        }
    </script>
</asp:Content>
