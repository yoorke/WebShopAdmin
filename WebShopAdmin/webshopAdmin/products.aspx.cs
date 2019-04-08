using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using eshopBE;
using eshopBL;
using System.Collections.Generic;
using System.Data;
using eshopUtilities;

namespace webshopAdmin
{
    public partial class products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //this.Form.DefaultButton = btnShowProducts.ClientID;
            if (User.Identity.IsAuthenticated && (User.IsInRole("administrator") || User.IsInRole("korisnik") || User.IsInRole("prodavac")))
            {
                if (!Page.IsPostBack)
                {
                    loadIntoForm();
                    //loadProducts();
                }
                divAdditionalCategory.Visible = bool.Parse(ConfigurationManager.AppSettings["productInMultipleCategories"]);
            }
            else
                Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        private void loadProducts()
        {
            int? categoryID = null;
            if (cmbCategory.SelectedIndex > 0)
                categoryID = int.Parse(cmbCategory.SelectedValue);

            int? supplierID = null;
            if (cmbSupplier.SelectedIndex > 0)
                supplierID = int.Parse(cmbSupplier.SelectedValue);

            int? brandID = null;
            if (cmbBrand.SelectedIndex > 1)
                brandID = int.Parse(cmbBrand.SelectedValue);

            int? promotionID = null;
            if (cmbPromotion.SelectedIndex > 0)
                promotionID = int.Parse(cmbPromotion.SelectedValue);

            ProductBL productsBL = new ProductBL();

            //List<Product> products = productsBL.GetProducts(categoryID, supplierID, cmbApproved.SelectedItem.Text, cmbActive.SelectedItem.Text, brandID, promotionID, cmbSort.SelectedIndex > -1 ? cmbSort.SelectedValue : null);
            DataTable products = productsBL.GetProductsDataTable(categoryID, supplierID, promotionID, brandID, cmbActive.SelectedItem.Text, cmbApproved.SelectedItem.Text, txtSearch.Text, cmbSort.SelectedIndex > -1 ? cmbSort.SelectedValue : "product.Name", string.Empty, cmbHasImage.SelectedItem.Text);

            //if (txtSearch.Text.Length > 0)
            //{
                //var productsList = (from product in products
                                    //where product.Name.ToLower().Contains(txtSearch.Text.ToLower())
                                    //select product);

                //dgvProducts.DataSource = productsList.ToList();
                //lblProductsCount.Text = productsList.Count().ToString();
            //}
            //else
            //{
                dgvProducts.DataSource = products;
                lblProductsCount.Text = products != null ? products.Rows.Count.ToString() : "0";
            //}
            dgvProducts.DataBind();

            
        }

        private void loadIntoForm()
        {
            CategoryBL categoryBL = new CategoryBL();
            //cmbCategory.DataSource = categoryBL.GetCategories();
            cmbCategory.DataSource = categoryBL.GetNestedCategoriesDataTable(true, true);
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();

            SupplierBL supplierBL = new SupplierBL();
            cmbSupplier.DataSource = supplierBL.GetSuppliers(true);
            cmbSupplier.DataTextField = "name";
            cmbSupplier.DataValueField = "supplierID";
            cmbSupplier.DataBind();
     

            cmbApproved.Items.Add("Sve");
            cmbApproved.Items.Add("Odobrene");
            cmbApproved.Items.Add("Neodobrene");
            

            cmbActive.Items.Add("Sve");
            cmbActive.Items.Add("Aktivne");
            cmbActive.Items.Add("Neaktivne");

            cmbPageSize.Items.Add("10");
            cmbPageSize.Items.Add("20");
            cmbPageSize.Items.Add("50");
            cmbPageSize.Items.Add("100");
            cmbPageSize.Items.Add("Sve");

            BrandBL brandBL = new BrandBL();
            cmbBrand.DataSource = brandBL.GetBrands(true);
            cmbBrand.DataTextField = "name";
            cmbBrand.DataValueField = "brandID";
            cmbBrand.DataBind();

            cmbPromotions.DataSource = new PromotionBL().GetPromotions(true, null, null);
            cmbPromotions.DataTextField = "name";
            cmbPromotions.DataValueField = "promotionID";
            cmbPromotions.DataBind();

            cmbPromotion.DataSource = new PromotionBL().GetPromotions(true, null, null);
            cmbPromotion.DataTextField = "name";
            cmbPromotion.DataValueField = "promotionID";
            cmbPromotion.DataBind();

            cmbAdditionallyCategory.DataSource = categoryBL.GetNestedCategoriesDataTable(true, true);
            cmbAdditionallyCategory.DataTextField = "name";
            cmbAdditionallyCategory.DataValueField = "categoryID";
            cmbAdditionallyCategory.DataBind();

            cmbSort.Items.Add(new ListItem("Nazivu", "brand.name, product.name"));
            cmbSort.Items.Add(new ListItem("Datumu unosa", "product.insertDate"));
            cmbSort.Items.Add(new ListItem("Datumu izmene", "product.updateDate"));
            cmbSort.Items.Add(new ListItem("Datum izmene opadajuće", "product.updateDate DESC"));
            cmbSort.Items.Add(new ListItem("Datum unosa opadajuće", "product.insertDate DESC"));

            cmbNewCategory.DataSource = new CategoryBL().GetNestedCategoriesDataTable(true, true);
            cmbNewCategory.DataTextField = "name";
            cmbNewCategory.DataValueField = "categoryID";
            cmbNewCategory.DataBind();

            cmbHasImage.Items.Add(new ListItem("Sve", "null"));
            cmbHasImage.Items.Add(new ListItem("Ima", "true"));
            cmbHasImage.Items.Add(new ListItem("Nema", "false"));

            cmbCustomPage.DataSource = new CustomPageBL().GetCustomPages();
            cmbCustomPage.DataTextField = "title";
            cmbCustomPage.DataValueField = "customPageID";
            cmbCustomPage.DataBind();
        }

        protected void btnShowProducts_Click(object sender, EventArgs e)
        {
            loadProducts();
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("~/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/product.aspx");
        }

        protected void dgvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            { 
                ProductBL productBL = new ProductBL();
                productBL.DeleteProduct(int.Parse(dgvProducts.DataKeys[e.RowIndex].Values[0].ToString()));

                Page.Response.Redirect("~/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/products.aspx");
            }
            catch(BLException blEx)
            {
                setStatus(blEx.Message, System.Drawing.Color.Red, true, "danger");
            }
            catch(Exception ex)
            {
                setStatus("Nije moguće obrisati proizvod.", System.Drawing.Color.Red, true, "danger");
            }
        }

        protected void dgvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvProducts.PageIndex = e.NewPageIndex;
            loadProducts();
        }

        protected void chkApproved_CheckChanged(object sender, EventArgs e)
        {
            CheckBox chkApproved = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkApproved.NamingContainer;

            ProductBL productBL = new ProductBL();
            if (productBL.SetApproved(int.Parse(((Label)row.FindControl("lblProductID")).Text), bool.Parse(((CheckBox)row.FindControl("chkApproved")).Checked.ToString())) > 0)
            {
                setStatus("Proizvod uspešno izmenjen", System.Drawing.Color.Green, true, "success");
            }
        }

        protected void chkActive_CheckChanged(object sender, EventArgs e)
        {
            CheckBox chkActive = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkActive.NamingContainer;

            ProductBL productBL = new ProductBL();
            productBL.SetActive(int.Parse(((Label)row.FindControl("lblProductID")).Text), bool.Parse(((CheckBox)row.FindControl("chkActive")).Checked.ToString()));
        }

        private void setStatus(string text, System.Drawing.Color foreColor, bool visible, string status)
        {
            csStatus.Text = text;
            csStatus.Visible = visible;
            csStatus.ForeColor = foreColor;
            csStatus.Class = status;
            csStatus.Show();
        }

        protected void dgvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                ((CheckBox)e.Row.FindControl("chkSelectAll")).Attributes.Add("onclick", "javascript:SelectAll('" + ((CheckBox)e.Row.FindControl("chkSelectAll")).ClientID + "')");
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string imageUrl = ((Image)e.Row.FindControl("imgProduct")).ImageUrl;
                if(imageUrl != string.Empty)
                    ((Image)e.Row.FindControl("imgProduct")).ImageUrl = new ProductBL().CreateImageDirectory(int.Parse(imageUrl.Substring(0, imageUrl.IndexOf(".")))) + imageUrl.Substring(0, imageUrl.IndexOf(".")) + "-" + ConfigurationManager.AppSettings["thumbName"] + imageUrl.Substring(imageUrl.IndexOf("."));
            }
        }

        protected void btnApproveAll_Click(object sender, EventArgs e)
        {
            ProductBL productBL=new ProductBL();
            for (int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                    productBL.SetApproved(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text), true);
            }
        }

        protected void btnActivateAll_Click(object sender, EventArgs e)
        {
            ProductBL productBL = new ProductBL();
            for (int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                    productBL.SetActive(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text), true);
            }
        }

        protected void cmbPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbPageSize.SelectedIndex > 0 && cmbPageSize.SelectedIndex <= 3)
                dgvProducts.PageSize = int.Parse(cmbPageSize.SelectedItem.Text);
            else if (cmbPageSize.SelectedIndex == 4)
                dgvProducts.AllowPaging = false;

            loadProducts();
        }

        protected void chkLocked_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkIsLocked = (CheckBox)sender;
            GridViewRow gridViewRow = (GridViewRow)chkIsLocked.NamingContainer;

            ProductBL productBL = new ProductBL();
            productBL.SetLocked(int.Parse(((Label)gridViewRow.FindControl("lblProductID")).Text), bool.Parse(((CheckBox)gridViewRow.FindControl("chkLocked")).Checked.ToString()));
            
        }

        protected void chkInStock_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkIsInStock = (CheckBox)sender;
            GridViewRow gridViewRow = (GridViewRow)chkIsInStock.NamingContainer;

            ProductBL productBL = new ProductBL();
            productBL.SetIsInStock(int.Parse(((Label)gridViewRow.FindControl("lblProductID")).Text), bool.Parse(((CheckBox)gridViewRow.FindControl("chkInStock")).Checked.ToString()));
        }

        protected void btnDeleteAll_Click(object sender, EventArgs e)
        {
            ProductBL productBL = new ProductBL();
            for (int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                {
                    productBL.DeleteProduct(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text));
                }
            }
        }

        protected void btnAddToPromotion_Click(object sender, EventArgs e)
        {
            if(cmbPromotions.SelectedIndex > 0)
            {
                double value = new PromotionBL().GetPromotion(int.Parse(cmbPromotions.SelectedValue)).Value;
                for(int i = 0; i < dgvProducts.Rows.Count; i++)
                {
                    if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                        new ProductBL().SetPromotionPrice(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text), double.Parse(((Label)dgvProducts.Rows[i].FindControl("lblWebPrice")).Text), value, int.Parse(cmbPromotions.SelectedValue));
                }
                loadProducts();
            }
        }

        protected void btnDeleteFromPromotion_Click(object sender, EventArgs e)
        {
            if(cmbPromotions.SelectedIndex > 0)
            {
                for(int i=0;i<dgvProducts.Rows.Count;i++)
                {
                    if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                        new ProductBL().DeleteFromPromotion(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text), int.Parse(cmbPromotions.SelectedValue));
                }
                loadProducts();
            }
        }

        protected void btnSaveProductCategory_Click(object sender, EventArgs e)
        {
            if(cmbAdditionallyCategory.SelectedIndex > -1)
            {
                for(int i = 0; i < dgvProducts.Rows.Count; i++)
                {
                    if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                        new ProductBL().SaveProductCategory(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text), int.Parse(cmbAdditionallyCategory.SelectedValue));
                }

                setStatus("Proizvodi dodati u kategoriju", System.Drawing.Color.Black, true, "success");
            }
        }

        protected void btnAddProductsToCustomPage_Click(object sender, EventArgs e)
        {
            if(cmbCustomPage.SelectedIndex > -1)
            { 
            List<CustomPageProduct> products = new List<CustomPageProduct>();
            for(int i = 0;i < dgvProducts.Rows.Count; i++)
            {
                if (((CheckBox)dgvProducts.Rows[i].FindControl("chkSelect")).Checked)
                    products.Add(new CustomPageProduct(int.Parse(((Label)dgvProducts.Rows[i].FindControl("lblProductID")).Text), ((Label)dgvProducts.Rows[i].FindControl("lblName")).Text));
            }

            new CustomPageBL().SaveCustomPageProducts(products, int.Parse(cmbCustomPage.SelectedValue));
            }
        }
    }
}
