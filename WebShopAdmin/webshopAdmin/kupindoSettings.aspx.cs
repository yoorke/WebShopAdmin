using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using eshopBL;

namespace WebShopAdmin.webshopAdmin
{
    public partial class kupindoSettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("Administrator") || User.IsInRole("korisnik") || User.IsInRole("prodavac")))
            {
                if(!Page.IsPostBack)
                { 
                    loadSettings();
                }
            }
            else
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        private void loadSettings()
        {
            DataTable settings = new kupindoBL().LoadSettings();

            chkLimundoCash.Checked = bool.Parse(settings.Rows[0]["value"].ToString());
            chkSlanjePosleUplate.Checked = bool.Parse(settings.Rows[1]["value"].ToString());
            chkSlanjePreUplate.Checked = bool.Parse(settings.Rows[2]["value"].ToString());
            chkSlanjePouzecem.Checked = bool.Parse(settings.Rows[3]["value"].ToString());
            chkLicnoPreuzimanje.Checked = bool.Parse(settings.Rows[4]["value"].ToString());
            chkPosta.Checked = bool.Parse(settings.Rows[5]["value"].ToString());
            chkAks.Checked = bool.Parse(settings.Rows[6]["value"].ToString());
            chkCityExpress.Checked = bool.Parse(settings.Rows[7]["value"].ToString());
            chkPostExpress.Checked = bool.Parse(settings.Rows[8]["value"].ToString());
            chkDailyExpress.Checked = bool.Parse(settings.Rows[9]["value"].ToString());
            chkBex.Checked = bool.Parse(settings.Rows[10]["value"].ToString());
            chkOrganizovaniTransport.Checked = bool.Parse(settings.Rows[11]["value"].ToString());
            chkPlacanjePreSlanjaTekuciRacun.Checked = bool.Parse(settings.Rows[14]["value"].ToString());
            chkPlacanjePreSlanjaPostNet.Checked = bool.Parse(settings.Rows[15]["value"].ToString());
            chkPlacanjePreSlanjaOstalo.Checked = bool.Parse(settings.Rows[16]["value"].ToString());

            txtDefaultLager.Text = settings.Rows[12]["value"].ToString();
            txtKupindoAccess.Text = settings.Rows[13]["value"].ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DataTable settings = new DataTable();
            settings.Columns.Add("kupindoSettingsID");
            settings.Columns.Add("naziv");
            settings.Columns.Add("value");

            DataRow newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 1;
            newRow["naziv"] = "LimundoCash";
            newRow["value"] = chkLimundoCash.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 2;
            newRow["naziv"] = "Slanje posle uplate";
            newRow["value"] = chkSlanjePosleUplate.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 3;
            newRow["naziv"] = "Slanje pre uplate";
            newRow["value"] = chkSlanjePreUplate.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 4;
            newRow["naziv"] = "Slanje posle uplate";
            newRow["value"] = chkSlanjePosleUplate.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 5;
            newRow["naziv"] = "Lično preuzimanje";
            newRow["value"] = chkLicnoPreuzimanje.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 6;
            newRow["naziv"] = "Pošta";
            newRow["value"] = chkPosta.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 7;
            newRow["naziv"] = "AKS";
            newRow["value"] = chkAks.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 8;
            newRow["naziv"] = "City Express";
            newRow["value"] = chkCityExpress.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 9;
            newRow["naziv"] = "Post Express";
            newRow["value"] = chkPostExpress.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 10;
            newRow["naziv"] = "Daily Express";
            newRow["value"] = chkDailyExpress.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 11;
            newRow["naziv"] = "Bex";
            newRow["value"] = chkBex.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 12;
            newRow["naziv"] = "Organizovani transport";
            newRow["value"] = chkOrganizovaniTransport.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 13;
            newRow["naziv"] = "Default lager";
            newRow["value"] = txtDefaultLager.Text;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 17;
            newRow["naziv"] = "Plaćanje pre slanja (Tekući račun)";
            newRow["value"] = chkPlacanjePreSlanjaTekuciRacun.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 18;
            newRow["naziv"] = "Plaćanje pre slanja (PostNet)";
            newRow["value"] = chkPlacanjePreSlanjaPostNet.Checked;
            settings.Rows.Add(newRow);

            newRow = settings.NewRow();
            newRow["kupindoSettingsID"] = 19;
            newRow["value"] = chkPlacanjePreSlanjaOstalo.Checked;
            settings.Rows.Add(newRow);

            new kupindoBL().SaveSettings(settings);

        }
    }
}