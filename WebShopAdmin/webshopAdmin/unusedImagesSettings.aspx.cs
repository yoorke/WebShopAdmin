using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using eshopBL;
using System.Data;

namespace WebShopAdmin.webshopAdmin
{
    public partial class unusedImagesSettings : System.Web.UI.Page
    {
        DataTable images;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("administrator")))
            {
                //if (!Page.IsPostBack)
                    //loadImages();
            }
            else
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        protected void btnDeleteAll_Click(object sender, EventArgs e)
        {
            new ImagesBL().DeleteUnusedFiles();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            loadImages();
        }

        protected void dgvImages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        private void loadImages()
        {
            images = new ImagesBL().GetUnusedImageFiles();

            if(chkShowImages.Checked)
            { 
                dgvImages.DataSource = images;
                dgvImages.DataBind();
            }

            lblImagesCount.Text = string.Format("{0:N2}", images.Rows.Count);
            lblImagesSize.Text = string.Format("{0:N2}", calculateSize(images) / 1024);
        }

        private double calculateSize(DataTable images)
        {
            double totalSize = 0;
            foreach (DataRow row in images.Rows)
                totalSize += double.Parse(row["size"].ToString());

            return totalSize;
        }
    }
}