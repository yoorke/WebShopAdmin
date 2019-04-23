using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using eshopBL;
using eshopBE;
using System.Data;

namespace WebShopAdmin.webshopAdmin
{
    public partial class getProductsThreeg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && (User.IsInRole("administrator") || User.IsInRole("prodavac") || User.IsInRole("korisnik")))
            {
                if (!Page.IsPostBack)
                {
                    loadIntoForm();
                }
            }
            else
                Page.Response.Redirect("/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        private void loadIntoForm()
        {
            cmbCategory.DataSource = new CategoryBL().GetNestedCategoriesDataTable();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();

            cmbThreegCategory1.DataSource = new ThreegBL().GetCategories(null, true);
            cmbThreegCategory1.DataTextField = "name";
            cmbThreegCategory1.DataValueField = "id";
            cmbThreegCategory1.DataBind();
            cmbThreegCategory1.SelectedIndex = -1;
        }

        protected void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cmbThreegCategory1_SelectedIndexChanged(object sender, EventArgs e)
        {
            cmbThreegCategory2.DataSource = new ThreegBL().GetCategories(int.Parse(cmbThreegCategory1.SelectedValue), true);
            cmbThreegCategory2.DataTextField = "name";
            cmbThreegCategory2.DataValueField = "id";
            cmbThreegCategory2.DataBind();

            lstThreegSubCategory.Items.Clear();
        }

        protected void cmbThreegCategory2_SelectedIndexChanged(object sender, EventArgs e)
        {
            lstThreegSubCategory.Items.Clear();
            DataTable categories = new ThreegBL().GetCategories(int.Parse(cmbThreegCategory2.SelectedValue), false);
            //lstThreegSubCategory.Items.Add(new ListItem("Odaberi", "-1"));
            for(int i = 0; i < categories.Rows.Count; i++)
            {
                lstThreegSubCategory.Items.Add(new ListItem(categories.Rows[i]["name"].ToString(), categories.Rows[i]["id"].ToString()));
            }
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            addCategories();
        }

        protected void btnRemoveCategory_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < lstCategory.Items.Count; i++)
                if (lstCategory.Items[i].Selected)
                    lstCategory.Items.Remove(lstCategory.Items[i--]);
        }

        protected void lstThreegSubCategory_DataBound(object sender, EventArgs e)
        {

        }

        protected void lstThreegSubCategory_DataBinding(object sender, EventArgs e)
        {

        }

        protected void btnLoadProducts_Click(object sender, EventArgs e)
        {
            string subCategories = string.Empty;
            for (int i = 0; i < lstCategory.Items.Count; i++)
            {
                subCategories += lstCategory.Items[i].Value + "|";
            }
            subCategories = subCategories.Remove(subCategories.Length - 1, 1);
            dgvProducts.DataSource = new ThreegBL().GetProducts(int.Parse(cmbThreegCategory1.SelectedValue), int.Parse(cmbThreegCategory2.SelectedValue), subCategories.Split('|'));
            dgvProducts.DataBind();

            pnlOptions.Visible = true;
            chkSelectNew.Checked = false;
            divPleaseWait.Style.Add("display", "none");
        }

        protected void dgvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((CheckBox)e.Row.FindControl("chkExists")).Checked)
                    ((Image)e.Row.FindControl("imgStatus")).ImageUrl = "/images/exists.jpg";
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                ((CheckBox)e.Row.FindControl("chkSelectAll")).Attributes.Add("onclick", "javascript:SelectAll('" + ((CheckBox)e.Row.FindControl("chkSelectAll")).ClientID + "')");
            }

        }

        private void addCategories()
        {
            for (int i = 0; i < lstThreegSubCategory.Items.Count; i++)
                if (lstThreegSubCategory.Items[i].Selected)
                    lstCategory.Items.Add(new ListItem(lstThreegSubCategory.Items[i].Text, lstThreegSubCategory.Items[i].Value));
        }

        protected void chkSelectNew_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}