using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using eshopBL;
using eshopBE;

namespace WebShopAdmin.webshopAdmin
{
    public partial class retail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                if(!Page.IsPostBack)
                {
                    loadIntoForm();

                    int categoryID = -1;
                    if(int.TryParse(Request.QueryString["id"], out categoryID))
                    {
                        if (categoryID > 0)
                            loadRetail(categoryID);
                    }
                }
                else
                {
                    lblRetailName.Text = ViewState["lblRetailName"] != null ? ViewState["lblRetailName"].ToString() : string.Empty;
                }
                txtName.Focus();
            }
            else
                Response.Redirect("~/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Request.RawUrl);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            saveRetail();
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            saveRetail();
            Response.Redirect("~/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/retails.aspx");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/retails.aspx");
        }

        private void loadIntoForm()
        {
            cmbCity.DataSource = new CityBL().GetCities(false);
            cmbCity.DataTextField = "Name";
            cmbCity.DataValueField = "CityID";
            cmbCity.DataBind();
        }

        private void loadRetail(int retailID)
        {
            try
            { 
                Retail retail = new RetailBL().GetRetail(retailID);
                txtName.Text = retail.Name;
                txtAddress.Text = retail.Address;
                cmbCity.SelectedValue = retail.City.CityID.ToString();
                txtPhone.Text = retail.Phone;
                txtMobilePhone.Text = retail.MobilePhone;
                txtLocation.Text = retail.Location;
                chkIsActive.Checked = retail.IsActive;
                lblRetailID.Value = retail.RetailID.ToString();
                ViewState.Add("lblRetailName", retail.Name);
                lblRetailName.Text = retail.Name;
            }
            catch(Exception ex)
            {
                setMessage(ex.Message, System.Drawing.Color.Red, true, "danger");
            }
        }

        private void saveRetail()
        {
            try
            { 
                Retail retail = new Retail();
                retail.Name = txtName.Text;
                retail.Address = txtAddress.Text;
                retail.City = new City(int.Parse(cmbCity.SelectedValue), string.Empty, string.Empty);
                retail.Phone = txtPhone.Text;
                retail.MobilePhone = txtMobilePhone.Text;
                retail.Location = txtLocation.Text;
                retail.IsActive = chkIsActive.Checked;
                if (lblRetailID.Value != string.Empty)
                    retail.RetailID = int.Parse(lblRetailID.Value);
                ViewState.Add("lblRetailName", retail.Name);
                lblRetailName.Text = retail.Name;


                int status = retail.RetailID == 0 ? new RetailBL().Insert(retail) : new RetailBL().Update(retail);

                setMessage("Prodajno mesto uspešno sačuvano", System.Drawing.Color.Green, true, "success");
            }
            catch(Exception ex)
            {
                setMessage(ex.Message, System.Drawing.Color.Red, true, "danger");
            }
        }
            
        private void setMessage(string message, System.Drawing.Color color, bool visible, string status)
        {
            customStatus.Text = message;
            customStatus.ForeColor = color;
            customStatus.Visible = visible;
            customStatus.Class = "status alert alert-" + status;
            customStatus.Show();
        }
    }
}