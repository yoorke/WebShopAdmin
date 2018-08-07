using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using System.Data;

namespace WebShopAdmin.webshopAdmin
{
    public partial class attributeKupindoAttribute : System.Web.UI.Page
    {
        List<eshopBE.Attribute> attributes;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(User.Identity.IsAuthenticated && (User.IsInRole("administrator") || User.IsInRole("korisnik") || User.IsInRole("prodavac")))
            {
                if(!Page.IsPostBack)
                {
                    loadCategories();
                }
            }
        }

        private void loadCategories()
        {
            cmbCategory.DataSource = new CategoryBL().GetNestedCategoriesDataTable();
            cmbCategory.DataTextField = "name";
            cmbCategory.DataValueField = "categoryID";
            cmbCategory.DataBind();
        }

        protected void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable kupindoCategory = new DataTable();
            if(cmbCategory.SelectedIndex > -1)
            {
                kupindoCategory = new kupindoBL().GetKupindoCategoryForCategory(int.Parse(cmbCategory.SelectedValue));
                lblKupindoCategory.Text = kupindoCategory.Rows[0]["name"].ToString();

                loadAttributes(int.Parse(cmbCategory.SelectedValue));

                dgvAttributes.DataSource = new kupindoBL().GetKupindoAttributes(int.Parse(kupindoCategory.Rows[0]["ID"].ToString()), int.Parse(cmbCategory.SelectedValue));
                dgvAttributes.DataBind();
            }
        }

        protected void dgvAttributes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList cmbAttribute = ((DropDownList)e.Row.FindControl("cmbAttribute"));
                cmbAttribute.DataSource = attributes;
                cmbAttribute.DataTextField = "name";
                cmbAttribute.DataValueField = "attributeID";
                cmbAttribute.DataBind();

                if (((Label)e.Row.FindControl("lblAttributeID")).Text != string.Empty)
                    cmbAttribute.SelectedValue = ((Label)e.Row.FindControl("lblAttributeID")).Text;
            }
        }

        private void loadAttributes(int categoryID)
        {
            attributes = new AttributeBL().GetAttributesForCategory(categoryID, true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            for(int i = 0; i < dgvAttributes.Rows.Count; i++)
            {
                if (((DropDownList)dgvAttributes.Rows[i].FindControl("cmbAttribute")).SelectedIndex > 0)
                    new kupindoBL().SaveKupindoAttributeForAttribute(int.Parse(((DropDownList)dgvAttributes.Rows[i].FindControl("cmbAttribute")).SelectedValue), int.Parse(((Label)dgvAttributes.Rows[i].FindControl("lblKupindoAttributeID")).Text));
            }
        }

    }
}