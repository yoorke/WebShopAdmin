using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using eshopBL;
using eshopUtilities;

namespace WebShopAdmin.webshopAdmin
{
    public partial class brands : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("administrator") || User.IsInRole("korisnik") || User.IsInRole("prodavac")))
            {
                if (!Page.IsPostBack)
                    loadBrands();
            }
            else
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        protected void btnAddBrand_Click(object sender, EventArgs e)
        {
            Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/brand.aspx");
        }

        protected void dgvBrands_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                new BrandBL().DeleteBrand(int.Parse(dgvBrands.DataKeys[e.RowIndex].Values[0].ToString()));
                loadBrands();
            }
            catch(BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true, "danger");
            }
        }

        private void loadBrands()
        {
            dgvBrands.DataSource = new BrandBL().GetBrands(false);
            dgvBrands.DataBind();
        }

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible, string status)
        {
            customStatus.Text = text;
            customStatus.Visible = visible;
            customStatus.ForeColor = foreColor;
            customStatus.Class = status;
            customStatus.Show();
        }
    }
}