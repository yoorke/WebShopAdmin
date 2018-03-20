using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;
using System.Configuration;

namespace WebShopAdmin.webshopAdmin
{
    public partial class companySettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if(!Page.IsPostBack)
                {
                    loadSettings();
                }
            }
            else
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Settings settings = new Settings();
            settings.CompanyName = txtCompanyName.Text;
            settings.Phone = txtPhone.Text;
            settings.WorkingHours = txtWorkingHours.Text;

            new SettingsBL().SaveSettings(settings);
        }

        private void loadSettings()
        {
            Settings settings = new SettingsBL().GetSettings();
            txtCompanyName.Text = settings.CompanyName;
            txtPhone.Text = settings.Phone;
            txtWorkingHours.Text = settings.WorkingHours;
        }
    }
}