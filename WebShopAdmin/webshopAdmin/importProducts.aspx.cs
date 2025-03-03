using eshop.Import.BE;
using eshop.Import.BL;
using eshop.Import.BL.Interfaces;
using eshopBL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShopAdmin.webshopAdmin
{
    public partial class importProducts : System.Web.UI.Page
    {
        private string _supplierCode;
        private IProductImportBL _productImportBL;
        private ICategoryImportBL _categoryImportBL;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(User.Identity.IsAuthenticated && (User.IsInRole("administrator") || User.IsInRole("prodavac") || User.IsInRole("korisnik")))
            {
                setImportBL();
                if (!Page.IsPostBack)
                {
                    loadIntoForm();   
                }
            }
            else
            {
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
            }
        }

        private void loadIntoForm()
        {
            cmbCategory.DataSource = new CategoryBL().GetNestedCategoriesDataTable();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "CategoryID";
            cmbCategory.DataBind();

            cmbImportCategory.DataSource = _categoryImportBL.GetCategories(null);
            cmbImportCategory.DataTextField = "Name";
            cmbImportCategory.DataValueField = "ID";
            cmbImportCategory.DataBind();
        }

        private void setImportBL()
        {
            string supplierCode = getSupplierCode();
            switch (supplierCode)
            {
                case "uspon":
                    {
                        _productImportBL = new ProductImportUsponBL();
                        _categoryImportBL = new CategoryImportUsponBL();

                        btnSave.Attributes.Add("onclick", "SaveImportProduct('uspon')");
                        break;
                    }
                case "dsc":
                    {
                        _productImportBL = new ProductImportDSCBL();
                        _categoryImportBL = new CategoryImportDSCBL();

                        btnSave.Attributes.Add("onclick", "SaveImportProduct('dsc')");
                        break;
                    }
                //case "ewe":
                //    {
                //        _productImportBL = new ProductImportEweBL();
                //        _categoryImportBL = new CategoryImportEweBL();

                //        btnSave.Attributes.Add("onclick", "SaveImportProduct('ewe')");
                //        break;
                //    }
                case "ewe":
                    {
                        _productImportBL = new ProductImportEweV2BL();
                        _categoryImportBL = new CategoryImportEweV2BL();

                        btnSave.Attributes.Add("onclick", "SaveImportProduct('ewe')");
                        break;
                    }
            }

            lblSupplierName.Text = supplierCode;
        }

        private string getSupplierCode()
        {
            if (!string.IsNullOrEmpty(_supplierCode))
            {
                return _supplierCode;
            }

            if (Page.Request.QueryString.ToString().Contains("supplierCode"))
            {
                _supplierCode = Page.Request.QueryString["supplierCode"].ToString();
                return _supplierCode;
            }

            return string.Empty;
        }

        protected void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbCategory.SelectedIndex > -1)
            {
                lstCategory.Items.Clear();

                //CategoryImport categoryImport = _categoryImportBL.GetSupplierCategoryForCategoryID(int.Parse(cmbCategory.SelectedValue));
                List<CategoryImport> categoriesImport = _categoryImportBL.GetSupplierCategoriesForCategoryID(int.Parse(cmbCategory.SelectedValue));

                //if(categoryImport != null)
                //{
                //cmbImportCategory.SelectedValue = categoryImport.ID.ToString();
                //cmbImportCategory_SelectedIndexChanged(this, null);
                //}
                //else if(cmbImportCategory.Items.Count > 0)
                //{
                //cmbImportCategory.SelectedIndex = 0;
                //lstImportCategory.Items.Clear();
                //}
                //else
                //{
                //lstImportCategory.Items.Clear();
                //}

                foreach (CategoryImport categoryImport in categoriesImport)
                {
                    lstCategory.Items.Add(new ListItem($"{categoryImport.ParentName}-{categoryImport.Name}", categoryImport.ID.ToString()));
                }

                if (lstCategory.Items.Count > 0)
                {
                    divLoadControls.Visible = true;
                    loadManufacturers();
                }

                
                dgvProducts.DataSource = null;
                dgvProducts.DataBind();
            }
        }

        protected void cmbImportCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            lstImportCategory.Items.Clear();
            List<CategoryImport> categories = _categoryImportBL.GetCategories(cmbImportCategory.SelectedItem.Text);

            foreach(var category in categories)
            {
                lstImportCategory.Items.Add(new ListItem(category.Name, category.ID.ToString()));
                //lstImportCategory.Items[lstImportCategory.Items.Count - 1].Selected = category.IsSelected;
            }

            if(categories != null && categories.Count > 0)
            {
                chkIncludeParentCategory.Enabled = false;
            }

            //addSelectedCategories();
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            addSelectedCategories();
        }

        protected void btnRemoveCategory_Click(object sender, EventArgs e)
        {
            for(int i = 0; i < lstCategory.Items.Count; i++)
            {
                if(lstCategory.Items[i].Selected)
                {
                    lstCategory.Items.Remove(lstCategory.Items[i--]);
                }
            }
        }

        protected void lstImportCategory_DataBound(object sender, EventArgs e)
        {

        }

        protected void lstImportCategory_DataBinding(object sender, EventArgs e)
        {

        }

        protected void btnLoadProducts_Click(object sender, EventArgs e)
        {
            List<string> subCategories = new List<string>();

            _categoryImportBL.DeleteCategorySupplierCategory(int.Parse(cmbCategory.SelectedValue));
            //_categoryImportBL.SaveSupplierCategoryForCategory(int.Parse(cmbCategory.SelectedValue), int.Parse(cmbImportCategory.SelectedValue), true);

            foreach(ListItem item in lstCategory.Items)
            {
                subCategories.Add(item.Text);

                _categoryImportBL.SaveSupplierCategoryForCategory(int.Parse(cmbCategory.SelectedValue), int.Parse(item.Value), false);
            }

            dgvProducts.DataSource = _productImportBL.GetProducts(cmbImportCategory.SelectedItem.Text, subCategories, cmbManufacturer.SelectedValue);
            dgvProducts.DataBind();

            pnlOptions.Visible = true;
            //chkSelectNew.Checked = false;
            divPleaseWait.Style.Add("display", "none");
            //chkSelectNew.Attributes.Add("onclick", "selectNew(); return false;");
        }

        private void addSelectedCategories()
        {
            //lstCategory.Items.Clear();

            if (chkIncludeParentCategory.Checked && lstImportCategory.Items.Count == 0)
            {
                lstCategory.Items.Add(new ListItem(cmbImportCategory.SelectedItem.Text, cmbImportCategory.SelectedItem.Value));
                chkIncludeParentCategory.Checked = false;
            }

            for(int i = 0; i < lstImportCategory.Items.Count; i++)
            {
                if(lstImportCategory.Items[i].Selected)
                {
                    lstCategory.Items.Add(new ListItem($"{cmbImportCategory.SelectedItem.Text}-{lstImportCategory.Items[i].Text}", lstImportCategory.Items[i].Value));
                }
            }

            if(lstCategory.Items.Count > 0)
            {
                divLoadControls.Visible = true;
                loadManufacturers();
            }
        }

        protected void chkSelectNew_CheckedChanged(object sender, EventArgs e)
        {
            for(int i = 0; i < dgvProducts.Rows.Count; i++)
            {
                if(((Image)dgvProducts.Rows[i].FindControl("imgStatus")).ImageUrl == string.Empty)
                {
                    //((CheckBox)dgvProducts.Rows[i].FindControl("chkSave")).Checked = chkSelectNew.Checked;
                }
            }
        }

        protected void dgvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                if(((CheckBox)e.Row.FindControl("chkExists")).Checked)
                {
                    ((Image)e.Row.FindControl("imgStatus")).ImageUrl = "/images/exists.jpg";
                }
                else
                {
                    ((Image)e.Row.FindControl("imgStatus")).ImageUrl = "/images/not-exists.jpg";
                }
            }
            else if(e.Row.RowType == DataControlRowType.Header)
            {
                //((CheckBox)e.Row.FindControl("chkSelectAll")).Attributes.Add("onclick", "javascript:SelectAll('" + ((CheckBox)e.Row.FindControl("chkSelectAll")).ClientID + "')");
                ((CheckBox)e.Row.FindControl("chkSelectAll")).Attributes.Add("onclick", "checkAllInTable(" + dgvProducts.ClientID + ", " + ((CheckBox)e.Row.FindControl("chkSelectAll")).ClientID + ")");
            }
        }

        private void loadManufacturers()
        {
            List<string> subCategories = new List<string>();

            foreach(ListItem item in lstCategory.Items)
            {
                subCategories.Add(item.Text);
            }

            cmbManufacturer.DataSource = _productImportBL.GetManufacturers(subCategories);
            cmbManufacturer.DataValueField = "Name";
            cmbManufacturer.DataTextField = "Name";
            cmbManufacturer.DataBind();
        }

        protected void btnUpdateCategories_Click(object sender, EventArgs e)
        {
            _categoryImportBL.UpdateSupplierCategories();

            loadIntoForm();

            setStatus("Kategorije uspešno ažurirane.", "success");
        }

        protected void btnGetProducts_Click(object sender, EventArgs e)
        {
            List<ProductImport> products;
            GetParameter getParameter = new GetParameter()
            {
                Images = true,
                Attributes = true,
                Description = true
            };

            try
            {
                products = _productImportBL.ParseProducts("", null, getParameter, false, true);

                setStatus("Proizvodi uspešno preuzeti.", "success");
            }
            catch(Exception ex)
            {
                setStatus(ex.Message, "danger");
            }
        }

        private void setStatus(string message, string type)
        {
            lblStatus.Text = message;
            lblStatus.Visible = true;
            lblStatus.CssClass = "alert alert-" + type;
        }

        protected void btnUpdatePriceAndStock_Click(object sender, EventArgs e)
        {
            List<string> subCategories = new List<string>();
            string importCategory = string.Empty;
            int updatedCount = 0;

            try
            {
                foreach(ListItem item in lstCategory.Items)
                {
                    subCategories.Add(item.Text);
                }

                if(subCategories.Count > 0)
                {
                    importCategory = cmbImportCategory.SelectedItem.Text;
                }

                updatedCount = _productImportBL.UpdatePriceAndStock(importCategory, subCategories);

                setStatus($"Cene i stanja uspešno ažurirani. Ukupno ažurirano: {updatedCount} proizvoda.", "success");
            }
            catch(Exception ex)
            {
                setStatus(ex.Message, "danger");
            }
        }
    }
}