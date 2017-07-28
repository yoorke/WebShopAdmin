<%@ Page Title="" Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="kupindoSettings.aspx.cs" Inherits="WebShopAdmin.webshopAdmin.kupindoSettings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Kupindo podešavanja</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <h2>Načini plaćanja</h2>
                <div class="form-horizontal" role="form">
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkLimundoCash" runat="server" Text="Limundo Cash" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkSlanjePosleUplate" runat="server" Text="Slanje posle uplate" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkPlacanjePreSlanjaTekuciRacun" runat="server" Text="Plaćanje pre slanja (Tekući račun)" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkPlacanjePreSlanjaPostNet" runat="server" Text="Plaćanje pre slanja (PostNet)" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkPlacanjePreSlanjaOstalo" runat="server" Text="Plaćanje pre slanja (Ostalo)" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkSlanjePreUplate" runat="server" Text="Slanje pre uplate" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkSlanjePouzecem" runat="server" Text="Slanje pouzećem" />
                    </div>
                </div>
                <h2>Načini slanja</h2>
                <div class="form-horizontal" role="form">
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkLicnoPreuzimanje" runat="server" Text="Lično preuzimanje" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkPosta" runat="server" Text="Pošta" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkAks" runat="server" Text="AKS" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkCityExpress" runat="server" Text="City Express" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkPostExpress" runat="server" Text="Post Express" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkDailyExpress" runat="server" Text="Daily Express" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkBex" runat="server" Text="BEX" />
                    </div>
                    <div class="form-group checkbox-control">
                        <asp:CheckBox ID="chkOrganizovaniTransport" runat="server" Text="Organizovani transport" />
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="txtDefaultLager" class="control-label col-lg-4">Podrazumevani lager:</label>
                        <div class="col-lg-8">
                            <asp:TextBox ID="txtDefaultLager" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtKupindoAccess" class="control-label col-lg-4">Vreme pristupa:</label>
                        <div class="col-lg-8">
                            <asp:TextBox ID="txtKupindoAccess" runat="server" CssClass="form-control" TextMode="MultiLine" Height="100px"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
