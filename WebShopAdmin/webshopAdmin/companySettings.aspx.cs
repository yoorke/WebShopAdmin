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
            double deliveryCost = 0;
            double freeDeliveryTotalValue = 0;
            settings.DeliveryCost = double.TryParse(txtDeliveryCost.Text, out deliveryCost) ? deliveryCost : 0;
            settings.FreeDeliveryTotalValue = double.TryParse(txtFreeDeliveryTotalValue.Text, out freeDeliveryTotalValue) ? freeDeliveryTotalValue : 0;
            double exchangeRate = 0;
            settings.ExchangeRate = double.TryParse(txtExchangeRate.Text, out exchangeRate) ? exchangeRate : 0;

            new SettingsBL().SaveSettings(settings);

            setStatus("Uspešno sačuvano", "success");
        }

        private void loadSettings()
        {
            Settings settings = new SettingsBL().GetSettings();
            txtCompanyName.Text = settings.CompanyName;
            txtPhone.Text = settings.Phone;
            txtWorkingHours.Text = settings.WorkingHours;
            txtDeliveryCost.Text = string.Format("{0:N2}", settings.DeliveryCost);
            txtFreeDeliveryTotalValue.Text = string.Format("{0:N2}", settings.FreeDeliveryTotalValue);
            txtExchangeRate.Text = string.Format("{0:N2}", settings.ExchangeRate);
        }

        private void setStatus(string message, string classes)
        {
            csStatus.Text = message;
            csStatus.Class = "alert alert-" + classes;
            csStatus.Show();
        }
    }
}