using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using eshopBL;
using System.Data;
using eshopBE;
using eshopUtilities;

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

                loadIntoForm();
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

            lblImagesCount.Text = string.Format("{0:N0}", images.Rows.Count);
            lblImagesSize.Text = string.Format("{0:N2}", calculateSize(images) / 1024 / 1024);
        }

        private double calculateSize(DataTable images)
        {
            double totalSize = 0;
            foreach (DataRow row in images.Rows)
                totalSize += double.Parse(row["size"].ToString());

            return totalSize;
        }

        protected void btnResizeImages_Click(object sender, EventArgs e)
        {
            int width = 0;
            int height = 0;
            if (txtImageWidth.Text.Trim().Length > 0 && int.TryParse(txtImageWidth.Text, out width) && txtImageHeight.Text.Trim().Length > 0 && int.TryParse(txtImageHeight.Text, out height))
            {
                new ImagesBL().ResizeProductImages(width, height);
            }
        }

        protected void btnConvertImagesToWebP_Click(object sender, EventArgs e)
        {
            ProductBL productBL = new ProductBL();
            ImageConvertor imageConvertor = new ImageConvertor();
            ImagesBL imagesBL = new ImagesBL();
            int imageId = 0;
            int productImageUrlId = 0;
            string imageUrl;
            string filePath;
            string newImageUrl;
            string extension;
            int count = 0;

            DataTable images = new ImagesBL().GetAllProductImages();

            foreach(DataRow row in images.Rows)
            {
                try
                {
                    imageId = 0;
                    productImageUrlId = 0;
                    imageUrl = row["imageUrl"].ToString();
                    int.TryParse(imageUrl.Substring(0, imageUrl.LastIndexOf('.')), out imageId);
                    productImageUrlId = (int)row["productImageUrlId"];
                    extension = imageUrl.Substring(imageUrl.LastIndexOf('.') + 1).ToLower();

                    if(imageId > 0 && productImageUrlId > 0 && !extension.Equals("webp"))
                    {
                        filePath = productBL.CreateImageDirectory(imageId) + imageUrl;
                        newImageUrl = imageConvertor.ConvertImageToWebP(filePath);

                        if (!string.IsNullOrEmpty(newImageUrl)
                            && productBL.UpdateProductImageUrl(productImageUrlId, newImageUrl))
                        {
                            count++;

                            if(chkDeleteOldImageFiles.Checked)
                            {
                                imagesBL.DeleteImageFile(filePath);
                            }
                        }
                    }
                }
                catch(Exception ex)
                {
                    ErrorLog.LogError(ex);
                }
            }
        }

        private void loadIntoForm()
        {
            cmbImageType.Items.Add("Odaberi");
            cmbImageType.Items.Add("main");
            cmbImageType.Items.Add("list");
            cmbImageType.Items.Add("thumb");
        }

        protected void cmbImageType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbImageType.SelectedIndex > 0)
            {
                string type = cmbImageType.SelectedItem.ToString();
                txtImageWidth.Text = ConfigurationManager.AppSettings[$"{type}Width"];
                txtImageHeight.Text = ConfigurationManager.AppSettings[$"{type}Height"];

                btnResizeImages.Enabled = true;
            }
        }
    }
}