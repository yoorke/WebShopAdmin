using eshopBL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShopAdmin.webshopAdmin
{
    public partial class productCopyData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCopyData_Click(object sender, EventArgs e)
        {
            int oldID = -1;
            int newID = -1;
            if(txtOldID.Text.Length > 0
                && int.TryParse(txtOldID.Text, out oldID) &&
                txtNewID.Text.Length > 0
                && int.TryParse(txtNewID.Text, out newID))
            {
                new ProductBL().CopyData(oldID, newID);
                setStatus("Podaci su uspešno kopirani sa: " + oldID + " na: " + newID, "success");
            }
        }

        private void setStatus(string message, string classes)
        {
            customStatus.Text = message;
            customStatus.Class = classes;
            customStatus.Show();
        }
    }
}