using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using eshopBE;
using eshopBL;
using eshopUtilities;

namespace WebShopAdmin.webshopAdmin
{
    public partial class brand : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("administrator") || User.IsInRole("korisnik") || User.IsInRole("prodavac")))
            {
                if (!Page.IsPostBack)
                {
                    int brandID = -1;
                    if (Page.Request.QueryString.ToString().Contains("id") && int.TryParse(Page.Request.QueryString["id"], out brandID) && brandID > 0)
                        loadBrand(brandID);
                }
                txtName.Focus();
            }
            else
                Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        protected void btnSaveBrand_Click(object sender, EventArgs e)
        {
            saveBrand();
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            saveBrand();
            Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/brands.aspx");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/brands.aspx");
        }

        private void loadBrand(int brandID)
        {
            try
            { 
                Brand brand = new BrandBL().GetBrand(brandID);
                txtName.Text = brand.Name;
                lblBrandID.Value = brand.BrandID.ToString();
                imgImage.ImageUrl = brand.LogoUrl != null && brand.LogoUrl != string.Empty ? "/images/brand/" + brand.LogoUrl : string.Empty;
            }
            catch(BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true, "danger");
            }
        }

        private void saveBrand()
        {
            try
            { 
                Brand brand = new Brand();
                brand.Name = txtName.Text;
                brand.BrandID = lblBrandID.Value != string.Empty ? int.Parse(lblBrandID.Value) : -1;
                brand.LogoUrl = (imgImage.ImageUrl != null && imgImage.ImageUrl != string.Empty) ? imgImage.ImageUrl.Substring(imgImage.ImageUrl.LastIndexOf("/") + 1) : string.Empty;

                int brandID = new BrandBL().SaveBrand(brand);
                lblBrandID.Value = brandID.ToString();
            }
            catch(BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true, "danger");
            }
        }

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible, string status)
        {
            customStatus.Text = text;
            customStatus.ForeColor = foreColor;
            customStatus.Class = status;
            customStatus.Show();
        }

        protected void btnImageUpload_Click(object sender, EventArgs e)
        {
            if(fluImageUpload.HasFile && txtName.Text != string.Empty)
            {
                string filename = txtName.Text;
                string extension = fluImageUpload.FileName.Substring(fluImageUpload.FileName.LastIndexOf('.'));
                fluImageUpload.SaveAs(Server.MapPath("~/images/brand/" + filename + extension));
                imgImage.ImageUrl = "/images/brand/" + filename + extension;
            }
        }
    }
}