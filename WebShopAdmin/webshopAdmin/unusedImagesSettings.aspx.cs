using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using eshopBL;

namespace WebShopAdmin.webshopAdmin
{
    public partial class unusedImagesSettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("administrator")))
            {
                if (!Page.IsPostBack)
                    loadImages();
            }
            else
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        protected void btnDeleteAll_Click(object sender, EventArgs e)
        {

        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {

        }

        protected void dgvImages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        private void loadImages()
        {
            dgvImages.DataSource = new ImagesBL().GetUnusedImageFiles();
            dgvImages.DataBind();
        }
    }
}