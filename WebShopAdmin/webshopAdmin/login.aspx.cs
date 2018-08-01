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

namespace webshopAdmin
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string returnUrl = (Page.Request.QueryString.ToString().Contains("returnUrl")) ? Page.Request.QueryString["returnUrl"] : string.Empty;
            
            Login1.DestinationPageUrl = returnUrl;
            Login1.Focus();
        }

        protected void Login1_LoggedIn(object sender, EventArgs e)
        {
            //Response.Redirect("/administrator");
            if(((CheckBox)Login1.FindControl("RememberMe")).Checked)
            {
                var ticket = new FormsAuthenticationTicket(((TextBox)Login1.FindControl("Username")).Text, true, 2880);
                string encrypted = FormsAuthentication.Encrypt(ticket);
                var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encrypted)
                {
                    Expires = System.DateTime.Now.AddMinutes(2880),
                    HttpOnly = true
                };
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {

        }

        protected void Login1_LoggingIn(object sender, LoginCancelEventArgs e)
        {

        }
    }
}
