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
    public partial class retails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("Administrator") || User.IsInRole("korisnik") || User.IsInRole("prodavac")))
            {
                if (!Page.IsPostBack)
                    loadRetails(-1, string.Empty);
            }
            else
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        private void loadRetails(int cityID, string name)
        {
            dgvRetails.DataSource = new RetailBL().GetRetails(cityID, name, false);
            dgvRetails.DataBind();
        }

        protected void btnAddRetail_Click(object sender, EventArgs e)
        {
            Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/retail.aspx");
        }

        protected void dgvRetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void dgvRetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int status = new RetailBL().Delete(int.Parse(dgvRetails.DataKeys[e.RowIndex].Values[0].ToString()));
                Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/retails.aspx");
            }
            catch(BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true);
            }
        }

        protected void dgvRetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        private void setStatus(string message, System.Drawing.Color color, bool visible)
        {
            customStatus.Text = message;
            customStatus.Visible = visible;
            customStatus.ForeColor = color;
            customStatus.Show();
        }
    }
}