using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using System.Configuration;

namespace WebShopAdmin
{
    public partial class kupindoMapCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("administrator") || User.IsInRole("korisnik") || User.IsInRole("prodavac")))
            {
                if (!Page.IsPostBack)
                {
                    loadCategories();
                    loadMappedCategories();
                }
            }
            else
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if(cmbCategory.SelectedIndex > -1 && cmbKupindoCategory.SelectedIndex > -1)
            {
                new kupindoBL().SaveMapping(int.Parse(cmbCategory.SelectedValue), int.Parse(cmbKupindoCategory.SelectedValue));
                loadMappedCategories();
            }
        }

        private void loadCategories()
        {
            cmbCategory.DataSource = new CategoryBL().GetNestedCategoriesDataTable();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();

            cmbKupindoCategory.DataSource = new kupindoBL().GetCategories();
            cmbKupindoCategory.DataTextField = "name";
            cmbKupindoCategory.DataValueField = "id";
            cmbKupindoCategory.DataBind();
        }

        private void loadMappedCategories()
        {
            dgvCategories.DataSource = new kupindoBL().GetMappedCategories();
            dgvCategories.DataBind();
        }
    }
}